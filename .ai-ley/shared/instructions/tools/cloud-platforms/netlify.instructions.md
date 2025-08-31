---
title: 'Netlify JAMstack Deployment Platform Instructions'
description: 'Comprehensive guide for using Netlify for modern web application deployment, continuous deployment, serverless functions, and edge computing'
category: 'Cloud Platforms'

tags:
  [
    'netlify',
    'jamstack',
    'deployment',
    'serverless',
    'edge-functions',
    'cdn',
    'continuous-deployment',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/netlify.toml'
  - '**/_redirects'
  - '**/_headers'
  - '**/netlify/**'
  - '**/functions/**'
  - '**/.netlify/**'
---

# Netlify JAMstack Deployment Platform Instructions

## Tool Overview

- **Tool Name**: Netlify
- **Version**: Platform service with CLI 17.0+ (Latest stable with Edge Functions support)
- **Category**: Cloud Platforms - JAMstack Deployment
- **Purpose**: Deploy static sites and JAMstack applications with continuous deployment, serverless functions, and global CDN
- **Prerequisites**: Git repository, modern web application (React, Vue, Angular, static sites), Node.js for CLI

## When to Use Netlify

### ✅ **Use Netlify When**

- Deploying JAMstack applications (static sites with dynamic functionality)
- Need fast global CDN with automatic HTTPS and custom domains
- Want simple continuous deployment from Git repositories
- Building React, Vue, Angular, or other frontend framework applications
- Need serverless functions for backend functionality without managing servers
- Want branch previews and deploy previews for development workflow
- Need form handling, identity management, or analytics for static sites
- Working with static site generators (Gatsby, Next.js, Nuxt, Hugo, Jekyll)
- Want simple A/B testing and feature flags for frontend applications

### ❌ **Avoid Netlify When**

- Building complex backend applications requiring persistent databases
- Need full server-side rendering with complex server logic
- Working with applications requiring dedicated server resources
- Need extensive backend services beyond serverless functions
- Building real-time applications requiring WebSocket connections
- Working with legacy applications not suited for JAMstack architecture
- Need enterprise-level compliance requirements not met by Netlify

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type          | Netlify Recommendation                     | Configuration Priority     |
| --------------------- | ------------------------------------------ | -------------------------- |
| React/Vue/Angular SPA | ✅ **Essential** - Perfect fit             | High - Build optimization  |
| Static Website        | ✅ **Essential** - Excellent performance   | High - CDN + forms         |
| JAMstack E-commerce   | ✅ **Essential** - Serverless functions    | High - Payment integration |
| Documentation Site    | ✅ **Recommended** - Fast deployment       | Medium - Basic setup       |
| Portfolio Website     | ✅ **Recommended** - Easy management       | Medium - Custom domain     |
| Enterprise Web App    | 🔄 **Consider** - May need enterprise plan | Medium - Security features |

### Complexity Assessment

| Factor            | Low Complexity            | Medium Complexity           | High Complexity          |
| ----------------- | ------------------------- | --------------------------- | ------------------------ |
| **Setup Time**    | 15 minutes (basic deploy) | 2 hours (functions + forms) | 1 day (enterprise setup) |
| **Features Used** | Static hosting + CDN      | Functions + forms           | Full platform features   |
| **Build Process** | Simple static build       | Framework builds            | Complex build pipelines  |
| **Backend Needs** | None                      | Serverless functions        | External services        |

## Installation & Setup

### Netlify CLI Installation

```bash
# npm installation (recommended)
npm install -g netlify-cli

# yarn installation
yarn global add netlify-cli

# pnpm installation
pnpm add -g netlify-cli

# Verify installation
netlify --version
ntl --version  # Short alias

# Login to Netlify
netlify login
netlify auth:login
```

### Project Integration

```bash
# Initialize Netlify in existing project
cd your-project
netlify init

# Link existing site
netlify link

# Create new site
netlify sites:create --name your-site-name

# Deploy from command line
netlify deploy
netlify deploy --prod  # Production deployment

# Start local development server
netlify dev
```

### Git Repository Setup

```bash
# Initialize Git repository (if not already done)
git init
git add .
git commit -m "Initial commit"

# Add remote repository (GitHub, GitLab, Bitbucket)
git remote add origin https://github.com/username/your-project.git
git push -u origin main

# Netlify will automatically detect and deploy from Git
```

## Configuration

### netlify.toml Configuration

```toml
# netlify.toml - Main configuration file

[build]
  # Build command
  command = "npm run build"

  # Directory to publish (build output)
  publish = "dist"

  # Base directory for build
  base = "."

  # Environment variables for build
  environment = { NODE_VERSION = "18", YARN_VERSION = "1.22.19" }

# Production deploy settings
[build.production]
  command = "npm run build:prod"
  publish = "dist"

# Deploy preview settings (pull requests)
[build.deploy-preview]
  command = "npm run build:preview"
  publish = "dist"

# Branch deploy settings
[build.branch-deploy]
  command = "npm run build:dev"
  publish = "dist"

# Redirect rules
[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/:splat"
  status = 200

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
  conditions = {Role = ["admin"], Country = ["US"]}

# Header rules
[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "no-referrer"
    Content-Security-Policy = "default-src 'self'"

[[headers]]
  for = "/assets/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"

# Edge Functions
[[edge_functions]]
  function = "geolocation"
  path = "/api/location"

# Plugin configuration
[[plugins]]
  package = "@netlify/plugin-nextjs"

[[plugins]]
  package = "netlify-plugin-cypress"
  [plugins.inputs]
    enable = true

# Environment-specific settings
[context.production.environment]
  NODE_ENV = "production"
  REACT_APP_API_URL = "https://api.yoursite.com"

[context.deploy-preview.environment]
  NODE_ENV = "staging"
  REACT_APP_API_URL = "https://staging-api.yoursite.com"

[context.branch-deploy.environment]
  NODE_ENV = "development"
  REACT_APP_API_URL = "https://dev-api.yoursite.com"
```

### Advanced React/Next.js Configuration

```toml
# netlify.toml for React/Next.js applications

[build]
  command = "npm run build"
  publish = ".next"

# Next.js specific settings
[build.environment]
  NODE_VERSION = "18"
  NPM_FLAGS = "--legacy-peer-deps"
  NEXT_TELEMETRY_DISABLED = "1"

# Redirects for client-side routing
[[redirects]]
  from = "/_next/static/*"
  to = "/_next/static/:splat"
  status = 200
  headers = {Cache-Control = "public, max-age=31536000, immutable"}

[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/:splat"
  status = 200

# SPA fallback
[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

# Security headers
[[headers]]
  for = "/*"
  [headers.values]
    Strict-Transport-Security = "max-age=63072000; includeSubDomains; preload"
    Content-Security-Policy = "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'"
    X-Content-Type-Options = "nosniff"
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"

# Prerendering for SEO
[build.processing]
  skip_processing = false

[build.processing.css]
  bundle = true
  minify = true

[build.processing.js]
  bundle = true
  minify = true

[build.processing.html]
  pretty_urls = true
```

### \_redirects File Configuration

```bash
# _redirects file for client-side routing and API proxying

# API proxy
/api/*  /.netlify/functions/:splat  200

# Legacy URL redirects
/old-page  /new-page  301
/blog/old-post  /blog/new-post  301

# SPA routing (must be last)
/*  /index.html  200

# Country-based redirects
/  /us  302  Country=us
/  /ca  302  Country=ca
/  /uk  302  Country=gb

# Role-based redirects
/admin/*  /login  302  Role=!admin
/dashboard/*  /login  302  Role=!user,!admin

# Language redirects
/  /en  302  Language=en
/  /fr  302  Language=fr
/  /es  302  Language=es
```

### \_headers File Configuration

```bash
# _headers file for custom HTTP headers

# Global headers
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: no-referrer
  X-XSS-Protection: 1; mode=block

# Cache headers for static assets
/static/*
  Cache-Control: public, max-age=31536000, immutable

/assets/*
  Cache-Control: public, max-age=31536000, immutable

# API headers
/api/*
  Access-Control-Allow-Origin: *
  Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
  Access-Control-Allow-Headers: Content-Type, Authorization

# Security headers for sensitive pages
/admin/*
  Strict-Transport-Security: max-age=63072000; includeSubDomains; preload
  Content-Security-Policy: default-src 'self'; script-src 'self'

# CORS headers for fonts
/fonts/*
  Access-Control-Allow-Origin: *
```

## Core Features

### Continuous Deployment

- **Purpose**: Automatically deploy applications when code is pushed to Git repository
- **Usage**: Connect Git repository for automatic builds and deployments
- **Example**:

```bash
# Connect repository via Netlify dashboard or CLI
netlify sites:create --name my-awesome-app

# Configure build settings
netlify build --dry  # Test build locally

# Deploy specific branch
git checkout feature/new-ui
git push origin feature/new-ui
# Netlify automatically creates deploy preview

# Production deployment
git checkout main
git push origin main
# Automatically deploys to production
```

### Serverless Functions

- **Purpose**: Add backend functionality without managing servers
- **Usage**: Create API endpoints, form handlers, and background processing
- **Example**:

```javascript
// netlify/functions/hello.js
exports.handler = async (event, context) => {
  const { name = 'World' } = event.queryStringParameters || {};

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
    body: JSON.stringify({
      message: `Hello, ${name}!`,
      timestamp: new Date().toISOString(),
    }),
  };
};

// netlify/functions/form-handler.js
exports.handler = async (event, context) => {
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' }),
    };
  }

  const data = JSON.parse(event.body);

  // Process form data
  console.log('Form submission:', data);

  // Send email, save to database, etc.

  return {
    statusCode: 200,
    body: JSON.stringify({ success: true, message: 'Form submitted successfully' }),
  };
};

// Usage from frontend
fetch('/.netlify/functions/hello?name=Alice')
  .then((response) => response.json())
  .then((data) => console.log(data));
```

### Form Handling

- **Purpose**: Handle form submissions without backend infrastructure
- **Usage**: Collect contact forms, newsletter signups, and user feedback
- **Example**:

```html
<!-- HTML form with Netlify handling -->
<form name="contact" method="POST" data-netlify="true" data-netlify-honeypot="bot-field">
  <input type="hidden" name="form-name" value="contact" />

  <!-- Honeypot field for spam protection -->
  <p hidden>
    <label>Don't fill this out: <input name="bot-field" /></label>
  </p>

  <p>
    <label>Name: <input type="text" name="name" required /></label>
  </p>
  <p>
    <label>Email: <input type="email" name="email" required /></label>
  </p>
  <p>
    <label>Message: <textarea name="message" required></textarea></label>
  </p>
  <p>
    <button type="submit">Send</button>
  </p>
</form>

<!-- React form component -->
import React, { useState } from 'react'; function ContactForm() { const [formData, setFormData] =
useState({ name: '', email: '', message: '' }); const [isSubmitting, setIsSubmitting] =
useState(false); const handleSubmit = async (e) => { e.preventDefault(); setIsSubmitting(true); try
{ await fetch('/', { method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded'
}, body: new URLSearchParams({ 'form-name': 'contact', ...formData }).toString() }); alert('Thank
you for your message!'); setFormData({ name: '', email: '', message: '' }); } catch (error) {
alert('Error submitting form. Please try again.'); } finally { setIsSubmitting(false); } }; return (
<form onSubmit="{handleSubmit}" data-netlify="true" name="contact">
  <input type="hidden" name="form-name" value="contact" />
  {/* Form fields */}
</form>
); }
```

### Edge Functions

- **Purpose**: Run code at the edge for personalization and performance
- **Usage**: Geographic personalization, A/B testing, authentication
- **Example**:

```javascript
// netlify/edge-functions/geolocation.js
export default async (request, context) => {
  const country = context.geo?.country?.code || 'US';
  const city = context.geo?.city || 'Unknown';

  const url = new URL(request.url);

  // Redirect based on location
  if (url.pathname === '/') {
    if (country === 'CA') {
      return Response.redirect(`${url.origin}/ca`, 302);
    }
    if (country === 'GB') {
      return Response.redirect(`${url.origin}/uk`, 302);
    }
  }

  // Add location headers
  const response = await context.next();
  response.headers.set('X-Country', country);
  response.headers.set('X-City', city);

  return response;
};

// netlify/edge-functions/auth.js
export default async (request, context) => {
  const url = new URL(request.url);

  // Check authentication for protected routes
  if (url.pathname.startsWith('/dashboard')) {
    const token = request.headers.get('Authorization') ||
                  context.cookies.get('auth-token');

    if (!token) {
      return Response.redirect(`${url.origin}/login`, 302);
    }

    // Validate token
    try {
      await validateToken(token);
    } catch (error) {
      return Response.redirect(`${url.origin}/login`, 302);
    }
  }

  return context.next();
};

export const config = {
  path: ["/dashboard/*", "/admin/*"]
};
```

## Common Commands

```bash
# Essential daily commands
netlify status                         # Check login and site status
netlify deploy                         # Deploy to draft URL
netlify deploy --prod                  # Deploy to production
netlify dev                           # Start local development server

# Site management
netlify sites:list                     # List all sites
netlify sites:create --name my-site    # Create new site
netlify sites:delete                   # Delete site
netlify link                          # Link local project to site

# Function development
netlify functions:list                 # List all functions
netlify functions:create               # Create new function
netlify functions:invoke hello         # Test function locally
netlify functions:build               # Build functions

# Build and deployment
netlify build                         # Run build locally
netlify build --dry                   # Dry run build
netlify deploy --build               # Build and deploy
netlify deploy --alias preview       # Deploy with custom alias

# Environment management
netlify env:list                      # List environment variables
netlify env:set VAR_NAME value        # Set environment variable
netlify env:unset VAR_NAME           # Remove environment variable
netlify env:import .env              # Import from .env file

# Domain and DNS
netlify domains:list                  # List domains
netlify domains:create example.com    # Add custom domain
netlify dns:create example.com A     # Create DNS record

# Analytics and logs
netlify logs                         # View function logs
netlify analytics                    # View site analytics
netlify addons:list                  # List available add-ons
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use `netlify dev` for local testing with functions and redirects
2. **Feature Development**: Create feature branches for deploy previews
3. **Testing**: Automatic deploy previews for every pull request
4. **Production**: Merge to main branch triggers production deployment
5. **Monitoring**: Use analytics and function logs for performance monitoring

### CI/CD Integration with GitHub Actions

```yaml
# .github/workflows/netlify.yml
name: Netlify Deploy
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      - name: Run tests
        run: npm test

      - name: Build project
        run: npm run build
        env:
          REACT_APP_API_URL: ${{ secrets.API_URL }}

      - name: Deploy to Netlify
        uses: nwtgck/actions-netlify@v2.0
        with:
          publish-dir: './dist'
          production-branch: main
          github-token: ${{ secrets.GITHUB_TOKEN }}
          deploy-message: 'Deploy from GitHub Actions'
        env:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "dev": "netlify dev",
    "build": "vite build",
    "build:prod": "NODE_ENV=production vite build",
    "preview": "vite preview",
    "deploy": "netlify deploy",
    "deploy:prod": "netlify deploy --prod",
    "functions:serve": "netlify-lambda serve netlify/functions",
    "functions:build": "netlify-lambda build netlify/functions",
    "test:functions": "netlify functions:invoke",
    "start": "netlify dev"
  },
  "devDependencies": {
    "netlify-cli": "^17.0.0",
    "netlify-lambda": "^2.0.0"
  }
}
```

## Best Practices

### ✅ **Deployment Best Practices**

- **Use branch deploys** - Set up automatic deploy previews for all branches
- **Configure build settings** - Optimize build commands and publish directories
- **Set up custom domains** - Use custom domains with automatic HTTPS
- **Implement redirects properly** - Handle SPA routing and legacy URL redirects
- **Use environment variables** - Store secrets and configuration in Netlify environment
- **Monitor build performance** - Optimize build times and bundle sizes

### ✅ **Performance Optimization**

- **Enable asset optimization** - Use Netlify's built-in CSS and JS minification
- **Configure caching headers** - Set appropriate cache headers for static assets
- **Use CDN effectively** - Leverage Netlify's global CDN for fast content delivery
- **Optimize images** - Use Netlify Image CDN or optimize images before deployment
- **Implement prerendering** - Use static generation for better SEO and performance
- **Monitor Core Web Vitals** - Track performance metrics and optimize accordingly

### ✅ **Security Best Practices**

- **Set security headers** - Configure CSP, HSTS, and other security headers
- **Use HTTPS everywhere** - Netlify provides automatic HTTPS for all sites
- **Implement proper authentication** - Use Netlify Identity or third-party auth
- **Validate form inputs** - Add validation to forms and serverless functions
- **Monitor function logs** - Check function logs for errors and security issues
- **Use environment variables** - Never commit secrets to repository

### ❌ **Common Pitfalls to Avoid**

- **Don't commit build artifacts** - Add build directories to .gitignore
- **Avoid large file uploads** - Use external storage for large media files
- **Don't hardcode URLs** - Use environment variables for different environments
- **Avoid client-side secrets** - Sensitive data should only be in serverless functions
- **Don't ignore build errors** - Fix build warnings and errors promptly
- **Avoid complex server logic** - Keep serverless functions simple and focused

## Advanced Netlify Usage

### Split Testing and Feature Flags

```toml
# netlify.toml - A/B testing configuration
[build]
  command = "npm run build"
  publish = "dist"

