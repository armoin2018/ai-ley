---
title: 'Vercel Modern Web Deployment Platform Instructions'
description: 'Comprehensive guide for using Vercel for Next.js applications, serverless functions, edge computing, and modern web deployment'
category: 'Cloud Platforms'

tags: ['vercel', 'nextjs', 'deployment', 'serverless', 'edge-functions', 'frontend', 'jamstack']
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/vercel.json'
  - '**/.vercelignore'
  - '**/api/**'
  - '**/middleware.ts'
  - '**/middleware.js'
  - '**/vercel/**'
---

# Vercel Modern Web Deployment Platform Instructions

## Tool Overview

- **Tool Name**: Vercel
- **Version**: Platform service with CLI 32.0+ (Latest stable with Edge Runtime support)
- **Category**: Cloud Platforms - Modern Web Deployment
- **Purpose**: Deploy and scale modern web applications with serverless functions, edge computing, and optimized frontend performance
- **Prerequisites**: Git repository, modern web framework (Next.js, React, Vue, Angular), Node.js for CLI and development

## When to Use Vercel

### ✅ **Use Vercel When**

- Building Next.js applications (first-class support and optimization)
- Deploying React, Vue, Angular, or other modern frontend frameworks
- Need serverless functions for API endpoints and backend logic
- Want automatic deployment with Git integration and branch previews
- Building applications requiring edge computing and global performance
- Need built-in monitoring, analytics, and performance optimization
- Want zero-configuration deployment with intelligent build detection
- Building e-commerce, SaaS, or content-heavy applications with SSR/SSG

### ❌ **Avoid Vercel When**

- Building traditional server-side applications requiring persistent connections
- Need complex database operations requiring long-running processes
- Working with legacy applications not suited for serverless architecture
- Building applications requiring WebSocket connections or real-time features
- Need extensive backend services beyond API routes and functions
- Working with applications requiring custom server configuration
- Building desktop applications or mobile backends requiring specialized hosting

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Vercel Recommendation                     | Configuration Priority         |
| ---------------------- | ----------------------------------------- | ------------------------------ |
| Next.js Application    | ✅ **Essential** - Perfect integration    | High - Framework optimization  |
| React SPA              | ✅ **Essential** - Excellent performance  | High - Static optimization     |
| E-commerce Site        | ✅ **Essential** - Commerce features      | High - Performance + Analytics |
| Documentation Site     | ✅ **Recommended** - Fast SSG             | Medium - SEO optimization      |
| Portfolio Website      | ✅ **Recommended** - Easy management      | Medium - Custom domain         |
| Enterprise Application | 🔄 **Consider** - May need Pro/Enterprise | High - Team collaboration      |

### Complexity Assessment

| Factor            | Low Complexity       | Medium Complexity      | High Complexity                 |
| ----------------- | -------------------- | ---------------------- | ------------------------------- |
| **Setup Time**    | 10 minutes (Next.js) | 1 hour (custom config) | 4 hours (enterprise setup)      |
| **Features Used** | Static hosting + CDN | API routes + analytics | Full platform features          |
| **Framework**     | Standard Next.js     | Custom framework       | Multi-framework monorepo        |
| **Backend Needs** | Static/SSG           | API routes             | Complex serverless architecture |

## Installation & Setup

### Vercel CLI Installation

```bash
# npm installation (recommended)
npm install -g vercel

# yarn installation
yarn global add vercel

# pnpm installation
pnpm add -g vercel

# Verify installation
vercel --version
vc --version  # Short alias

# Login to Vercel
vercel login
vercel auth
```

### Project Integration

```bash
# Deploy existing project
cd your-project
vercel

# Initialize new project with framework
npx create-next-app@latest my-app
cd my-app
vercel

# Link existing project to Vercel
vercel link

# Set up development environment
vercel dev
vercel dev --listen 4000  # Custom port

# Deploy specific environment
vercel --prod              # Production deployment
vercel --target production # Alias for production
```

### Framework-Specific Setup

```bash
# Next.js setup (recommended)
npx create-next-app@latest my-next-app --typescript --tailwind --eslint
cd my-next-app
vercel

# React setup
npx create-react-app my-react-app
cd my-react-app
vercel

# Vue.js setup
npm create vue@latest my-vue-app
cd my-vue-app
vercel

# Vite setup
npm create vite@latest my-vite-app
cd my-vite-app
vercel
```

