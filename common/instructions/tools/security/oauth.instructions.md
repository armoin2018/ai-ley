# OAuth 2.0 Authentication and Authorization Instructions

## Tool Overview
- **Tool Name**: OAuth 2.0
- **Version**: RFC 6749 (OAuth 2.0), RFC 7636 (PKCE), RFC 8252 (Mobile Apps)
- **Category**: Authentication and Authorization Framework
- **Purpose**: Secure, token-based authorization for third-party applications
- **Prerequisites**: HTTPS, client credentials, authorization server

## Installation & Setup

### Python Implementation
```bash
# Install OAuth libraries
pip install authlib requests-oauthlib

# Flask OAuth integration
pip install flask authlib

# Django OAuth integration
pip install django-oauth-toolkit

# FastAPI OAuth integration
pip install python-multipart
```

### Node.js Implementation
```bash
# Install OAuth libraries
npm install passport passport-oauth2 express-session

# OAuth provider libraries
npm install passport-google-oauth20 passport-github2 passport-facebook

# JWT handling
npm install jsonwebtoken

# Express OAuth middleware
npm install express-oauth-server
```

### Client Libraries
```bash
# Frontend OAuth libraries
npm install @auth0/auth0-spa-js
npm install oidc-client-ts

# Mobile OAuth
# iOS: Install via CocoaPods or Swift Package Manager
# Android: Add to build.gradle
implementation 'net.openid:appauth:0.11.1'
```

## Configuration

### OAuth 2.0 Flow Types
```python
# Authorization Code Flow (most secure)
class OAuthConfig:
    """OAuth 2.0 configuration for different flows."""
    
    def __init__(self):
        self.client_id = "your_client_id"
        self.client_secret = "your_client_secret"
        self.redirect_uri = "https://yourapp.com/callback"
        self.scope = "read write"
        self.state = self._generate_state()
        
        # Authorization server endpoints
        self.authorization_endpoint = "https://auth.provider.com/oauth/authorize"
        self.token_endpoint = "https://auth.provider.com/oauth/token"
        self.userinfo_endpoint = "https://auth.provider.com/oauth/userinfo"
        self.revocation_endpoint = "https://auth.provider.com/oauth/revoke"
    
    def _generate_state(self):
        """Generate random state parameter for CSRF protection."""
        import secrets
        return secrets.token_urlsafe(32)
    
    def get_authorization_url(self):
        """Generate authorization URL for Authorization Code Flow."""
        from urllib.parse import urlencode
        
        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'scope': self.scope,
            'state': self.state
        }
        
        return f"{self.authorization_endpoint}?{urlencode(params)}"
    
    def get_authorization_url_with_pkce(self):
        """Generate authorization URL with PKCE for enhanced security."""
        import base64
        import hashlib
        import secrets
        
        # Generate code verifier and challenge
        code_verifier = base64.urlsafe_b64encode(secrets.token_bytes(32)).decode('utf-8').rstrip('=')
        code_challenge = base64.urlsafe_b64encode(
            hashlib.sha256(code_verifier.encode()).digest()
        ).decode('utf-8').rstrip('=')
        
        from urllib.parse import urlencode
        
        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'scope': self.scope,
            'state': self.state,
            'code_challenge': code_challenge,
            'code_challenge_method': 'S256'
        }
        
        # Store code_verifier for token exchange
        self.code_verifier = code_verifier
        
        return f"{self.authorization_endpoint}?{urlencode(params)}"
```

### OAuth Server Implementation
```python
from flask import Flask, request, jsonify, session, redirect
from authlib.integrations.flask_oauth2 import AuthorizationServer, ResourceProtector
from authlib.oauth2.rfc6749 import grants
import secrets
import json
from datetime import datetime, timedelta

app = Flask(__name__)
app.secret_key = 'your-secret-key'

class OAuthAuthorizationServer:
    """Complete OAuth 2.0 Authorization Server implementation."""
    
    def __init__(self, app):
        self.app = app
        self.clients = {}
        self.authorization_codes = {}
        self.access_tokens = {}
        self.refresh_tokens = {}
        self.users = {}
        
        # Initialize authorization server
        self.authorization_server = AuthorizationServer(app)
        self.resource_protector = ResourceProtector()
        
        self._setup_grants()
        self._setup_endpoints()
    
    def _setup_grants(self):
        """Setup OAuth 2.0 grants and token validators."""
        
        # Authorization Code Grant
        class AuthorizationCodeGrant(grants.AuthorizationCodeGrant):
            def save_authorization_code(self, code, request):
                # Save authorization code with expiration
                self.authorization_codes[code] = {
                    'client_id': request.client.client_id,
                    'redirect_uri': request.redirect_uri,
                    'scope': request.scope,
                    'user_id': request.user.id if hasattr(request, 'user') else None,
                    'expires_at': datetime.utcnow() + timedelta(minutes=10),
                    'code_challenge': getattr(request, 'code_challenge', None),
                    'code_challenge_method': getattr(request, 'code_challenge_method', None)
                }
            
            def query_authorization_code(self, code, client):
                # Retrieve and validate authorization code
                code_data = self.authorization_codes.get(code)
                if not code_data:
                    return None
                
                if code_data['client_id'] != client.client_id:
                    return None
                
                if datetime.utcnow() > code_data['expires_at']:
                    del self.authorization_codes[code]
                    return None
                
                return code_data
            
            def delete_authorization_code(self, authorization_code):
                # Delete used authorization code
                if authorization_code in self.authorization_codes:
                    del self.authorization_codes[authorization_code]
            
            def authenticate_user(self, authorization_code):
                # Return user information
                code_data = self.authorization_codes.get(authorization_code)
                if code_data and code_data.get('user_id'):
                    return self.users.get(code_data['user_id'])
                return None
        
        # Client Credentials Grant
        class ClientCredentialsGrant(grants.ClientCredentialsGrant):
            def save_token(self, token, request):
                # Save access token for client credentials
                access_token = token['access_token']
                self.access_tokens[access_token] = {
                    'client_id': request.client.client_id,
                    'scope': token.get('scope'),
                    'expires_at': datetime.utcnow() + timedelta(seconds=token['expires_in']),
                    'token_type': token.get('token_type', 'Bearer')
                }
        
        # Register grants
        self.authorization_server.register_grant(AuthorizationCodeGrant)
        self.authorization_server.register_grant(ClientCredentialsGrant)
    
    def _setup_endpoints(self):
        """Setup OAuth 2.0 endpoints."""
        
        @self.app.route('/oauth/authorize', methods=['GET', 'POST'])
        def authorize():
            if request.method == 'GET':
                # Show authorization page
                return self._render_authorize_page(request)
            
            # Handle authorization decision
            user_id = session.get('user_id')
            if not user_id:
                return redirect('/login')
            
            # Process authorization
            return self.authorization_server.create_authorization_response(request=request)
        
        @self.app.route('/oauth/token', methods=['POST'])
        def issue_token():
            return self.authorization_server.create_token_response(request=request)
        
        @self.app.route('/oauth/revoke', methods=['POST'])
        def revoke_token():
            return self.authorization_server.create_revocation_response(request=request)
        
        @self.app.route('/oauth/userinfo', methods=['GET'])
        @self.resource_protector()
        def get_userinfo():
            # Return user information for valid access token
            token = self.resource_protector.get_token_from_request(request)
            user_id = token.get('user_id')
            
            if user_id and user_id in self.users:
                user = self.users[user_id]
                return jsonify({
                    'sub': user_id,
                    'name': user.get('name'),
                    'email': user.get('email'),
                    'picture': user.get('picture')
                })
            
            return jsonify({'error': 'invalid_token'}), 401
    
    def register_client(self, client_id, client_secret, redirect_uris, grant_types, scope):
        """Register OAuth client application."""
        self.clients[client_id] = {
            'client_id': client_id,
            'client_secret': client_secret,
            'redirect_uris': redirect_uris,
            'grant_types': grant_types,
            'scope': scope,
            'created_at': datetime.utcnow()
        }
    
    def _render_authorize_page(self, request):
        """Render authorization consent page."""
        client_id = request.args.get('client_id')
        scope = request.args.get('scope', '')
        
        if client_id not in self.clients:
            return jsonify({'error': 'invalid_client'}), 400
        
        client = self.clients[client_id]
        
        # In a real implementation, this would render an HTML template
        return f"""
        <html>
        <body>
            <h2>Authorization Request</h2>
            <p>Application "{client_id}" is requesting access to:</p>
            <ul>
                {''.join(f'<li>{s}</li>' for s in scope.split())}
            </ul>
            <form method="post">
                <input type="hidden" name="client_id" value="{client_id}">
                <input type="hidden" name="scope" value="{scope}">
                <button type="submit" name="confirm" value="yes">Allow</button>
                <button type="submit" name="confirm" value="no">Deny</button>
            </form>
        </body>
        </html>
        """

# Initialize OAuth server
oauth_server = OAuthAuthorizationServer(app)

# Register a sample client
oauth_server.register_client(
    client_id='sample_client',
    client_secret='sample_secret',
    redirect_uris=['https://client.app.com/callback'],
    grant_types=['authorization_code', 'refresh_token'],
    scope='read write'
)
```