# Split testing
[[split_tests]]
  id = "homepage-test"
  path = "/"
  branches = [
    { branch = "main", percentage = 50 },
    { branch = "new-homepage", percentage = 50 }
  ]

# Feature flags
[[edge_functions]]
  function = "feature-flags"
  path = "/*"
```

```javascript
// netlify/edge-functions/feature-flags.js
export default async (request, context) => {
  const url = new URL(request.url);
  const userId = context.cookies.get('user-id');

  // Feature flag logic
  const showNewFeature = shouldShowFeature(userId, 'new-dashboard');

  if (showNewFeature && url.pathname === '/dashboard') {
    return Response.redirect(`${url.origin}/dashboard-v2`, 302);
  }

  return context.next();
};

function shouldShowFeature(userId, featureName) {
  // Implement feature flag logic
  const hash = simpleHash(userId + featureName);
  return hash % 100 < 25; // 25% of users see new feature
}
```

### Large Media and Asset Optimization

```toml
# netlify.toml - Large Media configuration
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "18"

# Large Media settings
[large_media]
  track_files = ["*.jpg", "*.png", "*.gif", "*.pdf", "*.zip"]

# Image optimization
[[plugins]]
  package = "@netlify/plugin-nextjs"

[[plugins]]
  package = "netlify-plugin-image-optim"