## Configuration

### vercel.json Configuration

```json
{
  "version": 2,
  "name": "my-awesome-app",
  "build": {
    "env": {
      "NODE_VERSION": "18.x",
      "NPM_VERSION": "8.x"
    }
  },
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm ci",
  "devCommand": "npm run dev",
  "framework": "nextjs",
  "functions": {
    "pages/api/**/*.js": {
      "runtime": "nodejs18.x",
      "maxDuration": 10
    },
    "api/**/*.ts": {
      "runtime": "nodejs18.x",
      "maxDuration": 30
    }
  },
  "headers": [
    {
      "source": "/api/(.*)",
      "headers": [
        {
          "key": "Access-Control-Allow-Origin",
          "value": "*"
        },
        {
          "key": "Access-Control-Allow-Methods",
          "value": "GET, POST, PUT, DELETE, OPTIONS"
        },
        {
          "key": "Access-Control-Allow-Headers",
          "value": "Content-Type, Authorization"
        }
      ]
    },
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ],
  "redirects": [
    {
      "source": "/old-page",
      "destination": "/new-page",
      "permanent": true
    },
    {
      "source": "/blog/:slug*",
      "destination": "/posts/:slug*",
      "permanent": false
    }
  ],
  "rewrites": [
    {
      "source": "/api/proxy/:path*",
      "destination": "https://external-api.com/:path*"
    }
  ],
  "trailingSlash": false,
  "cleanUrls": true,
  "regions": ["iad1", "sfo1"],
  "env": {
    "API_URL": "@api_url",
    "DATABASE_URL": "@database_url"
  },
  "crons": [
    {
      "path": "/api/cron/cleanup",
      "schedule": "0 2 * * *"
    }
  ]
}
```

### Advanced Next.js Configuration

```json
{
  "version": 2,
  "name": "nextjs-app",
  "build": {
    "env": {
      "NEXT_TELEMETRY_DISABLED": "1",
      "NODE_ENV": "production"
    }
  },
  "functions": {
    "pages/api/**/*.js": {
      "runtime": "nodejs18.x",
      "maxDuration": 30,
      "memory": 1024
    }
  },
  "headers": [
    {
      "source": "/_next/static/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/api/(.*)",
      "headers": [
        {
          "key": "Access-Control-Allow-Credentials",
          "value": "true"
        },
        {
          "key": "Access-Control-Allow-Origin",
          "value": "https://yourdomain.com"
        }
      ]
    }
  ],
  "redirects": [
    {
      "source": "/home",
      "destination": "/",
      "permanent": true
    }
  ],
  "images": {
    "domains": ["example.com", "images.unsplash.com"],
    "formats": ["image/webp", "image/avif"]
  }
}
```

### Environment Variables Configuration

```bash
# .env.local (Next.js)
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000

# APIs
API_BASE_URL=https://api.yourservice.com
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...

# Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
NEXT_PUBLIC_ANALYTICS_ID=your-analytics-id

# Feature flags
NEXT_PUBLIC_FEATURE_NEW_UI=true
NEXT_PUBLIC_DEBUG_MODE=false

# Vercel-specific
VERCEL_URL=your-deployment-url.vercel.app
VERCEL_ENV=development
```

### Middleware Configuration

```typescript
// middleware.ts - Edge middleware
import { NextRequest, NextResponse } from 'next/server';
import { geolocation } from '@vercel/edge';

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Geolocation-based redirects
  const { country } = geolocation(request);

  if (pathname === '/' && country === 'CA') {
    return NextResponse.redirect(new URL('/ca', request.url));
  }

  // Authentication check
  if (pathname.startsWith('/dashboard')) {
    const token = request.cookies.get('auth-token');

    if (!token) {
      return NextResponse.redirect(new URL('/login', request.url));
    }
  }

  // Security headers
  const response = NextResponse.next();
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-XSS-Protection', '1; mode=block');

  return response;
}

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
};
```

## Core Features

### Serverless Functions (API Routes)

- **Purpose**: Create backend API endpoints without server management
- **Usage**: Handle form submissions, database operations, third-party integrations
- **Example**:

```typescript
// pages/api/users/[id].ts - Next.js API route
import type { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

type Data = {
  user?: any;
  error?: string;
};

export default async function handler(req: NextApiRequest, res: NextApiResponse<Data>) {
  const { id } = req.query;

  try {
    switch (req.method) {
      case 'GET':
        const user = await prisma.user.findUnique({
          where: { id: String(id) },
        });

        if (!user) {
          return res.status(404).json({ error: 'User not found' });
        }

        res.status(200).json({ user });
        break;

      case 'PUT':
        const updatedUser = await prisma.user.update({
          where: { id: String(id) },
          data: req.body,
        });

        res.status(200).json({ user: updatedUser });
        break;

      case 'DELETE':
        await prisma.user.delete({
          where: { id: String(id) },
        });

        res.status(204).end();
        break;

      default:
        res.setHeader('Allow', ['GET', 'PUT', 'DELETE']);
        res.status(405).json({ error: 'Method not allowed' });
    }
  } catch (error) {
    console.error('API Error:', error);
    res.status(500).json({ error: 'Internal server error' });
  } finally {
    await prisma.$disconnect();
  }
}

// pages/api/auth/login.ts - Authentication endpoint
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { email, password } = req.body;

  try {
    // Validate input
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }

    // Find user
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user || !(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Generate JWT
    const token = jwt.sign({ userId: user.id, email: user.email }, process.env.JWT_SECRET!, {
      expiresIn: '24h',
    });

    res.status(200).json({
      token,
      user: { id: user.id, email: user.email, name: user.name },
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

### Edge Functions

- **Purpose**: Run code at the edge for ultra-low latency and global performance
- **Usage**: A/B testing, personalization, authentication, redirects
- **Example**:

```typescript
// middleware.ts - Edge function for A/B testing
import { NextRequest, NextResponse } from 'next/server';

export function middleware(request: NextRequest) {
  // A/B testing logic
  const bucket = request.cookies.get('bucket')?.value;
  const pathname = request.nextUrl.pathname;

  if (pathname === '/' && !bucket) {
    // Assign user to A/B test bucket
    const testBucket = Math.random() < 0.5 ? 'A' : 'B';
    const response = NextResponse.next();

    response.cookies.set('bucket', testBucket, {
      maxAge: 60 * 60 * 24 * 30, // 30 days
      httpOnly: true,
    });

    // Redirect to variant if needed
    if (testBucket === 'B') {
      return NextResponse.redirect(new URL('/variant-b', request.url));
    }

    return response;
  }

  return NextResponse.next();
}

// pages/api/edge/analytics.ts - Edge API function
import { NextRequest } from 'next/server';

export const config = {
  runtime: 'edge',
};

export default async function handler(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const event = searchParams.get('event');
  const userId = searchParams.get('userId');

  // Log analytics event
  await fetch('https://analytics-api.com/events', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${process.env.ANALYTICS_API_KEY}`,
    },
    body: JSON.stringify({
      event,
      userId,
      timestamp: new Date().toISOString(),
      userAgent: req.headers.get('user-agent'),
      country: req.geo?.country,
    }),
  });

  return new Response(JSON.stringify({ success: true }), {
    headers: { 'Content-Type': 'application/json' },
  });
}
```

### Incremental Static Regeneration (ISR)

- **Purpose**: Combine static generation with dynamic updates for optimal performance
- **Usage**: E-commerce product pages, blog posts, frequently updated content
- **Example**:

```typescript
// pages/products/[id].tsx - ISR product page
import { GetStaticProps, GetStaticPaths } from 'next';

interface Product {
  id: string;
  name: string;
  price: number;
  description: string;
  updatedAt: string;
}

interface ProductPageProps {
  product: Product;
}

export default function ProductPage({ product }: ProductPageProps) {
  return (
    <div>
      <h1>{product.name}</h1>
      <p>Price: ${product.price}</p>
      <p>{product.description}</p>
      <small>Last updated: {product.updatedAt}</small>
    </div>
  );
}

export const getStaticPaths: GetStaticPaths = async () => {
  // Pre-generate top 100 product pages
  const popularProducts = await fetch('https://api.store.com/products/popular').then((res) =>
    res.json(),
  );

  const paths = popularProducts.map((product: Product) => ({
    params: { id: product.id },
  }));

  return {
    paths,
    fallback: 'blocking', // Generate other pages on-demand
  };
};

export const getStaticProps: GetStaticProps = async ({ params }) => {
  const product = await fetch(`https://api.store.com/products/${params?.id}`).then((res) =>
    res.json(),
  );

  if (!product) {
    return { notFound: true };
  }

  return {
    props: { product },
    revalidate: 3600, // Revalidate every hour
  };
};
```

### Image Optimization

- **Purpose**: Automatic image optimization and delivery via CDN
- **Usage**: Optimize images for performance and user experience
- **Example**:

```typescript
// components/OptimizedImage.tsx
import Image from 'next/image';

