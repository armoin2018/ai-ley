# esbuild JavaScript Bundler Instructions

## Tool Overview
- **Tool Name**: esbuild
- **Version**: 0.19+ (stable), 0.20+ (latest with enhanced features)
- **Category**: Build Tools
- **Purpose**: Extremely fast JavaScript/TypeScript bundler and minifier
- **Prerequisites**: Node.js 18+ (for npm installation), Go 1.18+ (for Go installation)

## Installation & Setup
### Installation Methods
```bash
# npm installation (most common)
npm install --save-dev esbuild
npm install -g esbuild

# yarn installation
yarn add --dev esbuild
yarn global add esbuild

# pnpm installation
pnpm add -D esbuild
pnpm add -g esbuild

# Deno installation
deno install --allow-all --name esbuild https://deno.land/x/esbuild/mod.js

# Go installation (native binary)
go install github.com/evanw/esbuild/cmd/esbuild@latest

# Download binary directly
curl -fsSL https://esbuild.github.io/download/latest | sh

# Platform-specific binaries
# macOS
curl -fsSL https://registry.npmjs.org/@esbuild/darwin-x64/-/darwin-x64-0.20.0.tgz

# Linux
curl -fsSL https://registry.npmjs.org/@esbuild/linux-x64/-/linux-x64-0.20.0.tgz

# Windows
curl -fsSL https://registry.npmjs.org/@esbuild/win32-x64/-/win32-x64-0.20.0.tgz

# Verify installation
esbuild --version
npx esbuild --version
```

### Project Integration
```bash
# Create build script in package.json
{
  "scripts": {
    "build": "esbuild src/index.js --bundle --outfile=dist/bundle.js",
    "build:watch": "esbuild src/index.js --bundle --outfile=dist/bundle.js --watch",
    "build:dev": "esbuild src/index.js --bundle --outfile=dist/bundle.js --sourcemap --watch",
    "build:prod": "esbuild src/index.js --bundle --minify --outfile=dist/bundle.js"
  }
}

# Create esbuild configuration file
touch esbuild.config.js
touch build.js
```

## Configuration

### Command Line Configuration
```bash
# Basic bundling
esbuild src/index.js --bundle --outfile=dist/bundle.js

# Multiple entry points
esbuild src/page1.js src/page2.js --bundle --outdir=dist

# TypeScript support
esbuild src/index.ts --bundle --outfile=dist/bundle.js

# JSX/React support
esbuild src/App.jsx --bundle --outfile=dist/bundle.js --jsx=automatic

# Development mode with sourcemap
esbuild src/index.js --bundle --outfile=dist/bundle.js --sourcemap --watch

# Production mode with minification
esbuild src/index.js --bundle --minify --outfile=dist/bundle.js

# Target specific environments
esbuild src/index.js --bundle --outfile=dist/bundle.js --target=es2020
esbuild src/index.js --bundle --outfile=dist/bundle.js --target=node16
esbuild src/index.js --bundle --outfile=dist/bundle.js --target=chrome90,firefox88
```

### JavaScript Configuration (esbuild.config.js)
```javascript
// esbuild.config.js
const esbuild = require('esbuild')

const config = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  platform: 'browser', // or 'node'
  target: ['es2020', 'chrome90', 'firefox88'],
  format: 'esm', // or 'cjs', 'iife'
  sourcemap: true,
  minify: false,
  splitting: false,
  treeShaking: true,
  loader: {
    '.png': 'file',
    '.jpg': 'file',
    '.svg': 'text',
    '.css': 'css'
  },
  define: {
    'process.env.NODE_ENV': '"development"',
    '__VERSION__': '"1.0.0"'
  },
  external: ['react', 'react-dom'],
  banner: {
    js: '/* esbuild bundle */',
    css: '/* esbuild styles */'
  },
  footer: {
    js: '/* end of bundle */'
  }
}

if (process.argv.includes('--watch')) {
  esbuild.context(config).then(ctx => {
    ctx.watch()
    console.log('Watching for changes...')
  })
} else {
  esbuild.build(config).catch(() => process.exit(1))
}
```