```

### Advanced Serverless Functions

```javascript
// netlify/functions/api-proxy.js
const https = require('https');

exports.handler = async (event, context) => {
  const { httpMethod, path, headers, body } = event;

  // CORS headers
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  };

  if (httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: corsHeaders,
      body: '',
    };
  }

  try {
    // Proxy to external API
    const apiResponse = await proxyRequest({
      method: httpMethod,
      url: `https://api.external-service.com${path}`,
      headers: {
        Authorization: `Bearer ${process.env.API_TOKEN}`,
        'Content-Type': 'application/json',
      },
      body: body,
    });

    return {
      statusCode: apiResponse.statusCode,
      headers: {
        ...corsHeaders,
        'Content-Type': 'application/json',
      },
      body: apiResponse.body,
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers: corsHeaders,
      body: JSON.stringify({ error: 'Internal server error' }),
    };
  }
};

async function proxyRequest({ method, url, headers, body }) {
  return new Promise((resolve, reject) => {
    const req = https.request(url, { method, headers }, (res) => {
      let data = '';
      res.on('data', (chunk) => (data += chunk));
      res.on('end', () => {
        resolve({
          statusCode: res.statusCode,
          body: data,
        });
      });
    });

    req.on('error', reject);
    if (body) req.write(body);
    req.end();
  });
}
```

## Integration with Other Tools

### React/Next.js Integration

```javascript
// next.config.js for Next.js on Netlify
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  trailingSlash: true,
  output: 'export',

  // Netlify specific configuration
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: '/.netlify/functions/:path*',
      },
    ];
  },

  // Environment variables
  env: {
    NETLIFY_SITE_ID: process.env.NETLIFY_SITE_ID,
    NETLIFY_ENV: process.env.CONTEXT || 'development',
  },
};

