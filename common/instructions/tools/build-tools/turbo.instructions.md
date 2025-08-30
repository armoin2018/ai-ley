`
---
applyTo: "turbo, build-tools, monorepo, **/turbo.json, **/package.json, turborepo"
---

# Turbo Build Tool Instructions

## Overview
- **Domain**: High-Performance Monorepo Build System and Task Runner
- **Purpose**: Accelerate builds and task execution in JavaScript/TypeScript monorepos with intelligent caching
- **Applicable To**: Monorepos, multi-package projects, CI/CD pipelines, and development workflows
- **Integration Level**: Development toolchains, deployment automation, and team collaboration

## Core Principles

### Fundamental Concepts
1. **Intelligent Caching**: Cache build outputs and share them across machines and developers
2. **Incremental Builds**: Only rebuild what has changed, dramatically reducing build times
3. **Task Pipeline Optimization**: Parallelizes and schedules tasks based on dependencies
4. **Remote Caching**: Share cache artifacts across team members and CI/CD systems

### Key Benefits
- Dramatic build time reduction (often 85%+ faster with cache hits)
- Zero-configuration intelligent caching out of the box
- Parallel task execution with dependency-aware scheduling
- Seamless integration with existing package managers (npm, yarn, pnpm)
- Built-in support for remote caching and team collaboration

### Common Misconceptions
- **Myth**: Turbo is only for large monorepos
  **Reality**: Turbo provides benefits for any project with multiple packages or complex build steps
- **Myth**: Setting up Turbo requires significant configuration changes
  **Reality**: Turbo works with minimal configuration and respects existing package.json scripts

## Implementation Framework

### Getting Started
#### Prerequisites
- Node.js 14+ (Node.js 16+ recommended for optimal performance)
- A monorepo structure with multiple packages
- npm, yarn, or pnpm as package manager

#### Initial Setup
```bash
# Install Turbo globally
npm install -g turbo

# Or install in monorepo root
npm install --save-dev turbo

# Initialize Turbo in existing monorepo
npx turbo init

# Verify installation
turbo --version

# Run first build to establish baseline
turbo build
```

### Core Methodologies
#### Monorepo Setup and Configuration
- **Purpose**: Structure monorepo for optimal build performance and caching
- **When to Use**: Setting up new monorepos or optimizing existing ones
- **Implementation Steps**:
  1. Define package structure with clear dependencies
  2. Configure turbo.json with build pipelines
  3. Set up task dependencies and parallelization
  4. Implement caching strategies for different task types
- **Success Metrics**: Reduced build times and consistent development experience

#### Remote Caching Strategy
- **Purpose**: Share build artifacts across team members and CI/CD systems
- **When to Use**: Team development and continuous integration environments
- **Implementation Steps**:
  1. Set up Vercel remote cache or custom cache backend
  2. Configure authentication and access controls
  3. Implement cache invalidation strategies
  4. Monitor cache hit rates and performance
- **Success Metrics**: High cache hit rates (>80%) and improved CI/CD performance

### Process Integration
#### Comprehensive Turbo Configuration
```json
// turbo.json - Advanced Turbo configuration
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": [
    "package.json",
    "tsconfig.json",
    ".eslintrc.js",
    ".prettierrc",
    "turbo.json"
  ],
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [
        "dist/**",
        "build/**",
        ".next/**",
        "!.next/cache/**"
      ],
      "outputMode": "new-only"
    },
    "test": {
      "dependsOn": ["build"],
      "outputs": [
        "coverage/**"
      ],
      "inputs": [
        "src/**/*.{ts,tsx,js,jsx}",
        "test/**/*.{ts,tsx,js,jsx}",
        "**/*.test.{ts,tsx,js,jsx}",
        "**/*.spec.{ts,tsx,js,jsx}",
        "jest.config.js",
        "vitest.config.ts"
      ]
    },
    "lint": {
      "outputs": [],
      "inputs": [
        "src/**/*.{ts,tsx,js,jsx}",
        ".eslintrc.js",
        "eslint.config.js"
      ]
    },
    "type-check": {
      "dependsOn": ["^build"],
      "outputs": [],
      "inputs": [
        "src/**/*.{ts,tsx}",
        "tsconfig.json",
        "tsconfig.*.json"
      ]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "start": {
      "dependsOn": ["build"],
      "cache": false,
      "persistent": true
    },
    "clean": {
      "cache": false,
      "outputs": []
    }
  },
  "remoteCache": {
    "signature": true
  }
}
```

#### Monorepo Package Structure
```
my-monorepo/
├── turbo.json                 # Turbo configuration
├── package.json              # Root package.json
├── pnpm-workspace.yaml       # PNPM workspace configuration
├── tsconfig.json             # Shared TypeScript config
├── .eslintrc.js             # Shared ESLint config
├── .prettierrc              # Shared Prettier config
├── .gitignore               # Git ignore rules
├── apps/                    # Applications
│   ├── web/                # Next.js web app
│   │   ├── package.json
│   │   ├── next.config.js
│   │   ├── tsconfig.json
│   │   └── src/
│   ├── mobile/             # React Native app
│   │   ├── package.json
│   │   ├── metro.config.js
│   │   └── src/
│   └── api/                # Node.js API
│       ├── package.json
│       ├── tsconfig.json
│       └── src/
├── packages/               # Shared packages
│   ├── ui/                # Shared UI components
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   ├── rollup.config.js
│   │   └── src/
│   ├── utils/             # Shared utilities
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── src/
│   └── config/            # Shared configurations
│       ├── package.json
│       ├── eslint/
│       ├── typescript/
│       └── jest/
└── tools/                 # Build and development tools
    ├── build-scripts/
    └── dev-tools/
