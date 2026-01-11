// auth-server/server.js - Production OAuth 2.0 Authorization Server
const express = require('express');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const { RateLimiterRedis } = require('rate-limiter-flexible');
const Redis = require('ioredis');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { body, validationResult } = require('express-validator');
const winston = require('winston');

// Security Configuration
const app = express();

// Redis for rate limiting and session management
const redis = new Redis(process.env.REDIS_URL);

// Security logger
const securityLogger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json(),
  ),
  transports: [
    new winston.transports.File({
      filename: '/app/audit-logs/security.log',
      level: 'warn',
    }),
    new winston.transports.File({
      filename: '/app/audit-logs/oauth-audit.log',
    }),
  ],
});

// Enhanced Rate Limiting with Redis
const rateLimiter = new RateLimiterRedis({
  storeClient: redis,
  keyPrefix: 'oauth_rl',
  points: 10, // Number of requests
  duration: 60, // Per 60 seconds
  blockDuration: 300, // Block for 5 minutes
});

const authRateLimiter = new RateLimiterRedis({
  storeClient: redis,
  keyPrefix: 'oauth_auth_rl',
  points: 5, // Number of auth attempts
  duration: 900, // Per 15 minutes
  blockDuration: 3600, // Block for 1 hour
});

// Security middleware
app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        styleSrc: ["'self'", "'unsafe-inline'"],
        scriptSrc: ["'self'"],
        imgSrc: ["'self'", 'data:', 'https:'],
        connectSrc: ["'self'"],
        fontSrc: ["'self'"],
        objectSrc: ["'none'"],
        mediaSrc: ["'self'"],
        frameSrc: ["'none'"],
      },
    },
    hsts: {
      maxAge: 31536000,
      includeSubDomains: true,
      preload: true,
    },
  }),
);

app.use(express.json({ limit: '10kb' }));
app.use(express.urlencoded({ extended: false, limit: '10kb' }));

// Rate limiting middleware
const rateLimitMiddleware = async (req, res, next) => {
  try {
    await rateLimiter.consume(req.ip);
    next();
  } catch (rejRes) {
    securityLogger.warn('Rate limit exceeded', {
      ip: req.ip,
      userAgent: req.get('User-Agent'),
      endpoint: req.path,
      remainingPoints: rejRes.remainingPoints || 0,
      msBeforeNext: rejRes.msBeforeNext || 0,
    });

    res.status(429).json({
      error: 'too_many_requests',
      error_description: 'Rate limit exceeded',
      retry_after: Math.round(rejRes.msBeforeNext / 1000) || 300,
    });
  }
};

app.use(rateLimitMiddleware);

// OAuth 2.0 Client Management
class OAuthClientManager {
  constructor() {
    this.clients = new Map();
    this.loadClients();
  }

  async loadClients() {
    // Load clients from secure database
    // Implementation would connect to PostgreSQL
  }

  async validateClient(clientId, clientSecret = null, grantType = null) {
    const client = this.clients.get(clientId);

    if (!client) {
      securityLogger.warn('Invalid client ID attempted', { clientId });
      return null;
    }

    // Validate client secret for confidential clients
    if (client.type === 'confidential' && clientSecret) {
      const isValidSecret = await bcrypt.compare(clientSecret, client.hashedSecret);
      if (!isValidSecret) {
        securityLogger.warn('Invalid client secret', { clientId });
        return null;
      }
    }

    // Validate grant type
    if (grantType && !client.allowedGrantTypes.includes(grantType)) {
      securityLogger.warn('Unauthorized grant type', { clientId, grantType });
      return null;
    }

    return client;
  }

  validateRedirectUri(clientId, redirectUri) {
    const client = this.clients.get(clientId);
    if (!client) return false;

    // Exact match for security
    return client.redirectUris.includes(redirectUri);
  }
}

// PKCE (Proof Key for Code Exchange) Implementation
class PKCEManager {
  generateCodeChallenge() {
    const codeVerifier = crypto.randomBytes(32).toString('base64url');
    const codeChallenge = crypto.createHash('sha256').update(codeVerifier).digest('base64url');

    return { codeVerifier, codeChallenge };
  }