module.exports = nextConfig;
```

### Vue.js/Nuxt.js Integration

```javascript
// nuxt.config.ts for Nuxt.js on Netlify
export default defineNuxtConfig({
  nitro: {
    preset: 'netlify',
  },

  // Generate static site
  ssr: false,
  target: 'static',

  // Netlify specific configuration
  generate: {
    fallback: true,
  },

  // Environment variables
  runtimeConfig: {
    public: {
      apiBase: process.env.API_BASE_URL || 'http://localhost:3000',
    },
  },
});
```

### WordPress Headless Integration

```javascript
// netlify/functions/wordpress-webhook.js
exports.handler = async (event, context) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  const { headers } = event;
  const signature = headers['x-wp-signature'];

  // Verify webhook signature
  if (!verifySignature(event.body, signature)) {
    return { statusCode: 401, body: 'Unauthorized' };
  }

  // Trigger build on content change
  try {
    await fetch(`https://api.netlify.com/build_hooks/${process.env.BUILD_HOOK_ID}`, {
      method: 'POST',
    });

    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Build triggered successfully' }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Failed to trigger build' }),
    };
  }
};
```

## Troubleshooting

### Common Issues

#### Build Failures

**Problem**: Build process fails during deployment
**Symptoms**: Build errors in Netlify deploy logs
**Solution**:

```bash
# Debug build locally
netlify build --dry
netlify dev