```

## Best Practices

### Optimized Package.json Configuration
```json
// Root package.json
{
  "name": "my-monorepo",
  "private": true,
  "workspaces": [
    "apps/*",
    "packages/*"
  ],
  "scripts": {
    "build": "turbo build",
    "dev": "turbo dev",
    "test": "turbo test",
    "lint": "turbo lint",
    "type-check": "turbo type-check",
    "clean": "turbo clean",
    "format": "prettier --write \"**/*.{ts,tsx,js,jsx,json,md}\"",
    "changeset": "changeset",
    "version-packages": "changeset version",
    "release": "turbo build && changeset publish"
  },
  "devDependencies": {
    "turbo": "^1.10.0",
    "@changesets/cli": "^2.26.0",
    "prettier": "^2.8.0",
    "eslint": "^8.40.0",
    "typescript": "^5.0.0"
  },
  "packageManager": "pnpm@8.6.0"
}
```

```json
// apps/web/package.json - Next.js application
{
  "name": "@my-company/web",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "build": "next build",
    "dev": "next dev",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "next": "^13.4.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "@my-company/ui": "workspace:*",
    "@my-company/utils": "workspace:*"
  },
  "devDependencies": {
    "@my-company/config": "workspace:*",
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "typescript": "^5.0.0"
  }
}
```

```json
// packages/ui/package.json - Shared UI library
{
  "name": "@my-company/ui",
  "version": "1.0.0",
  "main": "./dist/index.js",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "import": "./dist/index.mjs",
      "require": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "rollup -c",
    "dev": "rollup -c --watch",
    "lint": "eslint src --ext .ts,.tsx",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@my-company/config": "workspace:*",
    "@rollup/plugin-typescript": "^11.0.0",
    "rollup": "^3.20.0",
    "typescript": "^5.0.0"
  },
  "peerDependencies": {
    "react": ">=18.0.0",
    "react-dom": ">=18.0.0"
  }
}
```

### Advanced CI/CD Integration
```yaml
# .github/workflows/ci.yml - GitHub Actions with Turbo
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        with:
          fetch-depth: 2
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'pnpm'
      
      - name: Install PNPM
        uses: pnpm/action-setup@v2
        with:
          version: 8.6.0
      
      - name: Install dependencies
        run: pnpm install --frozen-lockfile
      
      - name: Setup Turbo cache
        uses: actions/cache@v3
        with:
          path: .turbo
          key: ${{ runner.os }}-turbo-${{ github.sha }}
          restore-keys: |
            ${{ runner.os }}-turbo-
      
      - name: Build packages
        run: pnpm turbo build --cache-dir=.turbo
      
      - name: Run tests
        run: pnpm turbo test --cache-dir=.turbo
      
      - name: Lint code
        run: pnpm turbo lint --cache-dir=.turbo
      
      - name: Type check
        run: pnpm turbo type-check --cache-dir=.turbo
      
      - name: Upload coverage reports
        uses: codecov/codecov-action@v3
        with:
          directory: ./coverage
          flags: unittests
          fail_ci_if_error: true

  deploy:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'pnpm'
      
      - name: Install PNPM
        uses: pnpm/action-setup@v2
        with:
          version: 8.6.0
      
      - name: Install dependencies
        run: pnpm install --frozen-lockfile
      
      - name: Build for production
        run: pnpm turbo build --filter=@my-company/web
        env:
          TURBO_TOKEN: ${{ secrets.TURBO_TOKEN }}
          TURBO_TEAM: ${{ secrets.TURBO_TEAM }}
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          working-directory: ./apps/web
          vercel-args: '--prod'