### Advanced Configuration
```javascript
// build.js - Advanced esbuild configuration
const esbuild = require('esbuild')
const path = require('path')

const isProduction = process.env.NODE_ENV === 'production'
const isDevelopment = !isProduction

const buildConfig = {
  entryPoints: [
    'src/index.ts',
    'src/worker.ts'
  ],
  bundle: true,
  outdir: 'dist',
  platform: 'browser',
  target: ['es2020'],
  format: 'esm',
  splitting: true,
  chunkNames: 'chunks/[name]-[hash]',
  assetNames: 'assets/[name]-[hash]',
  publicPath: '/static/',
  sourcemap: isDevelopment ? 'inline' : 'external',
  minify: isProduction,
  treeShaking: true,
  metafile: true,

  // Loaders for different file types
  loader: {
    '.png': 'file',
    '.jpg': 'file',
    '.jpeg': 'file',
    '.gif': 'file',
    '.svg': 'file',
    '.woff': 'file',
    '.woff2': 'file',
    '.ttf': 'file',
    '.eot': 'file',
    '.css': 'css',
    '.module.css': 'local-css'
  },

  // Define global variables
  define: {
    'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    '__DEV__': JSON.stringify(isDevelopment),
    '__VERSION__': JSON.stringify(require('./package.json').version),
    'global': 'globalThis'
  },

  // External dependencies (not bundled)
  external: [
    'react',
    'react-dom'
  ],

  // Inject polyfills or setup code
  inject: ['./src/polyfills.js'],

  // Banner and footer
  banner: {
    js: `/* Built with esbuild at ${new Date().toISOString()} */`,
    css: `/* Styles built with esbuild */`
  },

  // Resolve configuration
  resolveExtensions: ['.tsx', '.ts', '.jsx', '.js', '.json'],
  mainFields: ['browser', 'module', 'main'],
  conditions: ['browser', 'import', 'module', 'default'],

  // Drop console and debugger in production
  drop: isProduction ? ['console', 'debugger'] : [],

  // Keep names for better debugging
  keepNames: isDevelopment,

  // Legal comments handling
  legalComments: isProduction ? 'none' : 'inline'
}

async function build() {
  try {
    const result = await esbuild.build(buildConfig)

    if (result.metafile) {
      // Analyze bundle
      const analysis = await esbuild.analyzeMetafile(result.metafile, {
        verbose: true
      })
      console.log(analysis)

      // Write metafile for analysis tools
      require('fs').writeFileSync('meta.json', JSON.stringify(result.metafile))
    }

    console.log('Build completed successfully!')
  } catch (error) {
    console.error('Build failed:', error)
    process.exit(1)
  }
}

// Watch mode
async function watch() {
  const ctx = await esbuild.context(buildConfig)
  await ctx.watch()
  console.log('Watching for changes...')
}

if (process.argv.includes('--watch')) {
  watch()
} else {
  build()
}
```

### React/JSX Configuration
```javascript
// React build configuration
const reactConfig = {
  entryPoints: ['src/index.tsx'],
  bundle: true,
  outfile: 'dist/bundle.js',
  platform: 'browser',
  target: ['es2020'],
  format: 'esm',
  jsx: 'automatic', // React 17+ automatic JSX transform
  jsxFactory: 'React.createElement', // For older React versions
  jsxFragment: 'React.Fragment',
  jsxDev: process.env.NODE_ENV === 'development',
  loader: {
    '.js': 'jsx',
    '.ts': 'tsx'
  },
  define: {
    'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV)
  },
  external: ['react', 'react-dom']
}
```

## Core Features

### Bundling
- **Purpose**: Combine multiple JavaScript/TypeScript files into optimized bundles
- **Usage**: Create production-ready bundles with dependency resolution
- **Example**:
```bash
# Basic bundling
esbuild src/index.js --bundle --outfile=dist/bundle.js

# Multiple entry points
esbuild src/app.js src/worker.js --bundle --outdir=dist

# TypeScript bundling
esbuild src/index.ts --bundle --outfile=dist/bundle.js

# React/JSX bundling
esbuild src/App.jsx --bundle --jsx=automatic --outfile=dist/bundle.js

# Node.js bundling
esbuild src/server.js --bundle --platform=node --outfile=dist/server.js

# Code splitting
esbuild src/index.js --bundle --splitting --format=esm --outdir=dist

# Tree shaking (automatic)
esbuild src/index.js --bundle --outfile=dist/bundle.js # Dead code eliminated
```