## Core Features

### OAuth Client Implementation
- **Purpose**: Implement OAuth client to consume protected resources
- **Usage**: Authenticate users and access APIs on their behalf
- **Example**:
```python
import requests
import secrets
import hashlib
import base64
from urllib.parse import urlencode, parse_qs
from datetime import datetime, timedelta

class OAuthClient:
    """OAuth 2.0 client implementation with PKCE support."""
    
    def __init__(self, client_id, client_secret, redirect_uri, authorization_endpoint, token_endpoint):
        self.client_id = client_id
        self.client_secret = client_secret
        self.redirect_uri = redirect_uri
        self.authorization_endpoint = authorization_endpoint
        self.token_endpoint = token_endpoint
        
        self.access_token = None
        self.refresh_token = None
        self.token_expires_at = None
        
    def generate_authorization_url(self, scope=None, state=None, use_pkce=True):
        """Generate authorization URL with optional PKCE."""
        if state is None:
            state = secrets.token_urlsafe(32)
        
        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'state': state
        }
        
        if scope:
            params['scope'] = scope
        
        # Add PKCE parameters for enhanced security
        if use_pkce:
            code_verifier = base64.urlsafe_b64encode(secrets.token_bytes(32)).decode('utf-8').rstrip('=')
            code_challenge = base64.urlsafe_b64encode(
                hashlib.sha256(code_verifier.encode()).digest()
            ).decode('utf-8').rstrip('=')
            
            params['code_challenge'] = code_challenge
            params['code_challenge_method'] = 'S256'
            
            # Store code verifier for token exchange
            self.code_verifier = code_verifier
        
        authorization_url = f"{self.authorization_endpoint}?{urlencode(params)}"
        return authorization_url, state
    
    def exchange_code_for_token(self, authorization_code, state=None, code_verifier=None):
        """Exchange authorization code for access token."""
        token_data = {
            'grant_type': 'authorization_code',
            'code': authorization_code,
            'redirect_uri': self.redirect_uri,
            'client_id': self.client_id
        }
        
        # Add PKCE code verifier if used
        if hasattr(self, 'code_verifier') or code_verifier:
            token_data['code_verifier'] = code_verifier or self.code_verifier
        
        # Use client secret for confidential clients
        if self.client_secret:
            token_data['client_secret'] = self.client_secret
        
        try:
            response = requests.post(
                self.token_endpoint,
                data=token_data,
                headers={'Content-Type': 'application/x-www-form-urlencoded'},
                timeout=30
            )
            
            if response.status_code == 200:
                token_response = response.json()
                
                self.access_token = token_response['access_token']
                self.refresh_token = token_response.get('refresh_token')
                
                # Calculate token expiration
                expires_in = token_response.get('expires_in', 3600)
                self.token_expires_at = datetime.utcnow() + timedelta(seconds=expires_in)
                
                return token_response
            else:
                raise Exception(f"Token exchange failed: {response.status_code} - {response.text}")
                
        except requests.RequestException as e:
            raise Exception(f"Token exchange request failed: {str(e)}")
    
    def refresh_access_token(self):
        """Refresh access token using refresh token."""
        if not self.refresh_token:
            raise Exception("No refresh token available")
        
        token_data = {
            'grant_type': 'refresh_token',
            'refresh_token': self.refresh_token,
            'client_id': self.client_id
        }
        
        if self.client_secret:
            token_data['client_secret'] = self.client_secret
        
        try:
            response = requests.post(
                self.token_endpoint,
                data=token_data,
                headers={'Content-Type': 'application/x-www-form-urlencoded'},
                timeout=30
            )
            
            if response.status_code == 200:
                token_response = response.json()
                
                self.access_token = token_response['access_token']
                
                # Update refresh token if provided
                if 'refresh_token' in token_response:
                    self.refresh_token = token_response['refresh_token']
                
                # Update token expiration
                expires_in = token_response.get('expires_in', 3600)
                self.token_expires_at = datetime.utcnow() + timedelta(seconds=expires_in)
                
                return token_response
            else:
                raise Exception(f"Token refresh failed: {response.status_code} - {response.text}")
                
        except requests.RequestException as e:
            raise Exception(f"Token refresh request failed: {str(e)}")
    
    def is_token_expired(self):
        """Check if access token is expired."""
        if not self.token_expires_at:
            return True
        
        # Add 60-second buffer for network latency
        return datetime.utcnow() >= (self.token_expires_at - timedelta(seconds=60))
    
    def get_valid_token(self):
        """Get valid access token, refreshing if necessary."""
        if not self.access_token or self.is_token_expired():
            if self.refresh_token:
                self.refresh_access_token()
            else:
                raise Exception("No valid access token and no refresh token available")
        
        return self.access_token
    
    def make_authenticated_request(self, url, method='GET', **kwargs):
        """Make authenticated API request with automatic token refresh."""
        token = self.get_valid_token()
        
        # Add authorization header
        headers = kwargs.get('headers', {})
        headers['Authorization'] = f'Bearer {token}'
        kwargs['headers'] = headers
        
        try:
            response = requests.request(method, url, **kwargs)
            
            # Handle token expiration
            if response.status_code == 401:
                # Try to refresh token and retry once
                if self.refresh_token:
                    self.refresh_access_token()
                    headers['Authorization'] = f'Bearer {self.access_token}'
                    response = requests.request(method, url, **kwargs)
            
            return response
            
        except requests.RequestException as e:
            raise Exception(f"Authenticated request failed: {str(e)}")
    
    def revoke_token(self, token_type='access_token'):
        """Revoke access or refresh token."""
        token = self.access_token if token_type == 'access_token' else self.refresh_token
        
        if not token:
            return
        
        revoke_data = {
            'token': token,
            'token_type_hint': token_type,
            'client_id': self.client_id
        }
        
        if self.client_secret:
            revoke_data['client_secret'] = self.client_secret
        
        try:
            response = requests.post(
                self.token_endpoint.replace('/token', '/revoke'),
                data=revoke_data,
                timeout=30
            )
            
            if response.status_code == 200:
                if token_type == 'access_token':
                    self.access_token = None
                    self.token_expires_at = None
                else:
                    self.refresh_token = None
                    
        except requests.RequestException:
            # Revocation endpoint might not be available
            pass

# Usage example
client = OAuthClient(
    client_id='your_client_id',
    client_secret='your_client_secret',
    redirect_uri='https://yourapp.com/callback',
    authorization_endpoint='https://auth.provider.com/oauth/authorize',
    token_endpoint='https://auth.provider.com/oauth/token'
)

# Generate authorization URL
auth_url, state = client.generate_authorization_url(scope='read write', use_pkce=True)
print(f"Visit this URL to authorize: {auth_url}")

# After user authorization, exchange code for token
# authorization_code = 'code_from_callback'
# token_response = client.exchange_code_for_token(authorization_code)

# Make authenticated API requests
# response = client.make_authenticated_request('https://api.provider.com/user')
```

### JWT Token Handling
- **Purpose**: Handle JSON Web Tokens for stateless authentication
- **Usage**: Validate and parse JWT tokens in OAuth flows
- **Example**:
```python
import jwt
import json
import requests
from datetime import datetime, timedelta
from cryptography.hazmat.primitives import serialization

class JWTHandler:
    """JWT token validation and parsing for OAuth."""
    
    def __init__(self, issuer, audience, jwks_uri=None):
        self.issuer = issuer
        self.audience = audience
        self.jwks_uri = jwks_uri
        self.public_keys = {}
        
        if jwks_uri:
            self._fetch_public_keys()
    
    def _fetch_public_keys(self):
        """Fetch public keys from JWKS endpoint."""
        try:
            response = requests.get(self.jwks_uri, timeout=30)
            if response.status_code == 200:
                jwks = response.json()
                
                for key in jwks.get('keys', []):
                    kid = key.get('kid')
                    if kid:
                        self.public_keys[kid] = key
                        
        except requests.RequestException as e:
            print(f"Failed to fetch JWKS: {e}")
    
    def validate_token(self, token, verify_signature=True):
        """Validate JWT token and return payload."""
        try:
            # Decode token header to get key ID
            header = jwt.get_unverified_header(token)
            kid = header.get('kid')
            
            if verify_signature and kid:
                # Get public key for signature verification
                if kid not in self.public_keys:
                    self._fetch_public_keys()
                
                if kid in self.public_keys:
                    public_key = self._convert_jwk_to_pem(self.public_keys[kid])
                else:
                    raise jwt.InvalidTokenError("Public key not found")
            else:
                public_key = None
            
            # Decode and validate token
            payload = jwt.decode(
                token,
                public_key,
                algorithms=['RS256', 'HS256'] if verify_signature else None,
                audience=self.audience,
                issuer=self.issuer,
                options={
                    'verify_signature': verify_signature,
                    'verify_exp': True,
                    'verify_aud': True,
                    'verify_iss': True
                }
            )
            
            return payload
            
        except jwt.ExpiredSignatureError:
            raise Exception("Token has expired")
        except jwt.InvalidAudienceError:
            raise Exception("Invalid audience")
        except jwt.InvalidIssuerError:
            raise Exception("Invalid issuer")
        except jwt.InvalidTokenError as e:
            raise Exception(f"Invalid token: {str(e)}")
    
    def _convert_jwk_to_pem(self, jwk):
        """Convert JWK to PEM format for signature verification."""
        try:
            from jwt.algorithms import RSAAlgorithm
            return RSAAlgorithm.from_jwk(json.dumps(jwk))
        except Exception as e:
            raise Exception(f"Failed to convert JWK to PEM: {str(e)}")
    
    def create_token(self, payload, private_key, algorithm='RS256', expires_in=3600):
        """Create JWT token with given payload."""
        # Add standard claims
        now = datetime.utcnow()
        payload.update({
            'iss': self.issuer,
            'aud': self.audience,
            'iat': now,
            'exp': now + timedelta(seconds=expires_in),
            'jti': secrets.token_hex(16)  # Unique token ID
        })
        
        try:
            token = jwt.encode(payload, private_key, algorithm=algorithm)
            return token
        except Exception as e:
            raise Exception(f"Failed to create token: {str(e)}")

# Usage example
jwt_handler = JWTHandler(
    issuer='https://auth.yourapp.com',
    audience='your-api-audience',
    jwks_uri='https://auth.yourapp.com/.well-known/jwks.json'
)

# Validate incoming JWT token
try:
    payload = jwt_handler.validate_token(access_token)
    user_id = payload.get('sub')
    scopes = payload.get('scope', '').split()
    print(f"Token valid for user {user_id} with scopes: {scopes}")
except Exception as e:
    print(f"Token validation failed: {e}")
```