```

### Performance Monitoring and Optimization
```typescript
// tools/turbo-analytics.ts - Turbo performance monitoring
import { execSync } from 'child_process';
import { writeFileSync, readFileSync } from 'fs';
import { join } from 'path';

interface BuildMetrics {
  timestamp: string;
  command: string;
  duration: number;
  cacheHitRate: number;
  tasksExecuted: number;
  tasksCached: number;
}

export class TurboAnalytics {
  private metricsFile = join(process.cwd(), '.turbo', 'metrics.json');
  
  public recordBuild(command: string): BuildMetrics {
    const startTime = Date.now();
    
    try {
      // Execute Turbo command with verbose output
      const output = execSync(`turbo ${command} --dry-run=json`, {
        encoding: 'utf-8',
        stdio: 'pipe'
      });
      
      const dryRunResult = JSON.parse(output);
      const duration = Date.now() - startTime;
      
      const metrics: BuildMetrics = {
        timestamp: new Date().toISOString(),
        command,
        duration,
        cacheHitRate: this.calculateCacheHitRate(dryRunResult),
        tasksExecuted: dryRunResult.tasks?.length || 0,
        tasksCached: dryRunResult.tasks?.filter((t: any) => t.cache === 'HIT').length || 0
      };
      
      this.saveMetrics(metrics);
      return metrics;
      
    } catch (error) {
      console.error('Failed to record build metrics:', error);
      throw error;
    }
  }
  
  private calculateCacheHitRate(dryRunResult: any): number {
    const tasks = dryRunResult.tasks || [];
    if (tasks.length === 0) return 0;
    
    const cacheHits = tasks.filter((task: any) => task.cache === 'HIT').length;
    return (cacheHits / tasks.length) * 100;
  }
  
  private saveMetrics(metrics: BuildMetrics): void {
    try {
      const existingMetrics = this.loadMetrics();
      existingMetrics.push(metrics);
      
      // Keep only last 100 builds
      const recentMetrics = existingMetrics.slice(-100);
      
      writeFileSync(this.metricsFile, JSON.stringify(recentMetrics, null, 2));
    } catch (error) {
      console.warn('Failed to save metrics:', error);
    }
  }
  
  private loadMetrics(): BuildMetrics[] {
    try {
      const data = readFileSync(this.metricsFile, 'utf-8');
      return JSON.parse(data);
    } catch {
      return [];
    }
  }
  
  public generateReport(): void {
    const metrics = this.loadMetrics();
    if (metrics.length === 0) {
      console.log('No build metrics available');
      return;
    }
    
    const avgDuration = metrics.reduce((sum, m) => sum + m.duration, 0) / metrics.length;
    const avgCacheHitRate = metrics.reduce((sum, m) => sum + m.cacheHitRate, 0) / metrics.length;
    const totalBuilds = metrics.length;
    
    console.log('\n🚀 Turbo Performance Report');
    console.log('============================');
    console.log(`Total builds: ${totalBuilds}`);
    console.log(`Average build time: ${(avgDuration / 1000).toFixed(2)}s`);
    console.log(`Average cache hit rate: ${avgCacheHitRate.toFixed(1)}%`);
    console.log(`Last build: ${metrics[metrics.length - 1].timestamp}`);
    
    // Show trend analysis
    if (metrics.length >= 10) {
      const recent10 = metrics.slice(-10);
      const recentAvgCacheHit = recent10.reduce((sum, m) => sum + m.cacheHitRate, 0) / 10;
      
      console.log(`\n📈 Recent Trends (last 10 builds):`);
      console.log(`Recent cache hit rate: ${recentAvgCacheHit.toFixed(1)}%`);
      
      if (recentAvgCacheHit > avgCacheHitRate) {
        console.log('✅ Cache performance is improving');
      } else if (recentAvgCacheHit < avgCacheHitRate) {
        console.log('⚠️ Cache performance is declining');
      } else {
        console.log('➡️ Cache performance is stable');
      }
    }
  }
}

// Usage example
const analytics = new TurboAnalytics();

// Record a build
analytics.recordBuild('build');

// Generate performance report
analytics.generateReport();
```

## Common Patterns and Examples

### Pattern 1: Micro-Frontend Architecture with Turbo
**Scenario**: Build and deploy multiple micro-frontends with shared dependencies
**Implementation**:
```json
// turbo.json for micro-frontends
{
  "$schema": "https://turbo.build/schema.json",
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", "build/**"],
      "env": [
        "NODE_ENV",
        "NEXT_PUBLIC_API_URL",
        "REACT_APP_API_URL"
      ]
    },
    "build:mf": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**"],
      "env": [
        "NODE_ENV",
        "MF_NAME",
        "MF_PORT",
        "PUBLIC_PATH"
      ]
    },
    "dev:mf": {
      "cache": false,
      "persistent": true,
      "env": [
        "MF_PORT",
        "PUBLIC_PATH"
      ]
    },
    "deploy": {
      "dependsOn": ["build"],
      "outputs": [],
      "env": [
        "VERCEL_TOKEN",
        "AWS_ACCESS_KEY_ID",
        "AWS_SECRET_ACCESS_KEY"
      ]
    }
  }
}
```

```javascript
// apps/shell/webpack.config.js - Module federation host
const ModuleFederationPlugin = require('@module-federation/webpack');

module.exports = {
  mode: 'development',
  devServer: {
    port: 3000,
  },
  plugins: [
    new ModuleFederationPlugin({
      name: 'shell',
      remotes: {
        header: 'header@http://localhost:3001/remoteEntry.js',
        footer: 'footer@http://localhost:3002/remoteEntry.js',
        dashboard: 'dashboard@http://localhost:3003/remoteEntry.js',
      },
      shared: {
        react: { singleton: true },
        'react-dom': { singleton: true },
      },
    }),
  ],
};
```
**Expected Outcomes**: Scalable micro-frontend architecture with optimized builds and caching

### Pattern 2: Full-Stack Development with Turbo
**Scenario**: Coordinate frontend, backend, and shared library development
**Implementation**:
```json
// Root package.json scripts for full-stack development
{
  "scripts": {
    "dev": "turbo dev --parallel",
    "dev:web": "turbo dev --filter=@company/web",
    "dev:api": "turbo dev --filter=@company/api",
    "dev:mobile": "turbo dev --filter=@company/mobile",
    "build": "turbo build",
    "build:libs": "turbo build --filter='./packages/*'",
    "build:apps": "turbo build --filter='./apps/*'",
    "test": "turbo test",
    "test:changed": "turbo test --filter=[HEAD^1]",
    "deploy:staging": "turbo build --filter=@company/web && turbo deploy:staging --filter=@company/api",
    "deploy:prod": "turbo build && turbo deploy:prod"
  }
}
```

```yaml
# docker-compose.yml for local development
version: '3.8'
services:
  web:
    build:
      context: .
      dockerfile: apps/web/Dockerfile
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - API_URL=http://api:4000
    volumes:
      - ./apps/web:/app/apps/web
      - ./packages:/app/packages
      - /app/node_modules
    depends_on:
      - api
    command: pnpm turbo dev --filter=@company/web

  api:
    build:
      context: .
      dockerfile: apps/api/Dockerfile
    ports:
      - "4000:4000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://user:password@db:5432/myapp
    volumes:
      - ./apps/api:/app/apps/api
      - ./packages:/app/packages
      - /app/node_modules
    depends_on:
      - db
    command: pnpm turbo dev --filter=@company/api

  db:
    image: postgres:14
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: myapp
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```
**Expected Outcomes**: Coordinated full-stack development with optimized build pipeline

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Over-Granular Task Dependencies
- **Description**: Creating too many small, interdependent tasks that don't provide caching benefits
- **Why It's Problematic**: Reduces parallelization opportunities and complicates dependency graph
- **Better Approach**: Group related operations into meaningful, cacheable tasks

#### Anti-Pattern 2: Ignoring Cache Configuration
- **Description**: Not configuring proper inputs and outputs for caching
- **Why It's Problematic**: Results in cache misses and poor performance
- **Better Approach**: Carefully configure inputs, outputs, and dependencies for optimal caching

## Tools and Resources

### Turbo CLI and Development Tools
```bash
# Essential Turbo commands
turbo build                              # Build all packages
turbo build --filter=@company/web        # Build specific package
turbo build --filter='./apps/*'          # Build all apps
turbo build --filter=[HEAD^1]            # Build changed packages
turbo test --parallel                     # Run tests in parallel
turbo run build --dry-run                # Show what would be executed
turbo run build --graph                  # Show task dependency graph
turbo prune --scope=@company/web          # Create pruned workspace

# Cache management
turbo run build --force                  # Force rebuild (ignore cache)
turbo run build --no-cache               # Disable caching
turbo cache clean                        # Clear local cache
turbo login                              # Login to remote cache
turbo link                               # Link to remote cache

# Performance analysis
turbo run build --profile               # Generate performance profile
turbo run build --summarize             # Show build summary
turbo run build --dry-run=json          # Output build plan as JSON
```

### Remote Cache Setup
```bash
# Vercel Remote Cache setup
turbo login
turbo link

# Set up environment variables for CI
export TURBO_TOKEN="your-token"
export TURBO_TEAM="your-team"

# Custom remote cache (example with AWS S3)
export TURBO_API="https://your-cache-api.com"
export TURBO_TOKEN="your-api-token"
```

### Learning Resources
- **Turbo Documentation**: https://turbo.build/repo/docs
- **Turbo Examples**: https://github.com/vercel/turbo/tree/main/examples
- **Monorepo Best Practices**: https://turbo.build/repo/docs/handbook
- **Performance Guide**: https://turbo.build/repo/docs/core-concepts/caching

## Quality and Compliance

### Quality Standards
- Fast incremental builds (>80% cache hit rate in steady state)
- Proper task dependency configuration with optimal parallelization
- Comprehensive test coverage across all packages
- Consistent code formatting and linting across monorepo
- Automated dependency management and security updates

### Security Standards
- Secure remote cache access with proper authentication
- Regular dependency vulnerability scanning and updates
- Proper secret management for CI/CD environments
- Code signing and verification for published packages
- Access controls for monorepo package publishing

### Performance Standards
- Build time reduction of >50% compared to non-cached builds
- Optimal task parallelization with dependency-aware scheduling
- Efficient use of CI/CD resources with intelligent caching
- Fast local development feedback loops (<5 seconds for incremental changes)
- Effective use of remote cache across team members

## AI Assistant Guidelines

When helping with Turbo Build Tool:

1. **Caching Strategy**: Prioritize intelligent caching configuration for maximum performance gains
2. **Dependency Optimization**: Design task pipelines for optimal parallelization and dependency management
3. **Monorepo Structure**: Recommend proper package organization and workspace configuration
4. **Performance Focus**: Emphasize build speed optimization and cache hit rate improvement
5. **Team Collaboration**: Implement remote caching for team efficiency and CI/CD optimization
6. **Incremental Adoption**: Support gradual migration from existing build systems
7. **Monitoring Strategy**: Include performance monitoring and optimization techniques
8. **Integration Planning**: Consider integration with existing tools and workflows

### Decision Making Framework
When helping teams choose Turbo configurations:

1. **Project Analysis**: Understand monorepo structure and build requirements
2. **Performance Requirements**: Define build speed and caching targets
3. **Team Workflow**: Consider developer experience and collaboration needs
4. **CI/CD Integration**: Plan for automated build and deployment pipelines
5. **Scaling Strategy**: Design for future growth and package additions

### Code Generation Rules
- Generate optimal turbo.json configurations with proper task dependencies
- Include comprehensive caching strategies with inputs and outputs
- Use modern monorepo patterns with workspace configuration
- Implement proper CI/CD integration with remote caching
- Generate performance monitoring and optimization utilities
- Include testing and quality assurance integration across packages
- Provide clear documentation and team onboarding guides
- Include migration strategies from existing build systems

### Quality Enforcement
- ✅ Enforce proper task dependency configuration in turbo.json
- ✅ Require cache hit rate monitoring and optimization (target >80%)
- ✅ Block commits that break build pipeline or dependency graph
- ✅ Enforce consistent package.json scripts across workspace
- ✅ Require comprehensive testing strategy across all packages
- ✅ Enforce proper remote cache configuration for team environments
- ✅ Promote incremental migration strategies for existing projects
- ✅ Require performance monitoring and optimization documentation