  verifyCodeChallenge(codeVerifier, codeChallenge, method = 'S256') {
    if (method === 'S256') {
      const computedChallenge = crypto
        .createHash('sha256')
        .update(codeVerifier)
        .digest('base64url');
      return computedChallenge === codeChallenge;
    }

    if (method === 'plain') {
      return codeVerifier === codeChallenge;
    }

    return false;
  }
}

// Authorization Code Management
class AuthorizationCodeManager {
  constructor() {
    this.codes = new Map();
  }

  async generateCode(clientId, userId, scope, redirectUri, codeChallenge = null) {
    const code = crypto.randomBytes(32).toString('hex');
    const expiresAt = Date.now() + 10 * 60 * 1000; // 10 minutes

    const codeData = {
      clientId,
      userId,
      scope,
      redirectUri,
      codeChallenge,
      expiresAt,
      used: false,
    };

    this.codes.set(code, codeData);

    // Store in Redis with TTL
    await redis.setex(`auth_code:${code}`, 600, JSON.stringify(codeData));

    securityLogger.info('Authorization code generated', {
      clientId,
      userId,
      scope,
      codeLength: code.length,
    });

    return code;
  }

  async validateAndConsumeCode(code, clientId, redirectUri, codeVerifier = null) {
    const codeData = await redis.get(`auth_code:${code}`);

    if (!codeData) {
      securityLogger.warn('Invalid or expired authorization code', {
        code: code.substring(0, 8) + '...',
      });
      return null;
    }

    const parsedData = JSON.parse(codeData);

    if (parsedData.used) {
      securityLogger.warn('Authorization code reuse attempt', {
        clientId,
        code: code.substring(0, 8) + '...',
      });
      return null;
    }

    if (parsedData.clientId !== clientId) {
      securityLogger.warn('Client ID mismatch for authorization code', {
        expectedClientId: parsedData.clientId,
        providedClientId: clientId,
      });
      return null;
    }

    if (parsedData.redirectUri !== redirectUri) {
      securityLogger.warn('Redirect URI mismatch for authorization code', {
        expectedUri: parsedData.redirectUri,
        providedUri: redirectUri,
      });
      return null;
    }

    if (Date.now() > parsedData.expiresAt) {
      securityLogger.warn('Expired authorization code', { code: code.substring(0, 8) + '...' });
      await redis.del(`auth_code:${code}`);
      return null;
    }

    // Validate PKCE if present
    if (parsedData.codeChallenge && codeVerifier) {
      const pkce = new PKCEManager();
      if (!pkce.verifyCodeChallenge(codeVerifier, parsedData.codeChallenge)) {
        securityLogger.warn('PKCE verification failed', { clientId });
        return null;
      }
    }

    // Mark as used and delete
    await redis.del(`auth_code:${code}`);

    securityLogger.info('Authorization code successfully exchanged', {
      clientId,
      userId: parsedData.userId,
      scope: parsedData.scope,
    });

    return parsedData;
  }
}

// JWT Token Management with Enhanced Security
class TokenManager {
  constructor() {
    this.jwtSecret = fs.readFileSync(process.env.JWT_SECRET_FILE, 'utf8');
    this.refreshTokens = new Map();
  }

  generateAccessToken(userId, clientId, scope) {
    const payload = {
      sub: userId,
      aud: clientId,
      scope: scope,
      iat: Math.floor(Date.now() / 1000),
      exp: Math.floor(Date.now() / 1000) + parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
      jti: crypto.randomUUID(),
      iss: 'oauth-server',
    };

    return jwt.sign(payload, this.jwtSecret, { algorithm: 'HS256' });
  }

  async generateRefreshToken(userId, clientId, scope) {
    const refreshToken = crypto.randomBytes(64).toString('hex');
    const expiresAt = Date.now() + parseInt(process.env.TOKEN_EXPIRY_REFRESH || 86400) * 1000;

    const tokenData = {
      userId,
      clientId,
      scope,
      expiresAt,
      used: false,
    };

    this.refreshTokens.set(refreshToken, tokenData);

    // Store in Redis with TTL
    await redis.setex(
      `refresh_token:${refreshToken}`,
      parseInt(process.env.TOKEN_EXPIRY_REFRESH || 86400),
      JSON.stringify(tokenData),
    );

    securityLogger.info('Refresh token generated', {
      userId,
      clientId,
      scope,
      tokenLength: refreshToken.length,
    });

    return refreshToken;
  }

  async validateRefreshToken(refreshToken, clientId) {
    const tokenData = await redis.get(`refresh_token:${refreshToken}`);

    if (!tokenData) {
      securityLogger.warn('Invalid or expired refresh token', {
        token: refreshToken.substring(0, 8) + '...',
        clientId,
      });
      return null;
    }

    const parsedData = JSON.parse(tokenData);

    if (parsedData.clientId !== clientId) {
      securityLogger.warn('Client ID mismatch for refresh token', {
        expectedClientId: parsedData.clientId,
        providedClientId: clientId,
      });
      return null;
    }

    if (Date.now() > parsedData.expiresAt) {
      securityLogger.warn('Expired refresh token', {
        token: refreshToken.substring(0, 8) + '...',
      });
      await redis.del(`refresh_token:${refreshToken}`);
      return null;
    }

    return parsedData;
  }

  async revokeRefreshToken(refreshToken) {
    await redis.del(`refresh_token:${refreshToken}`);
    securityLogger.info('Refresh token revoked', {
      token: refreshToken.substring(0, 8) + '...',
    });
  }
}

// Initialize managers
const clientManager = new OAuthClientManager();
const codeManager = new AuthorizationCodeManager();
const tokenManager = new TokenManager();

// Authorization endpoint with enhanced security
app.get(
  '/authorize',
  [
    body('client_id').isLength({ min: 1 }).escape(),
    body('redirect_uri').isURL(),
    body('response_type').equals('code'),
    body('scope').optional().isLength({ max: 200 }).escape(),
    body('state').isLength({ min: 8, max: 128 }).escape(),
    body('code_challenge').optional().isLength({ min: 43, max: 128 }),
    body('code_challenge_method').optional().isIn(['S256', 'plain']),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      securityLogger.warn('Invalid authorization request parameters', {
        ip: req.ip,
        errors: errors.array(),
        query: req.query,
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'Invalid request parameters',
      });
    }

    const {
      client_id,
      redirect_uri,
      response_type,
      scope = 'read',
      state,
      code_challenge,
      code_challenge_method = 'S256',
    } = req.query;

    // Validate client
    const client = await clientManager.validateClient(client_id, null, 'authorization_code');
    if (!client) {
      securityLogger.warn('Authorization request with invalid client', {
        ip: req.ip,
        clientId: client_id,
        redirectUri: redirect_uri,
      });
      return res.status(400).json({
        error: 'invalid_client',
        error_description: 'Invalid client identifier',
      });
    }

    // Validate redirect URI
    if (!clientManager.validateRedirectUri(client_id, redirect_uri)) {
      securityLogger.warn('Authorization request with invalid redirect URI', {
        ip: req.ip,
        clientId: client_id,
        redirectUri: redirect_uri,
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'Invalid redirect URI',
      });
    }

    // PKCE is required for public clients
    if (client.type === 'public' && !code_challenge) {
      securityLogger.warn('Public client authorization without PKCE', {
        ip: req.ip,
        clientId: client_id,
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'PKCE required for public clients',
      });
    }

    // For demo purposes, auto-approve (in production, show consent screen)
    const userId = 'demo_user_123'; // In production, get from authenticated session

    try {
      const authCode = await codeManager.generateCode(
        client_id,
        userId,
        scope,
        redirect_uri,
        code_challenge,
      );

      const redirectUrl = new URL(redirect_uri);
      redirectUrl.searchParams.set('code', authCode);
      redirectUrl.searchParams.set('state', state);

      securityLogger.info('Authorization code issued', {
        clientId: client_id,
        userId,
        scope,
        redirectUri: redirect_uri,
      });

      res.redirect(redirectUrl.toString());
    } catch (error) {
      securityLogger.error('Error generating authorization code', {
        error: error.message,
        clientId: client_id,
        userId,
      });

      const errorUrl = new URL(redirect_uri);
      errorUrl.searchParams.set('error', 'server_error');
      errorUrl.searchParams.set('error_description', 'Internal server error');
      errorUrl.searchParams.set('state', state);

      res.redirect(errorUrl.toString());
    }
  },
);

// Token endpoint with enhanced security
app.post(
  '/token',
  [
    body('grant_type').isIn(['authorization_code', 'refresh_token', 'client_credentials']),
    body('client_id').isLength({ min: 1 }).escape(),
    body('client_secret').optional().isLength({ min: 1 }),
    body('code').optional().isLength({ min: 1 }),
    body('redirect_uri').optional().isURL(),
    body('code_verifier').optional().isLength({ min: 43, max: 128 }),
    body('refresh_token').optional().isLength({ min: 1 }),
    body('scope').optional().isLength({ max: 200 }).escape(),
  ],
  async (req, res) => {
    // Apply stricter rate limiting for token endpoint
    try {
      await authRateLimiter.consume(req.ip);
    } catch (rejRes) {
      securityLogger.warn('Token endpoint rate limit exceeded', {
        ip: req.ip,
        userAgent: req.get('User-Agent'),
      });

      return res.status(429).json({
        error: 'too_many_requests',
        error_description: 'Too many token requests',
        retry_after: Math.round(rejRes.msBeforeNext / 1000) || 3600,
      });
    }

    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      securityLogger.warn('Invalid token request parameters', {
        ip: req.ip,
        errors: errors.array(),
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'Invalid request parameters',
      });
    }

    const {
      grant_type,
      client_id,
      client_secret,
      code,
      redirect_uri,
      code_verifier,
      refresh_token,
      scope,
    } = req.body;

    try {
      // Validate client
      const client = await clientManager.validateClient(client_id, client_secret, grant_type);
      if (!client) {
        securityLogger.warn('Token request with invalid client credentials', {
          ip: req.ip,
          clientId: client_id,
          grantType: grant_type,
        });
        return res.status(401).json({
          error: 'invalid_client',
          error_description: 'Invalid client credentials',
        });
      }

      if (grant_type === 'authorization_code') {
        // Authorization Code Grant
        const codeData = await codeManager.validateAndConsumeCode(
          code,
          client_id,
          redirect_uri,
          code_verifier,
        );

        if (!codeData) {
          securityLogger.warn('Invalid authorization code in token request', {
            ip: req.ip,
            clientId: client_id,
          });
          return res.status(400).json({
            error: 'invalid_grant',
            error_description: 'Invalid authorization code',
          });
        }

        const accessToken = tokenManager.generateAccessToken(
          codeData.userId,
          client_id,
          codeData.scope,
        );

        const refreshToken = await tokenManager.generateRefreshToken(
          codeData.userId,
          client_id,
          codeData.scope,
        );

        securityLogger.info('Access token issued via authorization code', {
          clientId: client_id,
          userId: codeData.userId,
          scope: codeData.scope,
        });

        res.json({
          access_token: accessToken,
          token_type: 'Bearer',
          expires_in: parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
          refresh_token: refreshToken,
          scope: codeData.scope,
        });
      } else if (grant_type === 'refresh_token') {
        // Refresh Token Grant
        const tokenData = await tokenManager.validateRefreshToken(refresh_token, client_id);

        if (!tokenData) {
          securityLogger.warn('Invalid refresh token in token request', {
            ip: req.ip,
            clientId: client_id,
          });
          return res.status(400).json({
            error: 'invalid_grant',
            error_description: 'Invalid refresh token',
          });
        }

        // Revoke old refresh token
        await tokenManager.revokeRefreshToken(refresh_token);

        const accessToken = tokenManager.generateAccessToken(
          tokenData.userId,
          client_id,
          scope || tokenData.scope,
        );

        const newRefreshToken = await tokenManager.generateRefreshToken(
          tokenData.userId,
          client_id,
          scope || tokenData.scope,
        );

        securityLogger.info('Access token refreshed', {
          clientId: client_id,
          userId: tokenData.userId,
          scope: scope || tokenData.scope,
        });

        res.json({
          access_token: accessToken,
          token_type: 'Bearer',
          expires_in: parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
          refresh_token: newRefreshToken,
          scope: scope || tokenData.scope,
        });
      } else if (grant_type === 'client_credentials') {
        // Client Credentials Grant
        if (client.type !== 'confidential') {
          securityLogger.warn('Public client attempted client credentials grant', {
            ip: req.ip,
            clientId: client_id,
          });
          return res.status(400).json({
            error: 'unauthorized_client',
            error_description: 'Client credentials grant not allowed for this client',
          });
        }

        const accessToken = tokenManager.generateAccessToken(
          null, // No user for client credentials
          client_id,
          scope || client.defaultScope,
        );

        securityLogger.info('Client credentials token issued', {
          clientId: client_id,
          scope: scope || client.defaultScope,
        });

        res.json({
          access_token: accessToken,
          token_type: 'Bearer',
          expires_in: parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
          scope: scope || client.defaultScope,
        });
      }
    } catch (error) {
      securityLogger.error('Error processing token request', {
        error: error.message,
        stack: error.stack,
        ip: req.ip,
        clientId: client_id,
        grantType: grant_type,
      });

      res.status(500).json({
        error: 'server_error',
        error_description: 'Internal server error',
      });
    }
  },
);

// Token introspection endpoint (RFC 7662)
app.post(
  '/introspect',
  [
    body('token').isLength({ min: 1 }),
    body('token_type_hint').optional().isIn(['access_token', 'refresh_token']),
  ],
  async (req, res) => {
    // Client authentication required
    const authHeader = req.get('Authorization');
    if (!authHeader || !authHeader.startsWith('Basic ')) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Client authentication required',
      });
    }

    const credentials = Buffer.from(authHeader.substring(6), 'base64').toString();
    const [clientId, clientSecret] = credentials.split(':');

    const client = await clientManager.validateClient(clientId, clientSecret);
    if (!client) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Invalid client credentials',
      });
    }

    const { token, token_type_hint } = req.body;

    try {
      // Verify JWT token
      const decoded = jwt.verify(token, tokenManager.jwtSecret);

      // Check if token is for this client
      if (decoded.aud !== clientId) {
        return res.json({ active: false });
      }

      securityLogger.info('Token introspection successful', {
        clientId,
        tokenSubject: decoded.sub,
        tokenAudience: decoded.aud,
      });

      res.json({
        active: true,
        scope: decoded.scope,
        client_id: decoded.aud,
        username: decoded.sub,
        token_type: 'Bearer',
        exp: decoded.exp,
        iat: decoded.iat,
        sub: decoded.sub,
        aud: decoded.aud,
        iss: decoded.iss,
        jti: decoded.jti,
      });
    } catch (error) {
      securityLogger.warn('Invalid token in introspection request', {
        clientId,
        tokenHint: token_type_hint,
        error: error.message,
      });

      res.json({ active: false });
    }
  },
);

// Token revocation endpoint (RFC 7009)
app.post(
  '/revoke',
  [
    body('token').isLength({ min: 1 }),
    body('token_type_hint').optional().isIn(['access_token', 'refresh_token']),
  ],
  async (req, res) => {
    // Client authentication required
    const authHeader = req.get('Authorization');
    if (!authHeader || !authHeader.startsWith('Basic ')) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Client authentication required',
      });
    }

    const credentials = Buffer.from(authHeader.substring(6), 'base64').toString();
    const [clientId, clientSecret] = credentials.split(':');

    const client = await clientManager.validateClient(clientId, clientSecret);
    if (!client) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Invalid client credentials',
      });
    }

    const { token, token_type_hint } = req.body;

    try {
      if (token_type_hint === 'refresh_token' || !token_type_hint) {
        // Try to revoke as refresh token
        await tokenManager.revokeRefreshToken(token);
      }

      securityLogger.info('Token revoked', {
        clientId,
        tokenHint: token_type_hint,
      });

      res.status(200).end();
    } catch (error) {
      securityLogger.error('Error revoking token', {
        error: error.message,
        clientId,
        tokenHint: token_type_hint,
      });

      res.status(500).json({
        error: 'server_error',
        error_description: 'Unable to revoke token',
      });
    }
  },
);

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: process.env.npm_package_version || '1.0.0',
  });
});

// Security headers middleware
app.use((req, res, next) => {
  res.set({
    'X-Frame-Options': 'DENY',
    'X-Content-Type-Options': 'nosniff',
    'X-XSS-Protection': '1; mode=block',
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    'Permissions-Policy': 'geolocation=(), microphone=(), camera=()',
  });
  next();
});

// Error handling middleware
app.use((error, req, res, next) => {
  securityLogger.error('Unhandled error', {
    error: error.message,
    stack: error.stack,
    ip: req.ip,
    method: req.method,
    url: req.url,
  });

  res.status(500).json({
    error: 'server_error',
    error_description: 'Internal server error',
  });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`OAuth 2.0 Authorization Server running on port ${PORT}`);
  securityLogger.info('OAuth 2.0 Authorization Server started', { port: PORT });
});

module.exports = app;