### Minification
- **Purpose**: Reduce bundle size by removing whitespace and optimizing code
- **Usage**: Optimize code for production deployment
- **Example**:
```bash
# Basic minification
esbuild src/index.js --bundle --minify --outfile=dist/bundle.min.js

# Minify with sourcemap
esbuild src/index.js --bundle --minify --sourcemap --outfile=dist/bundle.min.js

# Minify and drop console statements
esbuild src/index.js --bundle --minify --drop:console --outfile=dist/bundle.min.js

# Advanced minification options
esbuild src/index.js \
  --bundle \
  --minify \
  --mangle-props=regex \
  --drop:console \
  --drop:debugger \
  --outfile=dist/bundle.min.js
```

### TypeScript Support
- **Purpose**: Compile TypeScript to JavaScript without separate compilation step
- **Usage**: Built-in TypeScript support with type stripping
- **Example**:
```bash
# TypeScript compilation
esbuild src/index.ts --outfile=dist/index.js

# TypeScript with bundling
esbuild src/index.ts --bundle --outfile=dist/bundle.js

# Multiple TypeScript files
esbuild src/**/*.ts --outdir=dist

# TypeScript with declaration files (type checking only)
tsc --noEmit && esbuild src/index.ts --bundle --outfile=dist/bundle.js

# TypeScript configuration
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "jsx": "preserve",
    "noEmit": true
  }
}
```

## Common Commands
```bash
# Basic operations
esbuild src/index.js --bundle --outfile=dist/bundle.js    # Bundle JavaScript
esbuild src/index.ts --bundle --outfile=dist/bundle.js    # Bundle TypeScript
esbuild src/index.js --minify --outfile=dist/bundle.min.js # Minify code

# Development workflow
esbuild src/index.js --bundle --watch --outfile=dist/bundle.js     # Watch mode
esbuild src/index.js --bundle --sourcemap --outfile=dist/bundle.js # Source maps
esbuild src/index.js --bundle --serve=8000 --outdir=dist           # Development server

# Production build
esbuild src/index.js --bundle --minify --sourcemap=external --outfile=dist/bundle.js

# Platform targeting
esbuild src/index.js --bundle --platform=browser --outfile=dist/bundle.js  # Browser
esbuild src/server.js --bundle --platform=node --outfile=dist/server.js    # Node.js

# Format targeting
esbuild src/index.js --bundle --format=esm --outfile=dist/bundle.mjs   # ES modules
esbuild src/index.js --bundle --format=cjs --outfile=dist/bundle.cjs   # CommonJS
esbuild src/index.js --bundle --format=iife --outfile=dist/bundle.js   # IIFE

# Multiple entry points
esbuild src/page1.js src/page2.js --bundle --outdir=dist              # Multiple bundles
esbuild src/index.js --bundle --splitting --format=esm --outdir=dist   # Code splitting

# Asset handling
esbuild src/index.js --bundle --loader:.png=file --outfile=dist/bundle.js    # File loader
esbuild src/index.js --bundle --loader:.svg=text --outfile=dist/bundle.js    # Text loader

# Environment and defines
esbuild src/index.js --bundle --define:process.env.NODE_ENV='"production"' --outfile=dist/bundle.js

# External dependencies
esbuild src/index.js --bundle --external:react --external:react-dom --outfile=dist/bundle.js

# Analysis and debugging
esbuild src/index.js --bundle --metafile=meta.json --outfile=dist/bundle.js  # Generate metafile
esbuild --analyze meta.json                                                  # Analyze bundle
```

## Advanced Features

### Plugin System
```javascript
// Custom plugin example
const customPlugin = {
  name: 'custom-plugin',
  setup(build) {
    // Intercept file resolution
    build.onResolve({ filter: /^virtual:/ }, args => {
      return {
        path: args.path,
        namespace: 'virtual'
      }
    })

    // Load virtual modules
    build.onLoad({ filter: /.*/, namespace: 'virtual' }, args => {
      return {
        contents: 'export default "Virtual module content"',
        loader: 'js'
      }
    })

    // Transform files
    build.onLoad({ filter: /\.special$/ }, async args => {
      const source = await require('fs').promises.readFile(args.path, 'utf8')
      return {
        contents: `export default ${JSON.stringify(source)}`,
        loader: 'js'
      }
    })
  }
}

// Use plugin in build
esbuild.build({
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  plugins: [customPlugin]
})
```