interface OptimizedImageProps {
  src: string;
  alt: string;
  width: number;
  height: number;
  priority?: boolean;
}

export default function OptimizedImage({
  src,
  alt,
  width,
  height,
  priority = false,
}: OptimizedImageProps) {
  return (
    <Image
      src={src}
      alt={alt}
      width={width}
      height={height}
      priority={priority}
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAIAAoDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAhEAACAQMDBQAAAAAAAAAAAAABAgMABAUGIWGRkqGx0f/EABUBAQEAAAAAAAAAAAAAAAAAAAMF/8QAGhEAAgIDAAAAAAAAAAAAAAAAAAECEgMRkf/aAAwDAQACEQMRAD8AltJagyeH0AthI5xdrLcNM91BF5pX2HaH9bcfaSXWGaRmknyJckliyjqTzSlT54b6bk+h0R//2Q=="
      quality={85}
      formats={['image/webp', 'image/avif']}
      sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
      className="rounded-lg shadow-md"
    />
  );
}

// next.config.js - Image configuration
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['images.unsplash.com', 'cdn.shopify.com', 'your-cdn.com'],
    formats: ['image/webp', 'image/avif'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
    minimumCacheTTL: 60 * 60 * 24 * 365, // 1 year
  },
};

module.exports = nextConfig;
```

## Common Commands

```bash
# Essential daily commands
vercel                              # Deploy current directory
vercel --prod                       # Deploy to production
vercel dev                          # Start local development server
vercel ls                           # List deployments

# Project management
vercel projects ls                  # List all projects
vercel projects add my-project      # Create new project
vercel projects rm my-project       # Remove project
vercel link                         # Link local project to Vercel

# Environment management
vercel env ls                       # List environment variables
vercel env add                      # Add environment variable
vercel env rm VAR_NAME             # Remove environment variable
vercel env pull .env.local         # Download environment variables

# Domain management
vercel domains ls                   # List domains
vercel domains add example.com      # Add custom domain
vercel domains rm example.com       # Remove domain
vercel domains verify example.com   # Verify domain ownership

# Team and collaboration
vercel teams ls                     # List teams
vercel teams switch team-name       # Switch to team
vercel teams invite user@email.com  # Invite team member

# Analytics and monitoring
vercel logs                         # View function logs
vercel inspect deployment-url       # Inspect deployment details
vercel analytics                    # View analytics data

# Deployment management
vercel alias set deployment-url custom-alias  # Set deployment alias
vercel rollback deployment-url                # Rollback deployment
vercel promote deployment-url                 # Promote preview to production
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use `vercel dev` for local testing with serverless functions
2. **Feature Development**: Automatic preview deployments for every Git push
3. **Testing**: Integration testing with preview URLs and environment variables
4. **Production**: Deploy to production with `vercel --prod` or Git integration
5. **Monitoring**: Use analytics, logs, and performance monitoring

### CI/CD Integration with GitHub Actions

```yaml
# .github/workflows/vercel.yml
name: Vercel Production Deployment
env:
  VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
  VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  Deploy-Preview:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
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

      - name: Install Vercel CLI
        run: npm install --global vercel@canary

      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=preview --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build Project Artifacts
        run: vercel build --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy Project Artifacts to Vercel
        run: vercel deploy --prebuilt --token=${{ secrets.VERCEL_TOKEN }}

  Deploy-Production:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
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

      - name: Install Vercel CLI
        run: npm install --global vercel@canary

      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=production --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build Project Artifacts
        run: vercel build --prod --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy Project Artifacts to Vercel
        run: vercel deploy --prebuilt --prod --token=${{ secrets.VERCEL_TOKEN }}
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "vercel:dev": "vercel dev",
    "vercel:build": "vercel build",
    "vercel:deploy": "vercel --prod",
    "vercel:logs": "vercel logs",
    "type-check": "tsc --noEmit",
    "analyze": "ANALYZE=true npm run build"
  },
  "devDependencies": {
    "vercel": "^32.0.0",
    "@types/node": "^20.0.0",
    "typescript": "^5.0.0"
  }
}
```