# Check build settings in netlify.toml
[build]
  command = "npm run build"  # Ensure this matches your build script
  publish = "dist"           # Ensure this matches your build output

# Check Node.js version
[build.environment]
  NODE_VERSION = "18"        # Specify Node.js version

# Clear build cache
netlify build --clear-cache
```

#### Function Errors

**Problem**: Serverless functions returning errors or not executing
**Symptoms**: 500 errors when calling function endpoints
**Solution**:

```javascript
// Add proper error handling
exports.handler = async (event, context) => {
  try {
    // Function logic here
    return {
      statusCode: 200,
      body: JSON.stringify({ success: true })
    };
  } catch (error) {
    console.error('Function error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        error: 'Internal server error',
        message: error.message
      })
    };
  }
};

// Check function logs
netlify logs
netlify functions:list
```

#### Redirect Issues

**Problem**: Redirects not working as expected
**Symptoms**: 404 errors or incorrect redirects
**Solution**:

```bash
# Check _redirects file syntax and order
# More specific rules should come first
/api/*  /.netlify/functions/:splat  200
/old-page  /new-page  301
/*  /index.html  200  # SPA fallback (should be last)

# Test redirects locally
netlify dev

# Check netlify.toml redirects
[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/:splat"
  status = 200
```

### Debug Mode

```bash
# Verbose deployment
netlify deploy --debug

# Local development with debug
DEBUG=* netlify dev

# Function debugging
netlify functions:invoke function-name --payload='{"key":"value"}'

# Build debugging
netlify build --debug
```

### Performance Optimization

```toml
# Optimize build performance
[build]
  command = "npm ci && npm run build"  # Use npm ci for faster installs

[build.environment]
  NPM_FLAGS = "--production"
  NODE_ENV = "production"

# Asset optimization
[build.processing]
  skip_processing = false

[build.processing.css]
  bundle = true
  minify = true

[build.processing.js]
  bundle = true
  minify = true
```

## Security Considerations

### Security Best Practices

- **Implement security headers** - Configure CSP, HSTS, and security headers in \_headers file
- **Use environment variables** - Store sensitive configuration in Netlify environment variables
- **Validate function inputs** - Always validate and sanitize inputs in serverless functions
- **Implement rate limiting** - Use Edge Functions or external services for rate limiting
- **Monitor access logs** - Regularly review function logs and analytics for suspicious activity
- **Use HTTPS only** - Netlify provides automatic HTTPS; ensure no mixed content

### Secure Function Implementation

```javascript
// netlify/functions/secure-api.js
const crypto = require('crypto');

exports.handler = async (event, context) => {
  // Validate HTTP method
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' }),
    };
  }

  // Validate content type
  if (!event.headers['content-type']?.includes('application/json')) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Invalid content type' }),
    };
  }

  // Rate limiting (simple implementation)
  const clientIP = event.headers['x-forwarded-for'] || event.headers['client-ip'];
  if (await isRateLimited(clientIP)) {
    return {
      statusCode: 429,
      body: JSON.stringify({ error: 'Rate limit exceeded' }),
    };
  }

  // Validate request signature
  const signature = event.headers['x-signature'];
  if (!validateSignature(event.body, signature)) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: 'Invalid signature' }),
    };
  }

  try {
    const data = JSON.parse(event.body);

    // Validate and sanitize input
    if (!isValidInput(data)) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: 'Invalid input data' }),
      };
    }

    // Process request
    const result = await processSecureRequest(data);

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-store',
      },
      body: JSON.stringify(result),
    };
  } catch (error) {
    console.error('Secure API error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Internal server error' }),
    };
  }
};

function validateSignature(body, signature) {
  const expectedSignature = crypto
    .createHmac('sha256', process.env.WEBHOOK_SECRET)
    .update(body)
    .digest('hex');
  return crypto.timingSafeEqual(
    Buffer.from(signature, 'hex'),
    Buffer.from(expectedSignature, 'hex'),
  );
}
```

## AI Assistant Guidelines

When helping with Netlify:

1. **Always suggest modern Netlify features** like Edge Functions and automatic HTTPS
2. **Provide complete deployment configurations** with netlify.toml and redirect rules
3. **Include serverless function examples** with proper error handling and security
4. **Suggest JAMstack architecture patterns** appropriate for the project type
5. **Provide debugging strategies** for common build and deployment issues
6. **Include performance optimization** techniques for builds and runtime
7. **Reference security best practices** for serverless functions and headers
8. **Suggest integration patterns** with popular frameworks and external services

### Code Generation Rules

- Generate netlify.toml files with environment-specific configurations
- Include proper redirect rules for SPA routing and API proxying
- Provide serverless functions with error handling and CORS support
- Follow security best practices for function implementation
- Include build optimization settings for faster deployments
- Generate framework-specific configurations for React, Vue, Next.js, etc.
- Provide monitoring and debugging guidance for generated configurations
- Include CI/CD integration examples with GitHub Actions or other platforms

## Installation & Setup

### Package Manager Installation

```bash
# npm/yarn installation
npm install -g [tool-name]
# or
yarn global add [tool-name]

# pip installation
pip install [tool-name]

# homebrew installation (macOS)
brew install [tool-name]

# Other platform-specific commands
[other installation methods]
```

### Project Integration

```bash
# Initialize in project
[tool] init

# Add to existing project
[project setup commands]
```

## Configuration

### Configuration File

```[config-format]
# [config-file-name] (e.g., .toolrc, tool.config.js, tool.yaml)
[configuration-example]
```

### Environment Variables

```bash
# Environment-specific settings
[TOOL_ENV_VAR]=[value]
[TOOL_CONFIG_PATH]=[path]
```

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions
