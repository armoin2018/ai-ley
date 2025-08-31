`
---
applyTo: "parcel, build-tools, bundler, **/package.json, **/.parcelrc, **/parcel-config.json"
---

# Parcel Build Tool Instructions

## Overview
- **Domain**: Modern Web Application Build Tool and Bundler
- **Purpose**: Fast, zero-configuration web application bundler with automatic optimizations
- **Applicable To**: Web applications, SPAs, static sites, libraries, and development workflows
- **Integration Level**: Development toolchains, CI/CD pipelines, and deployment automation

## Core Principles

### Fundamental Concepts
1. **Zero Configuration**: Works out of the box without complex configuration files
2. **Automatic Code Splitting**: Intelligent bundle splitting for optimal loading performance
3. **Hot Module Replacement**: Fast development with instant updates
4. **Multi-Format Support**: Handles various file types and asset formats automatically

### Key Benefits
- Minimal setup and configuration overhead
- Built-in development server with hot reloading
- Automatic optimization including tree shaking and minification
- Native support for modern web standards (ES modules, CSS modules, WebAssembly)
- Fast build times with intelligent caching

### Common Misconceptions
- **Myth**: Parcel is only for simple projects
  **Reality**: Parcel 2 supports complex enterprise applications with advanced configuration options
- **Myth**: Parcel lacks customization capabilities
  **Reality**: Parcel 2 provides extensive plugin system and configuration options

## Implementation Framework

### Getting Started
#### Prerequisites
- Node.js 14+ (Node.js 16+ recommended for optimal performance)
- npm, yarn, or pnpm package manager
- Basic understanding of modern JavaScript and web development

#### Initial Setup
```bash
# Install Parcel globally (optional)
npm install -g parcel

# Or install locally in project
npm install --save-dev parcel

# Initialize new project
mkdir my-app && cd my-app
npm init -y

# Create basic project structure
mkdir src
echo '<div id="app">Hello Parcel!</div>' > src/index.html
echo 'console.log("Hello from Parcel!");' > src/index.js

# Add scripts to package.json
npm pkg set scripts.dev="parcel src/index.html"
npm pkg set scripts.build="parcel build src/index.html"
```

### Core Methodologies
#### Development Workflow Optimization
- **Purpose**: Maximize development efficiency with fast builds and hot reloading
- **When to Use**: All development phases requiring rapid iteration
- **Implementation Steps**:
  1. Configure development server with optimal settings
  2. Set up hot module replacement for instant updates
  3. Implement source maps for effective debugging
  4. Configure proxy settings for API integration
- **Success Metrics**: Sub-second build times and seamless development experience

#### Production Build Optimization
- **Purpose**: Create optimized production bundles with minimal size and maximum performance
- **When to Use**: Production deployments and performance-critical applications
- **Implementation Steps**:
  1. Configure code splitting and bundle optimization
  2. Implement compression and minification strategies
  3. Set up asset optimization and caching
  4. Configure environment-specific builds
- **Success Metrics**: Optimized bundle sizes with excellent runtime performance

### Process Integration
#### Modern Frontend Stack Integration
```json
{
  "name": "modern-web-app",
  "version": "1.0.0",
  "description": "Modern web application with Parcel",
  "scripts": {
    "dev": "parcel src/index.html --open",
    "build": "parcel build src/index.html",
    "preview": "parcel serve dist",
    "clean": "rm -rf dist .parcel-cache",
    "type-check": "tsc --noEmit",
    "lint": "eslint src --ext .ts,.tsx,.js,.jsx",
    "test": "jest",
    "test:watch": "jest --watch"
  },
  "source": "src/index.html",
  "browserslist": [
    "last 2 Chrome versions",
    "last 2 Firefox versions",
    "last 2 Safari versions",
    "last 2 Edge versions"
  ],
  "devDependencies": {
    "parcel": "^2.9.0",
    "@parcel/transformer-typescript": "^2.9.0",
    "@parcel/transformer-sass": "^2.9.0",
    "@parcel/transformer-postcss": "^2.9.0",
    "typescript": "^5.0.0",
    "sass": "^1.60.0",
    "postcss": "^8.4.0",
    "autoprefixer": "^10.4.0",
    "eslint": "^8.40.0",
    "jest": "^29.5.0"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}
```

#### Advanced Configuration (.parcelrc)
```json
{
  "extends": "@parcel/config-default",
  "transformers": {
    "*.{ts,tsx}": ["@parcel/transformer-typescript"],
    "*.{scss,sass}": ["@parcel/transformer-sass"],
    "*.svg": ["@parcel/transformer-svg-react"]
  },
  "optimizers": {
    "*.{js,mjs,jsm,jsx,ts,tsx}": ["@parcel/optimizer-terser"],
    "*.{css,scss,sass}": ["@parcel/optimizer-cssnano"],
    "*.{jpg,jpeg,png}": ["@parcel/optimizer-imagemin"]
  },
  "packagers": {
    "*.html": "@parcel/packager-html",
    "*.{js,mjs,jsm}": "@parcel/packager-js",
    "*.{css,scss,sass}": "@parcel/packager-css"
  },
  "reporters": [
    "@parcel/reporter-dev-server",
    "@parcel/reporter-cli",
    "@parcel/reporter-bundle-analyzer"
  ]
}
```

## Best Practices

### Comprehensive Project Structure
```
modern-web-app/
├── .parcelrc                    # Parcel configuration
├── package.json                 # Project dependencies and scripts
├── tsconfig.json               # TypeScript configuration
├── postcss.config.js           # PostCSS configuration
├── .eslintrc.js               # ESLint configuration
├── jest.config.js             # Jest testing configuration
├── .gitignore                 # Git ignore rules
├── README.md                  # Project documentation
├── src/                       # Source code
│   ├── index.html            # Entry HTML file
│   ├── index.ts              # Entry TypeScript file
│   ├── styles/               # Stylesheets
│   │   ├── main.scss        # Main styles
│   │   ├── variables.scss   # SCSS variables
│   │   └── components/      # Component styles
│   ├── components/          # React components
│   │   ├── App.tsx         # Main App component
│   │   ├── Header.tsx      # Header component
│   │   └── Footer.tsx      # Footer component
│   ├── utils/              # Utility functions
│   │   ├── api.ts         # API utilities
│   │   └── helpers.ts     # Helper functions
│   ├── assets/            # Static assets
│   │   ├── images/        # Image files
│   │   ├── fonts/         # Font files
│   │   └── icons/         # Icon files
│   └── types/             # TypeScript type definitions
│       └── index.ts       # Type exports
├── public/                # Public assets
│   ├── favicon.ico       # Favicon
│   └── manifest.json     # PWA manifest
├── dist/                 # Build output (generated)
└── .parcel-cache/       # Parcel cache (generated)
```

### Advanced React Application Setup
```typescript
// src/index.tsx - Main entry point
import React from 'react';
import { createRoot } from 'react-dom/client';
import { App } from './components/App';
import './styles/main.scss';

// Enable hot module replacement in development
if (module.hot) {
  module.hot.accept('./components/App', () => {
    render();
  });
}

function render() {
  const container = document.getElementById('app');
  if (!container) throw new Error('App container not found');
  
  const root = createRoot(container);
  root.render(<App />);
}

render();
```

```typescript
// src/components/App.tsx - Main App component
import React, { Suspense, lazy } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Header } from './Header';
import { Footer } from './Footer';
import { LoadingSpinner } from './LoadingSpinner';

// Lazy load components for code splitting
const Home = lazy(() => import('./pages/Home'));
const About = lazy(() => import('./pages/About'));
const Contact = lazy(() => import('./pages/Contact'));

export const App: React.FC = () => {
  return (
    <Router>
      <div className="app">
        <Header />
        <main className="main-content">
          <Suspense fallback={<LoadingSpinner />}>
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/about" element={<About />} />
              <Route path="/contact" element={<Contact />} />
            </Routes>
          </Suspense>
        </main>
        <Footer />
      </div>
    </Router>
  );
};
```

```scss
// src/styles/main.scss - Main stylesheet
@import 'variables';
@import 'components/header';
@import 'components/footer';

// Global styles
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: $font-family-base;
  font-size: $font-size-base;
  line-height: $line-height-base;
  color: $text-color;
  background-color: $bg-color;
}

.app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main-content {
  flex: 1;
  padding: $spacing-lg;
  
  @media (max-width: $breakpoint-md) {
    padding: $spacing-md;
  }
}

// Utility classes
.container {
  max-width: $container-max-width;
  margin: 0 auto;
  padding: 0 $spacing-md;
}

.btn {
  display: inline-block;
  padding: $spacing-sm $spacing-md;
  background-color: $primary-color;
  color: white;
  text-decoration: none;
  border-radius: $border-radius;
  transition: background-color 0.3s ease;
  
  &:hover {
    background-color: darken($primary-color, 10%);
  }
  
  &.btn-secondary {
    background-color: $secondary-color;
    
    &:hover {
      background-color: darken($secondary-color, 10%);
    }
  }
}
```

### Environment Configuration and Optimization
```javascript
// parcel-config.js - Advanced Parcel configuration
const { defineConfig } = require('@parcel/config-default');

module.exports = defineConfig({
  // Entry points
  entries: [
    'src/index.html',
    'src/service-worker.js'
  ],
  
  // Development server configuration
  devServer: {
    port: 3000,
    host: 'localhost',
    https: false,
    open: true,
    hmr: true
  },
  
  // Build optimization
  optimization: {
    minimize: true,
    scopeHoisting: true,
    publicUrl: './'
  },
  
  // Environment variables
  env: {
    NODE_ENV: 'production',
    API_URL: 'https://api.example.com',
    VERSION: require('./package.json').version
  },
  
  // Advanced features
  features: {
    // Enable experimental features
    experimentalScope: true,
    experimentalBundleAnalysis: true
  }
});
```

```typescript
// src/config/environment.ts - Environment configuration
interface Environment {
  isDevelopment: boolean;
  isProduction: boolean;
  apiUrl: string;
  version: string;
  debug: boolean;
}

export const environment: Environment = {
  isDevelopment: process.env.NODE_ENV === 'development',
  isProduction: process.env.NODE_ENV === 'production',
  apiUrl: process.env.API_URL || 'http://localhost:8080/api',
  version: process.env.VERSION || '1.0.0',
  debug: process.env.NODE_ENV === 'development'
};

// Type-safe environment variable access
export const getEnvVar = (key: string, defaultValue?: string): string => {
  const value = process.env[key];
  if (value === undefined && defaultValue === undefined) {
    throw new Error(`Environment variable ${key} is required`);
  }
  return value || defaultValue!;
};
```

## Common Patterns and Examples

### Pattern 1: Progressive Web App (PWA) Setup
**Scenario**: Create a PWA with service worker and offline capabilities
**Implementation**:
```html
<!-- src/index.html -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My PWA</title>
  <link rel="manifest" href="./manifest.json">
  <meta name="theme-color" content="#2196F3">
  <link rel="icon" type="image/x-icon" href="./assets/favicon.ico">
</head>
<body>
  <div id="app"></div>
  <script type="module" src="./index.ts"></script>
  <script>
    // Register service worker
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', () => {
        navigator.serviceWorker.register('./service-worker.js')
          .then(registration => {
            console.log('SW registered: ', registration);
          })
          .catch(registrationError => {
            console.log('SW registration failed: ', registrationError);
          });
      });
    }
  </script>
</body>
</html>
```

```typescript
// src/service-worker.ts
const CACHE_NAME = 'my-pwa-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/index.js',
  '/styles.css',
  '/assets/images/logo.png'
];

// Install event
self.addEventListener('install', (event: ExtendableEvent) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

// Fetch event
self.addEventListener('fetch', (event: FetchEvent) => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Return cached version or fetch from network
        return response || fetch(event.request);
      })
  );
});
```

```json
// public/manifest.json
{
  "name": "My Progressive Web App",
  "short_name": "MyPWA",
  "description": "A sample PWA built with Parcel",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#2196F3",
  "icons": [
    {
      "src": "./assets/icons/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "./assets/icons/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```
**Expected Outcomes**: Fully functional PWA with offline capabilities and app-like experience

### Pattern 2: Library Development and Publishing
**Scenario**: Build and publish a reusable JavaScript/TypeScript library
**Implementation**:
```json
// package.json for library
{
  "name": "@company/my-library",
  "version": "1.0.0",
  "description": "A reusable component library",
  "main": "dist/index.js",
  "module": "dist/index.module.js",
  "types": "dist/index.d.ts",
  "files": [
    "dist"
  ],
  "source": "src/index.ts",
  "scripts": {
    "build": "parcel build",
    "dev": "parcel watch",
    "prepublishOnly": "npm run build",
    "test": "jest",
    "type-check": "tsc --noEmit"
  },
  "targets": {
    "main": {
      "outputFormat": "commonjs"
    },
    "module": {
      "outputFormat": "esmodule"
    },
    "types": {
      "outputFormat": "commonjs"
    }
  },
  "peerDependencies": {
    "react": ">=16.8.0",
    "react-dom": ">=16.8.0"
  },
  "devDependencies": {
    "parcel": "^2.9.0",
    "@parcel/transformer-typescript": "^2.9.0",
    "typescript": "^5.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}
```

```typescript
// src/index.ts - Library entry point
export { Button } from './components/Button';
export { Input } from './components/Input';
export { Modal } from './components/Modal';
export type { ButtonProps, InputProps, ModalProps } from './types';
```

```typescript
// src/components/Button.tsx
import React from 'react';
import { ButtonProps } from '../types';

export const Button: React.FC<ButtonProps> = ({
  children,
  variant = 'primary',
  size = 'medium',
  disabled = false,
  onClick,
  ...props
}) => {
  const className = `btn btn--${variant} btn--${size} ${disabled ? 'btn--disabled' : ''}`;
  
  return (
    <button
      className={className}
      disabled={disabled}
      onClick={onClick}
      {...props}
    >
      {children}
    </button>
  );
};
```
**Expected Outcomes**: Publishable library with multiple output formats and TypeScript support

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Over-Configuration
- **Description**: Adding unnecessary configuration when Parcel's defaults work well
- **Why It's Problematic**: Increases complexity and maintenance overhead
- **Better Approach**: Start with zero configuration and add only when specific needs arise

#### Anti-Pattern 2: Ignoring Bundle Analysis
- **Description**: Not analyzing bundle size and performance metrics
- **Why It's Problematic**: Can lead to bloated bundles and poor performance
- **Better Approach**: Regularly analyze bundles and optimize based on metrics

## Tools and Resources

### Development and Build Tools
```bash
# Parcel CLI commands
parcel src/index.html                    # Development server
parcel build src/index.html              # Production build
parcel serve dist                        # Serve built files
parcel watch src/index.html              # Watch mode

# Bundle analysis
npx parcel-bundle-analyzer dist          # Analyze bundle size
parcel build --reporter @parcel/reporter-bundle-analyzer src/index.html

# Performance optimization
parcel build --no-source-maps src/index.html    # Disable source maps
parcel build --no-optimize src/index.html       # Disable optimization
parcel build --log-level verbose src/index.html # Verbose logging
```

### Performance Monitoring
```typescript
// Performance monitoring utility
export class PerformanceMonitor {
  private static instance: PerformanceMonitor;
  
  public static getInstance(): PerformanceMonitor {
    if (!PerformanceMonitor.instance) {
      PerformanceMonitor.instance = new PerformanceMonitor();
    }
    return PerformanceMonitor.instance;
  }
  
  public measureBundleSize(): void {
    if (typeof window !== 'undefined' && 'performance' in window) {
      const navigation = performance.getEntriesByType('navigation')[0] as PerformanceNavigationTiming;
      console.log('Bundle load time:', navigation.loadEventEnd - navigation.fetchStart, 'ms');
    }
  }
  
  public measureComponentRender(componentName: string, renderFn: () => void): void {
    const start = performance.now();
    renderFn();
    const end = performance.now();
    console.log(`${componentName} render time:`, end - start, 'ms');
  }
}
```

### Learning Resources
- **Parcel Documentation**: https://parceljs.org/docs/
- **Parcel Examples**: https://github.com/parcel-bundler/examples
- **Performance Guide**: https://parceljs.org/features/production/
- **Plugin Development**: https://parceljs.org/plugin-system/overview/

## Quality and Compliance

### Quality Standards
- Fast development builds (< 1 second for incremental changes)
- Optimized production bundles with minimal size
- Comprehensive testing and type checking integration
- Proper source map generation for debugging
- Consistent code formatting and linting

### Security Standards
- Secure dependency management with vulnerability scanning
- Content Security Policy (CSP) implementation
- Secure asset handling and optimization
- Environment variable security practices
- Regular security updates and patches

### Performance Standards
- Bundle size optimization with code splitting
- Lazy loading for non-critical resources
- Efficient caching strategies
- Progressive web app capabilities
- Accessibility compliance (WCAG 2.1)

## AI Assistant Guidelines

When helping with Parcel Build Tool:

1. **Simplicity First**: Start with zero configuration and add complexity only when needed
2. **Performance Focus**: Prioritize build speed and bundle optimization
3. **Modern Standards**: Use latest web standards and best practices
4. **Development Experience**: Emphasize fast iteration and debugging capabilities
5. **Production Readiness**: Ensure proper optimization for production deployments
6. **Asset Management**: Implement efficient asset handling and optimization
7. **Integration Strategy**: Plan for CI/CD and deployment automation
8. **Monitoring Approach**: Include performance monitoring and bundle analysis

### Decision Making Framework
When helping teams choose Parcel configurations:

1. **Project Analysis**: Understand application architecture and requirements
2. **Performance Requirements**: Define build speed and bundle size targets
3. **Integration Needs**: Plan for existing toolchain and workflow integration
4. **Deployment Strategy**: Consider deployment targets and optimization needs
5. **Team Preferences**: Balance simplicity with customization requirements

### Code Generation Rules
- Generate minimal configuration files focusing on essential settings
- Include comprehensive TypeScript support and type checking
- Use modern JavaScript/TypeScript patterns and best practices
- Implement proper error handling and development debugging
- Generate efficient asset optimization and caching strategies
- Include testing and quality assurance integration
- Provide clear documentation and usage examples
- Include performance monitoring and optimization techniques

### Quality Enforcement
- ✅ Enforce fast development build times (< 2 seconds for incremental changes)
- ✅ Require bundle size analysis and optimization
- ✅ Block commit of large unoptimized assets
- ✅ Enforce proper TypeScript configuration and type checking
- ✅ Require comprehensive testing integration
- ✅ Enforce accessibility and performance standards
- ✅ Promote zero-configuration approach with minimal custom configuration
- ✅ Require proper source map generation for debugging