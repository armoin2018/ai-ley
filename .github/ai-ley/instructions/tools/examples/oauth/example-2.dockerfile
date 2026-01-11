# Dockerfile for Production OAuth 2.0 Authorization Server
FROM node:18-alpine

# Install security tools and dependencies
RUN apk add --no-cache \
    dumb-init \
    openssl \
    ca-certificates \
    curl \
    jq \
    && npm install -g helmet cors rate-limiter-flexible

WORKDIR /app

# Create non-root user
RUN addgroup -g 1001 -S oauth && \
    adduser -S -D -H -u 1001 -h /app -s /sbin/nologin -G oauth oauth

# Copy package files
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY --chown=oauth:oauth . .

# Set security headers and configurations
ENV NODE_ENV=production
ENV HTTPS_ONLY=true
ENV SECURE_COOKIES=true
ENV CSRF_PROTECTION=true
ENV RATE_LIMITING=true
ENV AUDIT_LOGGING=true

# Security hardening
RUN chmod -R 755 /app && \
    chmod -R 644 /app/config/* && \
    chown -R oauth:oauth /app

# Health check for OAuth server
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f https://localhost:3000/health || exit 1

EXPOSE 3000

USER oauth

ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]