## Development Workflow
1. **Registration**: Register client application with OAuth provider
2. **Authorization**: Redirect user to authorization server
3. **Code Exchange**: Exchange authorization code for access token
4. **API Access**: Use access token to access protected resources
5. **Token Refresh**: Refresh expired tokens using refresh token

## Best Practices

### Security Implementation
```python
import secrets
import hashlib
import time
from functools import wraps

class OAuthSecurityMiddleware:
    """Security middleware for OAuth implementations."""
    
    def __init__(self):
        self.rate_limits = {}
        self.blocked_ips = set()
        
    def rate_limit(self, max_requests=10, window_minutes=1):
        """Rate limiting decorator for OAuth endpoints."""
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                from flask import request, jsonify
                
                client_ip = request.remote_addr
                current_time = time.time()
                window_seconds = window_minutes * 60
                
                # Clean old entries
                self._cleanup_rate_limits(current_time, window_seconds)
                
                # Check rate limit
                if client_ip in self.rate_limits:
                    requests_in_window = [
                        req_time for req_time in self.rate_limits[client_ip]
                        if current_time - req_time < window_seconds
                    ]
                    
                    if len(requests_in_window) >= max_requests:
                        return jsonify({
                            'error': 'rate_limit_exceeded',
                            'error_description': 'Too many requests'
                        }), 429
                    
                    self.rate_limits[client_ip] = requests_in_window + [current_time]
                else:
                    self.rate_limits[client_ip] = [current_time]
                
                return func(*args, **kwargs)
            return wrapper
        return decorator
    
    def validate_redirect_uri(self, client_id, redirect_uri):
        """Validate redirect URI against registered URIs."""
        # In production, fetch from database
        registered_uris = self._get_client_redirect_uris(client_id)
        
        # Exact match required for security
        if redirect_uri not in registered_uris:
            return False
        
        # Additional security checks
        if not redirect_uri.startswith('https://'):
            # Allow http only for localhost in development
            if not (redirect_uri.startswith('http://localhost') or 
                   redirect_uri.startswith('http://127.0.0.1')):
                return False
        
        return True
    
    def validate_pkce(self, code_verifier, code_challenge, method='S256'):
        """Validate PKCE code verifier against challenge."""
        if not code_verifier or not code_challenge:
            return False
        
        if method == 'S256':
            import base64
            computed_challenge = base64.urlsafe_b64encode(
                hashlib.sha256(code_verifier.encode()).digest()
            ).decode('utf-8').rstrip('=')
            
            return computed_challenge == code_challenge
        elif method == 'plain':
            return code_verifier == code_challenge
        
        return False
    
    def generate_secure_token(self, length=32):
        """Generate cryptographically secure random token."""
        return secrets.token_urlsafe(length)
    
    def validate_scope(self, requested_scope, client_allowed_scopes):
        """Validate requested scope against client permissions."""
        if not requested_scope:
            return []
        
        requested_scopes = requested_scope.split()
        allowed_scopes = client_allowed_scopes.split()
        
        # Check if all requested scopes are allowed
        for scope in requested_scopes:
            if scope not in allowed_scopes:
                return None
        
        return requested_scopes
    
    def _cleanup_rate_limits(self, current_time, window_seconds):
        """Clean up old rate limit entries."""
        for ip in list(self.rate_limits.keys()):
            self.rate_limits[ip] = [
                req_time for req_time in self.rate_limits[ip]
                if current_time - req_time < window_seconds
            ]
            
            if not self.rate_limits[ip]:
                del self.rate_limits[ip]
    
    def _get_client_redirect_uris(self, client_id):
        """Get registered redirect URIs for client."""
        # In production, this would query the database
        return ['https://client.app.com/callback']

# CORS handling for OAuth endpoints
def setup_oauth_cors():
    """Setup CORS for OAuth endpoints."""
    from flask_cors import CORS
    
    # Configure CORS for OAuth endpoints
    cors_config = {
        'origins': ['https://yourapp.com'],
        'methods': ['GET', 'POST'],
        'allow_headers': ['Content-Type', 'Authorization'],
        'expose_headers': ['Content-Type'],
        'max_age': 3600
    }
    
    return cors_config
```