## Best Practices

### ✅ **Deployment Best Practices**

- **Use Git integration** - Connect repositories for automatic deployments
- **Configure build settings** - Optimize build commands and output directories
- **Set up custom domains** - Use custom domains with automatic SSL
- **Implement proper caching** - Use ISR and edge caching for optimal performance
- **Monitor Core Web Vitals** - Track performance metrics and optimize accordingly
- **Use preview deployments** - Test changes with unique preview URLs

### ✅ **Performance Optimization**

- **Enable automatic optimizations** - Use built-in image and font optimization
- **Implement ISR** - Use Incremental Static Regeneration for dynamic content
- **Optimize bundle size** - Analyze and reduce JavaScript bundle sizes
- **Use edge functions** - Move logic to the edge for faster response times
- **Configure caching headers** - Set appropriate cache policies for static assets
- **Implement code splitting** - Use dynamic imports and lazy loading

### ✅ **Security Best Practices**

- **Use environment variables** - Store secrets in Vercel environment variables
- **Implement security headers** - Configure security headers in vercel.json
- **Validate API inputs** - Always validate and sanitize API route inputs
- **Use HTTPS everywhere** - Vercel provides automatic HTTPS for all deployments
- **Implement rate limiting** - Use middleware or third-party services for rate limiting
- **Monitor function logs** - Regularly check logs for errors and security issues

### ❌ **Common Pitfalls to Avoid**

- **Don't commit secrets** - Use environment variables for sensitive data
- **Avoid large bundle sizes** - Monitor and optimize JavaScript bundle sizes
- **Don't ignore Core Web Vitals** - Performance directly impacts user experience
- **Avoid blocking builds** - Keep build times fast with efficient processes
- **Don't hardcode URLs** - Use environment-specific URLs and configuration
- **Avoid complex server logic** - Keep serverless functions focused and efficient

## Advanced Vercel Usage

### Edge Config for Dynamic Content

```typescript
// lib/edge-config.ts
import { get } from '@vercel/edge-config';

export async function getFeatureFlag(key: string): Promise<boolean> {
  try {
    const value = await get(key);
    return value === true;
  } catch (error) {
    console.error('Edge Config error:', error);
    return false;
  }
}

export async function getConfigValue<T>(key: string, defaultValue: T): Promise<T> {
  try {
    const value = await get(key);
    return value !== undefined ? value : defaultValue;
  } catch (error) {
    console.error('Edge Config error:', error);
    return defaultValue;
  }
}

// middleware.ts - Using Edge Config
import { NextRequest, NextResponse } from 'next/server';
import { getFeatureFlag } from './lib/edge-config';

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Feature flag check
  if (pathname === '/new-feature') {
    const isEnabled = await getFeatureFlag('new_feature_enabled');

    if (!isEnabled) {
      return NextResponse.redirect(new URL('/coming-soon', request.url));
    }
  }

  return NextResponse.next();
}
```

### Vercel KV for Caching

```typescript
// lib/kv.ts
import { kv } from '@vercel/kv';

export async function getCachedData<T>(
  key: string,
  fetcher: () => Promise<T>,
  ttl: number = 3600,
): Promise<T> {
  try {
    // Try to get from cache first
    const cached = await kv.get<T>(key);
    if (cached) {
      return cached;
    }

    // Fetch fresh data
    const data = await fetcher();

    // Cache the result
    await kv.setex(key, ttl, JSON.stringify(data));

    return data;
  } catch (error) {
    console.error('KV cache error:', error);
    // Fallback to fetching without cache
    return await fetcher();
  }
}

// pages/api/products/popular.ts
import { getCachedData } from '../../../lib/kv';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  try {
    const popularProducts = await getCachedData(
      'popular-products',
      async () => {
        const response = await fetch('https://api.store.com/products/popular');
        return response.json();
      },
      1800, // Cache for 30 minutes
    );

    res.status(200).json(popularProducts);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch popular products' });
  }
}
```