### File Loaders and Asset Processing
```javascript
const buildConfig = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  loader: {
    // Image files
    '.png': 'file',     // Copy to output and return URL
    '.jpg': 'file',
    '.jpeg': 'file',
    '.gif': 'file',
    '.webp': 'file',

    // SVG handling
    '.svg': 'file',     // As file URL
    // '.svg': 'text',  // As text content
    // '.svg': 'dataurl', // As data URL

    // Font files
    '.woff': 'file',
    '.woff2': 'file',
    '.ttf': 'file',
    '.otf': 'file',
    '.eot': 'file',

    // CSS and styles
    '.css': 'css',
    '.module.css': 'local-css',

    // Data files
    '.json': 'json',
    '.txt': 'text',
    '.xml': 'text',

    // Web Assembly
    '.wasm': 'file',

    // TypeScript
    '.ts': 'ts',
    '.tsx': 'tsx',

    // JavaScript variations
    '.js': 'js',
    '.jsx': 'jsx',
    '.mjs': 'js'
  },
  assetNames: 'assets/[name]-[hash]'
}
```

### Code Splitting
```javascript
// Automatic code splitting
const splittingConfig = {
  entryPoints: [
    'src/home.js',
    'src/about.js',
    'src/contact.js'
  ],
  bundle: true,
  splitting: true,  // Enable code splitting
  format: 'esm',    // Required for splitting
  outdir: 'dist',
  chunkNames: 'chunks/[name]-[hash]'
}

// Manual chunk splitting with dynamic imports
// src/index.js
async function loadModule() {
  const { default: heavyModule } = await import('./heavy-module.js')
  return heavyModule
}

// This creates a separate chunk for heavy-module.js
```

### Watch Mode and Development Server
```javascript
// Watch mode
async function startWatcher() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: 'dist',
    sourcemap: true
  })

  await ctx.watch()
  console.log('Watching...')
}

// Development server
async function startServer() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: 'dist',
    sourcemap: true
  })

  const { host, port } = await ctx.serve({
    servedir: 'dist',
    port: 8000,
    host: 'localhost'
  })

  console.log(`Server running at http://${host}:${port}`)
}

// Combined watch and serve
async function develop() {
  const ctx = await esbuild.context({
    entryPoints: ['src/index.js'],
    bundle: true,
    outdir: 'dist',
    sourcemap: true,
    banner: {
      js: '(() => new EventSource("/esbuild").addEventListener("change", () => location.reload()))();'
    }
  })

  await ctx.watch()
  await ctx.serve({
    servedir: 'dist',
    port: 8000
  })
}
```

## Performance Optimization

### Build Speed Optimization
```bash
# Use native esbuild binary instead of npm package
go install github.com/evanw/esbuild/cmd/esbuild@latest

# Optimize for development speed
esbuild src/index.js \
  --bundle \
  --sourcemap=inline \
  --target=esnext \
  --format=esm \
  --outfile=dist/bundle.js

# Incremental builds
node -e "
const esbuild = require('esbuild');
esbuild.context({
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  incremental: true
}).then(ctx => ctx.rebuild())
"

# Parallel builds for multiple targets
npm run build:browser & npm run build:node & wait
```

### Bundle Size Optimization
```bash
# Tree shaking (automatic with ES modules)
esbuild src/index.js --bundle --format=esm --outfile=dist/bundle.js

# Minification and compression
esbuild src/index.js \
  --bundle \
  --minify \
  --mangle-props=_$ \
  --drop:console \
  --drop:debugger \
  --outfile=dist/bundle.min.js

# External dependencies
esbuild src/index.js \
  --bundle \
  --external:react \
  --external:react-dom \
  --external:lodash \
  --outfile=dist/bundle.js

# Bundle analysis
esbuild src/index.js \
  --bundle \
  --metafile=meta.json \
  --outfile=dist/bundle.js

# Analyze the metafile
npx esbuild --analyze meta.json
```

### Memory Optimization
```javascript
// Streaming builds for large projects
const fs = require('fs')
const esbuild = require('esbuild')

async function streamingBuild() {
  const result = await esbuild.build({
    entryPoints: ['src/index.js'],
    bundle: true,
    write: false, // Don't write to disk
    format: 'esm'
  })

  // Stream output
  const stream = fs.createWriteStream('dist/bundle.js')
  stream.write(result.outputFiles[0].contents)
  stream.end()
}
```

## Integration Patterns

### React Development
```javascript
// React development setup
const reactDevConfig = {
  entryPoints: ['src/index.tsx'],
  bundle: true,
  outdir: 'dist',
  platform: 'browser',
  target: ['es2020'],
  format: 'esm',
  jsx: 'automatic',
  jsxDev: true,
  sourcemap: true,
  define: {
    'process.env.NODE_ENV': '"development"'
  },
  loader: {
    '.svg': 'file',
    '.css': 'css',
    '.module.css': 'local-css'
  },
  banner: {
    js: `
      // React Fast Refresh
      if (typeof window !== 'undefined' && window.__REACT_DEVTOOLS_GLOBAL_HOOK__) {
        window.__REACT_DEVTOOLS_GLOBAL_HOOK__.onCommitFiberRoot = (id, root) => {
          // Fast refresh logic
        }
      }
    `
  }
}

// React production build
const reactProdConfig = {
  ...reactDevConfig,
  minify: true,
  sourcemap: 'external',
  jsxDev: false,
  define: {
    'process.env.NODE_ENV': '"production"'
  },
  drop: ['console', 'debugger']
}
```

### Node.js Library Development
```javascript
// Node.js library configuration
const nodeLibConfig = {
  entryPoints: ['src/index.ts'],
  bundle: true,
  platform: 'node',
  target: ['node16'],
  format: 'cjs',
  outfile: 'dist/index.js',
  external: [
    'fs',
    'path',
    'url',
    'util'
  ],
  banner: {
    js: '#!/usr/bin/env node'
  }
}

// Dual package (CJS + ESM)
const dualPackageConfig = [
  {
    ...nodeLibConfig,
    format: 'cjs',
    outfile: 'dist/index.cjs'
  },
  {
    ...nodeLibConfig,
    format: 'esm',
    outfile: 'dist/index.mjs'
  }
]
```

### Monorepo Setup
```javascript
// Monorepo build script
const path = require('path')
const esbuild = require('esbuild')

const packages = [
  'packages/ui',
  'packages/utils',
  'packages/core'
]

async function buildAllPackages() {
  const builds = packages.map(pkg => {
    const pkgJson = require(path.join(pkg, 'package.json'))

    return esbuild.build({
      entryPoints: [path.join(pkg, 'src/index.ts')],
      bundle: true,
      outfile: path.join(pkg, 'dist/index.js'),
      platform: 'browser',
      target: ['es2020'],
      format: 'esm',
      external: Object.keys(pkgJson.peerDependencies || {}),
      sourcemap: true
    })
  })

  await Promise.all(builds)
  console.log('All packages built successfully!')
}
```

## Environment-Specific Configuration

### Development Environment
```javascript
// development.config.js
module.exports = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  sourcemap: 'inline',
  watch: true,
  define: {
    'process.env.NODE_ENV': '"development"',
    '__DEV__': 'true'
  },
  banner: {
    js: '// Development build - not optimized'
  }
}
```

### Production Environment
```javascript
// production.config.js
module.exports = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  minify: true,
  sourcemap: 'external',
  treeShaking: true,
  define: {
    'process.env.NODE_ENV': '"production"',
    '__DEV__': 'false'
  },
  drop: ['console', 'debugger'],
  legalComments: 'none'
}
```

### CI/CD Integration
```yaml
# GitHub Actions example
name: Build with esbuild
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Build with esbuild
      run: npm run build

    - name: Analyze bundle
      run: |
        npm run build:analyze
        cat meta.json | jq '.outputs'

    - name: Upload build artifacts
      uses: actions/upload-artifact@v3
      with:
        name: build-output
        path: dist/