## Common Use Cases

### Single Sign-On (SSO)
**Scenario**: Implement SSO across multiple applications
**Implementation**:
```python
class SSOProvider:
    """Single Sign-On implementation using OAuth 2.0."""
    
    def __init__(self, oauth_server):
        self.oauth_server = oauth_server
        self.active_sessions = {}
    
    def authenticate_user(self, username, password):
        """Authenticate user and create session."""
        # Validate credentials (use secure hashing)
        import bcrypt
        
        user = self._get_user_by_username(username)
        if not user:
            return None
        
        if bcrypt.checkpw(password.encode(), user['password_hash'].encode()):
            # Create SSO session
            session_id = secrets.token_urlsafe(32)
            self.active_sessions[session_id] = {
                'user_id': user['id'],
                'username': username,
                'created_at': datetime.utcnow(),
                'last_accessed': datetime.utcnow()
            }
            
            return session_id
        
        return None
    
    def validate_sso_session(self, session_id):
        """Validate SSO session."""
        if session_id not in self.active_sessions:
            return None
        
        session = self.active_sessions[session_id]
        
        # Check session expiry (e.g., 8 hours)
        if datetime.utcnow() - session['created_at'] > timedelta(hours=8):
            del self.active_sessions[session_id]
            return None
        
        # Update last accessed time
        session['last_accessed'] = datetime.utcnow()
        
        return session
    
    def logout_user(self, session_id):
        """Logout user and invalidate session."""
        if session_id in self.active_sessions:
            del self.active_sessions[session_id]
    
    def _get_user_by_username(self, username):
        """Get user by username from database."""
        # In production, this would query the database
        return {
            'id': '123',
            'username': username,
            'password_hash': '$2b$12$hashed_password_here'
        }

# Mobile app OAuth flow
class MobileOAuthFlow:
    """OAuth flow optimized for mobile applications."""
    
    def __init__(self, client_id, redirect_uri, authorization_endpoint, token_endpoint):
        self.client_id = client_id
        self.redirect_uri = redirect_uri
        self.authorization_endpoint = authorization_endpoint
        self.token_endpoint = token_endpoint
    
    def start_authorization_flow(self, scope=None):
        """Start OAuth flow with PKCE for mobile security."""
        # Generate PKCE parameters
        code_verifier = base64.urlsafe_b64encode(secrets.token_bytes(32)).decode('utf-8').rstrip('=')
        code_challenge = base64.urlsafe_b64encode(
            hashlib.sha256(code_verifier.encode()).digest()
        ).decode('utf-8').rstrip('=')
        
        state = secrets.token_urlsafe(32)
        
        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'code_challenge': code_challenge,
            'code_challenge_method': 'S256',
            'state': state
        }
        
        if scope:
            params['scope'] = scope
        
        authorization_url = f"{self.authorization_endpoint}?{urlencode(params)}"
        
        return {
            'authorization_url': authorization_url,
            'code_verifier': code_verifier,
            'state': state
        }
    
    def handle_callback(self, callback_url, code_verifier, expected_state):
        """Handle OAuth callback and exchange code for token."""
        from urllib.parse import urlparse, parse_qs
        
        # Parse callback URL
        parsed_url = urlparse(callback_url)
        query_params = parse_qs(parsed_url.query)
        
        # Validate state parameter
        received_state = query_params.get('state', [None])[0]
        if received_state != expected_state:
            raise Exception("Invalid state parameter")
        
        # Get authorization code
        authorization_code = query_params.get('code', [None])[0]
        if not authorization_code:
            error = query_params.get('error', [None])[0]
            error_description = query_params.get('error_description', [None])[0]
            raise Exception(f"Authorization failed: {error} - {error_description}")
        
        # Exchange code for token
        token_data = {
            'grant_type': 'authorization_code',
            'code': authorization_code,
            'redirect_uri': self.redirect_uri,
            'client_id': self.client_id,
            'code_verifier': code_verifier
        }
        
        response = requests.post(
            self.token_endpoint,
            data=token_data,
            headers={'Content-Type': 'application/x-www-form-urlencoded'},
            timeout=30
        )
        
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception(f"Token exchange failed: {response.status_code} - {response.text}")
```