### Advanced Analytics Integration

```typescript
// lib/analytics.ts
import { Analytics } from '@vercel/analytics/react';
import { track } from '@vercel/analytics';

export function trackEvent(name: string, properties?: Record<string, any>) {
  track(name, properties);
}

export function trackPageView(page: string) {
  track('page_view', { page });
}

export function trackPurchase(value: number, currency: string = 'USD') {
  track('purchase', { value, currency });
}

// pages/_app.tsx
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';

export default function App({ Component, pageProps }: AppProps) {
  return (
    <>
      <Component {...pageProps} />
      <Analytics />
      <SpeedInsights />
    </>
  );
}

// components/ProductCard.tsx
import { trackEvent } from '../lib/analytics';

export default function ProductCard({ product }: { product: Product }) {
  const handleAddToCart = () => {
    trackEvent('add_to_cart', {
      product_id: product.id,
      product_name: product.name,
      price: product.price,
    });

    // Add to cart logic
  };

  return (
    <div className="product-card">
      <h3>{product.name}</h3>
      <p>${product.price}</p>
      <button onClick={handleAddToCart}>Add to Cart</button>
    </div>
  );
}
```

## Integration with Other Tools

### Database Integration (Prisma + PlanetScale)

```typescript
// lib/prisma.ts
import { PrismaClient } from '@prisma/client';

declare global {
  var prisma: PrismaClient | undefined;
}

export const prisma = globalThis.prisma || new PrismaClient();

if (process.env.NODE_ENV !== 'production') {
  globalThis.prisma = prisma;
}

// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider     = "mysql"
  url          = env("DATABASE_URL")
  relationMode = "prisma"
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String?  @db.Text
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([authorId])
}
```

### Authentication Integration (NextAuth.js)

```typescript
// pages/api/auth/[...nextauth].ts
import NextAuth from 'next-auth';
import GoogleProvider from 'next-auth/providers/google';
import { PrismaAdapter } from '@next-auth/prisma-adapter';
import { prisma } from '../../../lib/prisma';

export default NextAuth({
  adapter: PrismaAdapter(prisma),
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
  ],
  session: {
    strategy: 'jwt',
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
      }
      return token;
    },
    async session({ session, token }) {
      if (token) {
        session.user.id = token.id as string;
      }
      return session;
    },
  },
  pages: {
    signIn: '/auth/signin',
    error: '/auth/error',
  },
});

// middleware.ts - Auth protection
import { withAuth } from 'next-auth/middleware';

export default withAuth(
  function middleware(req) {
    // Additional middleware logic
  },
  {
    callbacks: {
      authorized: ({ token, req }) => {
        // Check if user is authorized for the route
        if (req.nextUrl.pathname.startsWith('/admin')) {
          return token?.role === 'admin';
        }
        return !!token;
      },
    },
  },
);

export const config = {
  matcher: ['/dashboard/:path*', '/admin/:path*'],
};
```

### Payment Integration (Stripe)

```typescript
// lib/stripe.ts
import Stripe from 'stripe';

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
});

// pages/api/checkout/session.ts
import { stripe } from '../../../lib/stripe';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { items, customer_email } = req.body;

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: items.map((item: any) => ({
        price_data: {
          currency: 'usd',
          product_data: {
            name: item.name,
          },
          unit_amount: item.price * 100,
        },
        quantity: item.quantity,
      })),
      mode: 'payment',
      success_url: `${req.headers.origin}/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${req.headers.origin}/cancel`,
      customer_email,
    });

    res.status(200).json({ sessionId: session.id });
  } catch (error) {
    console.error('Stripe error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

## Troubleshooting

### Common Issues

#### Build Failures

**Problem**: Build process fails during deployment
**Symptoms**: Build errors in Vercel deployment logs
**Solution**:

```bash
# Debug build locally
vercel build
vercel dev

# Check build settings in vercel.json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm ci"
}

# Check Node.js version
{
  "build": {
    "env": {
      "NODE_VERSION": "18.x"
    }
  }
}

# Clear build cache
vercel --force  # Force rebuild without cache
```

#### Function Timeout Errors

**Problem**: Serverless functions timing out
**Symptoms**: Function exceeds execution time limit
**Solution**:

```json
// vercel.json - Increase function timeout
{
  "functions": {
    "pages/api/**/*.js": {
      "maxDuration": 30
    }
  }
}
```

```typescript
// Optimize function performance
export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  // Set timeout early
  res.setHeader('Cache-Control', 's-maxage=60');

  try {
    // Use Promise.race for timeout control
    const result = await Promise.race([
      expensiveOperation(),
      new Promise((_, reject) => setTimeout(() => reject(new Error('Timeout')), 25000)),
    ]);

    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Operation failed' });
  }
}
```

#### Memory Limit Exceeded

**Problem**: Functions exceeding memory limits
**Symptoms**: Out of memory errors in function logs
**Solution**:

```json
// vercel.json - Increase memory limit
{
  "functions": {
    "pages/api/heavy-task.js": {
      "memory": 1024
    }
  }
}
```

### Debug Mode

```bash
# Verbose deployment
vercel --debug

# Local development with debug
DEBUG=* vercel dev

# Function debugging
vercel logs --follow

# Build debugging
vercel build --debug
```

### Performance Optimization

```json
// next.config.js - Performance optimization
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    esmExternals: true,
    serverComponentsExternalPackages: ['@prisma/client'],
  },
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production',
  },
  swcMinify: true,
  images: {
    formats: ['image/webp', 'image/avif'],
  },
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = {
        ...config.resolve.fallback,
        fs: false,
      };
    }
    return config;
  },
};

module.exports = nextConfig;
```

## Security Considerations

### Security Best Practices

- **Implement security headers** - Configure security headers in vercel.json and middleware
- **Use environment variables** - Store sensitive data in Vercel environment variables
- **Validate API inputs** - Always validate and sanitize inputs in API routes
- **Implement authentication** - Use NextAuth.js or similar for user authentication
- **Use HTTPS only** - Vercel provides automatic HTTPS for all deployments
- **Monitor function logs** - Regularly review logs for security issues

### Secure API Implementation

```typescript
// lib/auth.ts
import jwt from 'jsonwebtoken';

export function verifyToken(token: string) {
  try {
    return jwt.verify(token, process.env.JWT_SECRET!);
  } catch (error) {
    throw new Error('Invalid token');
  }
}

export function withAuth(handler: NextApiHandler): NextApiHandler {
  return async (req, res) => {
    try {
      const token = req.headers.authorization?.replace('Bearer ', '');

      if (!token) {
        return res.status(401).json({ error: 'No token provided' });
      }

      const user = verifyToken(token);
      (req as any).user = user;

      return handler(req, res);
    } catch (error) {
      return res.status(401).json({ error: 'Invalid token' });
    }
  };
}

// pages/api/protected/data.ts
import { withAuth } from '../../../lib/auth';

export default withAuth(async (req, res) => {
  // Protected route logic
  const user = (req as any).user;

  // Validate user permissions
  if (!user.permissions.includes('read:data')) {
    return res.status(403).json({ error: 'Insufficient permissions' });
  }

  res.status(200).json({ message: 'Protected data', user });
});
```

## AI Assistant Guidelines

When helping with Vercel:

1. **Always suggest Next.js integration** when appropriate for optimal performance
2. **Provide complete deployment configurations** with vercel.json and environment setup
3. **Include serverless function examples** with proper error handling and security
4. **Suggest ISR and edge functions** for optimal performance and user experience
5. **Provide debugging strategies** for common build and deployment issues
6. **Include monitoring and analytics** setup for production applications
7. **Reference security best practices** for API routes and authentication
8. **Suggest framework-specific optimizations** based on the technology stack

### Code Generation Rules

- Generate vercel.json files with appropriate configurations for the project type
- Include proper error handling and validation in serverless functions
- Provide middleware examples for authentication and edge computing
- Follow Next.js best practices for SSR, SSG, and ISR
- Include proper TypeScript types and interfaces
- Generate environment variable configurations for different environments
- Provide monitoring and analytics integration examples
- Include CI/CD pipeline configurations for automated deployments

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