```

## Common Issues & Solutions

### Import Resolution Issues
**Problem**: Module not found or incorrect imports
**Solution**: Configure resolve options and external dependencies
```javascript
const config = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  resolveExtensions: ['.tsx', '.ts', '.jsx', '.js', '.json'],
  mainFields: ['browser', 'module', 'main'],
  conditions: ['browser', 'import', 'require', 'default'],
  external: ['react', 'react-dom'], // Don't bundle these
  alias: {
    '@': path.resolve('./src'),
    'components': path.resolve('./src/components')
  }
}
```

### TypeScript Configuration Issues
**Problem**: TypeScript compilation errors or type checking
**Solution**: Separate type checking from bundling
```bash
# Check types separately
npx tsc --noEmit

# Then bundle with esbuild
npx esbuild src/index.ts --bundle --outfile=dist/bundle.js

# Or use both in package.json
{
  "scripts": {
    "type-check": "tsc --noEmit",
    "build": "npm run type-check && esbuild src/index.ts --bundle --outfile=dist/bundle.js"
  }
}
```

### CSS and Asset Loading Issues
**Problem**: CSS or assets not loading correctly
**Solution**: Configure appropriate loaders and public paths
```javascript
const config = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  loader: {
    '.css': 'css',
    '.png': 'file',
    '.svg': 'file'
  },
  assetNames: 'assets/[name]-[hash]',
  publicPath: '/static/', // For assets served from different path
  external: [], // Make sure CSS files aren't external
}
```

### Performance Issues
**Problem**: Slow build times or large bundles
**Solution**: Optimize configuration and use appropriate settings
```bash
# Use incremental builds
node build.js --incremental

# Analyze bundle size
esbuild src/index.js --bundle --metafile=meta.json --outfile=dist/bundle.js
esbuild --analyze meta.json

# External large dependencies
esbuild src/index.js \
  --bundle \
  --external:three.js \
  --external:d3 \
  --outfile=dist/bundle.js
```

## Useful Resources
- **Official Documentation**: https://esbuild.github.io/
- **API Reference**: https://esbuild.github.io/api/
- **Plugin Examples**: https://github.com/esbuild/community-plugins
- **Performance Comparisons**: https://esbuild.github.io/faq/#benchmark-details
- **GitHub Repository**: https://github.com/evanw/esbuild

## Tool-Specific Guidelines

### Best Practices
- Use esbuild for development builds due to speed
- Combine with TypeScript compiler for type checking
- Use code splitting for large applications
- External CDN dependencies to reduce bundle size
- Generate metafiles for bundle analysis

### Performance Tips
- Use native Go binary for maximum speed
- Enable incremental builds for development
- Use appropriate target settings for your environment
- Minimize the number of entry points
- Use tree shaking with ES modules

### Security Considerations
- Validate all user inputs in custom plugins
- Use define carefully to avoid code injection
- Keep dependencies updated for security patches
- Use sourcemaps appropriately (external for production)
- Review bundle contents regularly

## Version Compatibility
- **Node.js**: 18+ (for npm package), any version (for binary)
- **TypeScript**: 4.5+ (built-in support)
- **JavaScript**: ES5+ output, ES2015+ input
- **React**: Any version (with proper JSX configuration)

## Troubleshooting

### Debug Mode
```bash
# Verbose logging
esbuild src/index.js --bundle --log-level=verbose --outfile=dist/bundle.js

# Debug specific loader
esbuild src/index.js --bundle --log-level=debug --outfile=dist/bundle.js

# Analyze resolution
esbuild src/index.js --bundle --log-level=info --outfile=dist/bundle.js

# Check metafile
esbuild src/index.js --bundle --metafile=meta.json --outfile=dist/bundle.js
cat meta.json | jq '.inputs'
```

### Common Error Messages
- **Error**: `Could not resolve "module"`
  **Cause**: Missing dependency or incorrect import path
  **Solution**: Install dependency or check import path

- **Error**: `No loader is configured for ".ext" files`
  **Cause**: File extension not configured
  **Solution**: Add loader configuration for the file type

- **Error**: `Transform failed with X errors`
  **Cause**: Syntax errors in source code
  **Solution**: Check source code syntax and TypeScript configuration
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

```

```