## Common Issues & Solutions

### Issue 1: CSRF Attacks
**Problem**: Cross-site request forgery in OAuth flows
**Solution**: Always use and validate state parameter
```python
def validate_oauth_state(received_state, expected_state):
    """Validate OAuth state parameter to prevent CSRF."""
    if not received_state or not expected_state:
        return False
    
    # Use constant-time comparison to prevent timing attacks
    import hmac
    return hmac.compare_digest(received_state, expected_state)
```

### Issue 2: Token Leakage
**Problem**: Access tokens exposed in URLs or logs
**Solution**: Use secure token storage and proper logging
```python
import logging

class SecureTokenStorage:
    """Secure token storage for OAuth applications."""
    
    def __init__(self):
        self.tokens = {}
    
    def store_token(self, user_id, token_data):
        """Store token with encryption."""
        # In production, use proper encryption and secure storage
        self.tokens[user_id] = token_data
        
        # Log without exposing token values
        logging.info(f"Token stored for user {user_id}")
    
    def get_token(self, user_id):
        """Retrieve token securely."""
        return self.tokens.get(user_id)
    
    def remove_token(self, user_id):
        """Remove token securely."""
        if user_id in self.tokens:
            del self.tokens[user_id]
            logging.info(f"Token removed for user {user_id}")
```

## Security Considerations
- Always use HTTPS for OAuth flows
- Implement PKCE for public clients (mobile, SPA)
- Validate redirect URIs strictly
- Use short-lived access tokens with refresh tokens
- Implement proper token storage and handling
- Rate limit OAuth endpoints
- Validate state parameter to prevent CSRF
- Use secure random number generation

## AI Assistant Guidelines
When helping with OAuth 2.0 implementation:

1. **Always emphasize HTTPS requirement** for production OAuth flows
2. **Recommend PKCE for public clients** to prevent authorization code interception
3. **Include proper state validation** to prevent CSRF attacks
4. **Suggest secure token storage** methods for different client types
5. **Implement rate limiting** on OAuth endpoints
6. **Follow OAuth 2.0 Security Best Practices** (RFC 6819)
7. **Validate redirect URIs strictly** against registered URIs
8. **Include proper error handling** and logging without exposing sensitive data

### Code Generation Rules
- Generate OAuth implementations following RFC 6749 specifications
- Include comprehensive security validations and error handling
- Use cryptographically secure random number generation
- Implement proper token lifecycle management
- Follow OAuth security best practices and recommendations
- Include rate limiting and abuse prevention mechanisms
- Generate modular code suitable for different OAuth flows
- Provide clear documentation of security considerations