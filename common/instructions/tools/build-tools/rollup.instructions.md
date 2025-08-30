# Rollup JavaScript Bundler Instructions

## Tool Overview
- **Tool Name**: Rollup
- **Version**: 4.0+ (stable), 4.9+ (latest with enhanced features)
- **Category**: Build Tools
- **Purpose**: JavaScript module bundler optimized for libraries and tree shaking
- **Prerequisites**: Node.js 18+ (16+ minimum), npm/yarn/pnpm

## Installation & Setup
### Installation Methods
```bash
# npm installation
npm install --save-dev rollup
npm install -g rollup

# yarn installation
yarn add --dev rollup
yarn global add rollup

# pnpm installation
pnpm add -D rollup
pnpm add -g rollup

# Install with commonly used plugins
npm install --save-dev rollup @rollup/plugin-node-resolve @rollup/plugin-commonjs @rollup/plugin-typescript

# Verify installation
rollup --version
npx rollup --version
```

### Project Integration
```bash
# Create rollup configuration
touch rollup.config.js
touch rollup.config.mjs  # For ES modules

# Basic package.json setup
{
  "scripts": {
    "build": "rollup -c",
    "build:watch": "rollup -c -w",
    "build:dev": "rollup -c --environment NODE_ENV:development",
    "build:prod": "rollup -c --environment NODE_ENV:production"
  },
  "main": "dist/bundle.cjs.js",
  "module": "dist/bundle.esm.js",
  "browser": "dist/bundle.umd.js",
  "types": "dist/index.d.ts"
}

# Initialize with npm init
npm init -y
```

## Configuration

### Basic Configuration (rollup.config.js)
```javascript
// rollup.config.js
export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'umd',
    name: 'MyLibrary'
  }
}

// Multiple outputs
export default {
  input: 'src/index.js',
  output: [
    {
      file: 'dist/bundle.cjs.js',
      format: 'cjs'
    },
    {
      file: 'dist/bundle.esm.js',
      format: 'es'
    },
    {
      file: 'dist/bundle.umd.js',
      format: 'umd',
      name: 'MyLibrary'
    }
  ]
}
```

### Advanced Configuration
```javascript
// rollup.config.js
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import typescript from '@rollup/plugin-typescript'
import { terser } from 'rollup-plugin-terser'
import babel from '@rollup/plugin-babel'
import json from '@rollup/plugin-json'
import replace from '@rollup/plugin-replace'

const isProduction = process.env.NODE_ENV === 'production'

export default {
  input: 'src/index.ts',

  output: [
    // CommonJS build
    {
      file: 'dist/index.cjs.js',
      format: 'cjs',
      exports: 'named',
      sourcemap: true
    },

    // ES modules build
    {
      file: 'dist/index.esm.js',
      format: 'es',
      sourcemap: true
    },

    // UMD build for browsers
    {
      file: 'dist/index.umd.js',
      format: 'umd',
      name: 'MyLibrary',
      globals: {
        'react': 'React',
        'react-dom': 'ReactDOM'
      },
      sourcemap: true
    }
  ],

  // External dependencies (not bundled)
  external: [
    'react',
    'react-dom',
    'lodash'
  ],

  plugins: [
    // Resolve node modules
    resolve({
      browser: true,
      preferBuiltins: false
    }),

    // Convert CommonJS to ES modules
    commonjs(),

    // TypeScript support
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist'
    }),

    // JSON imports
    json(),

    // Environment variables
    replace({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
      preventAssignment: true
    }),

    // Babel transpilation
    babel({
      babelHelpers: 'bundled',
      exclude: 'node_modules/**',
      presets: [
        ['@babel/preset-env', { targets: { node: '16' } }]
      ]
    }),

    // Minification for production
    isProduction && terser({
      compress: {
        drop_console: true,
        drop_debugger: true
      }
    })
  ].filter(Boolean),

  // Input options
  preserveEntrySignatures: 'strict',

  // Watch options
  watch: {
    include: 'src/**',
    exclude: 'node_modules/**'
  }
}
```

### Multiple Entry Points Configuration
```javascript
// rollup.config.js - Multiple entries
export default [
  // Main library build
  {
    input: 'src/index.ts',
    output: [
      { file: 'dist/index.cjs.js', format: 'cjs' },
      { file: 'dist/index.esm.js', format: 'es' }
    ],
    external: ['react', 'react-dom'],
    plugins: [resolve(), commonjs(), typescript()]
  },

  // CLI tool build
  {
    input: 'src/cli.ts',
    output: {
      file: 'dist/cli.js',
      format: 'cjs',
      banner: '#!/usr/bin/env node'
    },
    external: ['fs', 'path', 'process'],
    plugins: [resolve(), commonjs(), typescript()]
  },

  // Browser-specific build
  {
    input: 'src/browser.ts',
    output: {
      file: 'dist/browser.js',
      format: 'iife',
      name: 'MyLibraryBrowser'
    },
    plugins: [
      resolve({ browser: true }),
      commonjs(),
      typescript(),
      terser()
    ]
  }
]
```

### React Library Configuration
```javascript
// rollup.config.js - React component library
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import typescript from '@rollup/plugin-typescript'
import peerDepsExternal from 'rollup-plugin-peer-deps-external'
import postcss from 'rollup-plugin-postcss'
import { terser } from 'rollup-plugin-terser'

export default {
  input: 'src/index.ts',

  output: [
    {
      file: 'dist/index.cjs.js',
      format: 'cjs',
      sourcemap: true,
      exports: 'named'
    },
    {
      file: 'dist/index.esm.js',
      format: 'esm',
      sourcemap: true
    }
  ],

  plugins: [
    // Automatically externalize peer dependencies
    peerDepsExternal(),

    // Resolve node modules
    resolve(),

    // CommonJS support
    commonjs(),

    // TypeScript compilation
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist/types'
    }),

    // CSS processing
    postcss({
      extract: 'styles.css',
      minimize: true,
      modules: true
    }),

    // Minification
    terser()
  ],

  external: ['react', 'react-dom']
}
```

## Core Features

### Module Bundling
- **Purpose**: Bundle JavaScript modules with optimal tree shaking
- **Usage**: Create efficient bundles for libraries and applications
- **Example**:
```bash
# Basic bundling
rollup src/index.js --file dist/bundle.js --format umd --name MyLibrary

# Multiple formats
rollup src/index.js --file dist/bundle.cjs.js --format cjs
rollup src/index.js --file dist/bundle.esm.js --format es
rollup src/index.js --file dist/bundle.umd.js --format umd --name MyLibrary

# With configuration file
rollup -c
rollup --config rollup.config.js

# Watch mode
rollup -c -w
rollup --config --watch

# Environment-specific builds
rollup -c --environment NODE_ENV:production
rollup -c --environment BUILD:development
```

### Tree Shaking
- **Purpose**: Eliminate dead code and unused exports
- **Usage**: Automatically remove unused code for smaller bundles
- **Example**:
```javascript
// Source: utils.js
export function usedFunction() {
  return 'This will be included'
}

export function unusedFunction() {
  return 'This will be removed'
}

// Source: index.js
import { usedFunction } from './utils.js'
console.log(usedFunction())

// Rollup automatically removes unusedFunction from the bundle

// Configuration for tree shaking
export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },
  treeshake: {
    moduleSideEffects: false,  // Assume modules have no side effects
    propertyReadSideEffects: false,
    tryCatchDeoptimization: false
  }
}
```

### Code Splitting
- **Purpose**: Split code into multiple chunks for better loading performance
- **Usage**: Create separate bundles for different parts of your application
- **Example**:
```javascript
// Dynamic imports for code splitting
export default {
  input: ['src/main.js', 'src/module.js'],
  output: {
    dir: 'dist',
    format: 'es',
    chunkFileNames: 'chunks/[name]-[hash].js'
  },
  plugins: [resolve(), commonjs()]
}

// Manual chunks
export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es'
  },
  manualChunks: {
    vendor: ['react', 'react-dom'],
    utils: ['lodash', 'moment']
  }
}

// Dynamic chunk generation
export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es'
  },
  manualChunks(id) {
    if (id.includes('node_modules')) {
      return 'vendor'
    }
    if (id.includes('src/utils')) {
      return 'utils'
    }
  }
}
```

## Common Commands
```bash
# Basic operations
rollup src/index.js --file dist/bundle.js --format umd --name MyLib    # Bundle to UMD
rollup src/index.js --file dist/bundle.js --format es                  # Bundle to ES modules
rollup src/index.js --file dist/bundle.js --format cjs                 # Bundle to CommonJS

# Configuration-based builds
rollup -c                           # Use rollup.config.js
rollup --config custom.config.js   # Use custom config
rollup -c -w                        # Watch mode
rollup -c --watch                   # Watch mode (explicit)

# Environment and variables
rollup -c --environment NODE_ENV:production        # Set environment
rollup -c --environment BUILD:dev,TARGET:browser   # Multiple variables

# Output options
rollup src/index.js -o dist/bundle.js -f umd -n MyLib     # Short flags
rollup src/index.js --dir dist --format es                # Output directory

# Plugin and external handling
rollup -c --external react,react-dom                      # External dependencies
rollup -c --globals react:React,react-dom:ReactDOM        # Global variable mapping

# Development and debugging
rollup -c --sourcemap              # Generate source maps
rollup -c --silent                 # Suppress output
rollup -c --verbose                # Verbose logging
rollup -c --stats                  # Bundle analysis

# Production builds
rollup -c --environment NODE_ENV:production,BUILD:prod    # Production environment
rollup -c --compact                # Compact output
```

## Advanced Features

### Plugin Development
```javascript
// Custom plugin example
function customPlugin(options = {}) {
  return {
    name: 'custom-plugin',

    // Build hooks
    buildStart(opts) {
      console.log('Build starting...')
    },

    // Resolve imports
    resolveId(id, importer) {
      if (id === 'virtual:custom') {
        return id
      }
      return null
    },

    // Load modules
    load(id) {
      if (id === 'virtual:custom') {
        return 'export default "Custom virtual module"'
      }
      return null
    },

    // Transform code
    transform(code, id) {
      if (id.endsWith('.special')) {
        return {
          code: `export default ${JSON.stringify(code)}`,
          map: null
        }
      }
      return null
    },

    // Generate bundle
    generateBundle(opts, bundle) {
      // Modify bundle before write
      Object.keys(bundle).forEach(fileName => {
        const file = bundle[fileName]
        if (file.type === 'chunk') {
          file.code = `/* Custom header */\n${file.code}`
        }
      })
    },

    // Write bundle
    writeBundle(opts, bundle) {
      console.log('Bundle written successfully')
    }
  }
}

// Use custom plugin
export default {
  input: 'src/index.js',
  output: { file: 'dist/bundle.js', format: 'es' },
  plugins: [customPlugin({ option: 'value' })]
}
```

### Asset Processing
```javascript
import { createFilter } from '@rollup/pluginutils'
import path from 'path'

// Asset plugin for handling images, fonts, etc.
function assetPlugin(options = {}) {
  const filter = createFilter(options.include, options.exclude)

  return {
    name: 'asset-plugin',
    load(id) {
      if (filter(id) && /\.(png|jpg|gif|svg|woff|woff2)$/.test(id)) {
        const referenceId = this.emitFile({
          type: 'asset',
          name: path.basename(id),
          source: require('fs').readFileSync(id)
        })

        return `export default import.meta.ROLLUP_FILE_URL_${referenceId}`
      }
    }
  }
}

// Configuration with asset handling
export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es',
    assetFileNames: 'assets/[name]-[hash][extname]'
  },
  plugins: [
    assetPlugin({
      include: ['**/*.png', '**/*.jpg', '**/*.svg']
    })
  ]
}
```

### Conditional Builds
```javascript
// rollup.config.js - Environment-based configuration
const isProduction = process.env.NODE_ENV === 'production'
const isDevelopment = !isProduction

const baseConfig = {
  input: 'src/index.js',
  external: ['react', 'react-dom'],
  plugins: [
    resolve(),
    commonjs(),
    typescript()
  ]
}

const developmentConfig = {
  ...baseConfig,
  output: {
    file: 'dist/bundle.dev.js',
    format: 'es',
    sourcemap: true
  },
  watch: {
    include: 'src/**'
  }
}

const productionConfig = {
  ...baseConfig,
  output: [
    {
      file: 'dist/bundle.cjs.js',
      format: 'cjs',
      exports: 'named'
    },
    {
      file: 'dist/bundle.esm.js',
      format: 'es'
    },
    {
      file: 'dist/bundle.umd.js',
      format: 'umd',
      name: 'MyLibrary'
    }
  ],
  plugins: [
    ...baseConfig.plugins,
    terser({
      compress: {
        drop_console: true
      }
    })
  ]
}

export default isDevelopment ? developmentConfig : productionConfig
```

## Plugin Ecosystem

### Essential Plugins
```bash
# Core plugins
npm install --save-dev @rollup/plugin-node-resolve    # Resolve node modules
npm install --save-dev @rollup/plugin-commonjs       # CommonJS support
npm install --save-dev @rollup/plugin-json           # JSON imports
npm install --save-dev @rollup/plugin-replace        # String replacement

# Language support
npm install --save-dev @rollup/plugin-typescript     # TypeScript
npm install --save-dev @rollup/plugin-babel          # Babel
npm install --save-dev rollup-plugin-esbuild         # esbuild integration

# Optimization
npm install --save-dev rollup-plugin-terser          # Minification
npm install --save-dev rollup-plugin-visualizer      # Bundle analysis
npm install --save-dev rollup-plugin-filesize        # File size reporting

# Development
npm install --save-dev rollup-plugin-serve           # Development server
npm install --save-dev rollup-plugin-livereload      # Live reload
npm install --save-dev rollup-plugin-copy            # Copy files

# CSS and assets
npm install --save-dev rollup-plugin-postcss        # PostCSS
npm install --save-dev rollup-plugin-styles         # CSS imports
npm install --save-dev rollup-plugin-url            # Asset imports
```

### Plugin Configuration Examples
```javascript
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import typescript from '@rollup/plugin-typescript'
import babel from '@rollup/plugin-babel'
import json from '@rollup/plugin-json'
import replace from '@rollup/plugin-replace'
import { terser } from 'rollup-plugin-terser'
import postcss from 'rollup-plugin-postcss'
import serve from 'rollup-plugin-serve'
import livereload from 'rollup-plugin-livereload'

export default {
  input: 'src/index.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'umd',
    name: 'MyLibrary'
  },
  plugins: [
    // Resolve node modules
    resolve({
      browser: true,
      preferBuiltins: false,
      extensions: ['.js', '.jsx', '.ts', '.tsx']
    }),

    // CommonJS conversion
    commonjs({
      include: 'node_modules/**'
    }),

    // TypeScript compilation
    typescript({
      tsconfig: './tsconfig.json',
      sourceMap: true,
      inlineSources: true
    }),

    // JSON imports
    json(),

    // Environment variables
    replace({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
      preventAssignment: true
    }),

    // Babel transpilation
    babel({
      babelHelpers: 'bundled',
      exclude: 'node_modules/**',
      extensions: ['.js', '.jsx', '.ts', '.tsx']
    }),

    // CSS processing
    postcss({
      extract: true,
      minimize: true,
      sourceMap: true
    }),

    // Development server
    process.env.NODE_ENV === 'development' && serve({
      contentBase: 'dist',
      port: 3000,
      open: true
    }),

    // Live reload
    process.env.NODE_ENV === 'development' && livereload('dist'),

    // Minification
    process.env.NODE_ENV === 'production' && terser()
  ].filter(Boolean)
}
```

## Library Development Patterns

### NPM Package Configuration
```json
{
  "name": "my-awesome-library",
  "version": "1.0.0",
  "description": "An awesome JavaScript library",
  "main": "dist/index.cjs.js",
  "module": "dist/index.esm.js",
  "browser": "dist/index.umd.js",
  "types": "dist/index.d.ts",
  "files": [
    "dist",
    "README.md",
    "LICENSE"
  ],
  "scripts": {
    "build": "rollup -c",
    "build:watch": "rollup -c -w",
    "dev": "rollup -c --environment NODE_ENV:development",
    "prepublishOnly": "npm run build"
  },
  "peerDependencies": {
    "react": ">=16.8.0",
    "react-dom": ">=16.8.0"
  },
  "devDependencies": {
    "rollup": "^4.0.0",
    "@rollup/plugin-typescript": "^11.0.0",
    "typescript": "^5.0.0"
  }
}
```

### TypeScript Library Setup
```typescript
// src/index.ts
export interface Config {
  apiKey: string
  endpoint?: string
}

export class MyLibrary {
  private config: Config

  constructor(config: Config) {
    this.config = config
  }

  async fetchData(): Promise<any> {
    const response = await fetch(`${this.config.endpoint || '/api'}/data`, {
      headers: {
        'Authorization': `Bearer ${this.config.apiKey}`
      }
    })
    return response.json()
  }
}

export default MyLibrary

// Export everything for named imports
export * from './utils'
export * from './types'
```

```javascript
// rollup.config.js for TypeScript library
import typescript from '@rollup/plugin-typescript'
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import { terser } from 'rollup-plugin-terser'

export default {
  input: 'src/index.ts',

  output: [
    // CommonJS for Node.js
    {
      file: 'dist/index.cjs.js',
      format: 'cjs',
      exports: 'named',
      sourcemap: true
    },

    // ES modules for bundlers
    {
      file: 'dist/index.esm.js',
      format: 'es',
      sourcemap: true
    },

    // UMD for browsers
    {
      file: 'dist/index.umd.js',
      format: 'umd',
      name: 'MyLibrary',
      sourcemap: true
    },

    // Minified UMD
    {
      file: 'dist/index.umd.min.js',
      format: 'umd',
      name: 'MyLibrary',
      plugins: [terser()]
    }
  ],

  external: ['react', 'react-dom'],

  plugins: [
    resolve(),
    commonjs(),
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist'
    })
  ]
}
```

### Monorepo Library Setup
```javascript
// rollup.config.js for monorepo
import path from 'path'
import { promises as fs } from 'fs'

async function getPackages() {
  const packagesDir = path.resolve('packages')
  const packages = await fs.readdir(packagesDir)

  return packages.map(pkg => ({
    name: pkg,
    input: path.resolve(packagesDir, pkg, 'src/index.ts'),
    outputDir: path.resolve(packagesDir, pkg, 'dist')
  }))
}

export default async () => {
  const packages = await getPackages()

  return packages.map(pkg => ({
    input: pkg.input,
    output: [
      {
        file: path.join(pkg.outputDir, 'index.cjs.js'),
        format: 'cjs',
        exports: 'named'
      },
      {
        file: path.join(pkg.outputDir, 'index.esm.js'),
        format: 'es'
      }
    ],
    external: ['react', 'react-dom'],
    plugins: [
      resolve(),
      commonjs(),
      typescript({
        tsconfig: path.resolve('packages', pkg.name, 'tsconfig.json')
      })
    ]
  }))
}
```

## Performance Optimization

### Bundle Size Optimization
```javascript
// rollup.config.js - Size optimization
export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },

  // External dependencies
  external: [
    'react',
    'react-dom',
    'lodash',
    /^@babel\/runtime/
  ],

  // Tree shaking configuration
  treeshake: {
    moduleSideEffects: false,
    propertyReadSideEffects: false,
    tryCatchDeoptimization: false
  },

  plugins: [
    resolve({
      // Only bundle what's needed
      preferBuiltins: true
    }),

    // Analyze bundle size
    bundleAnalyzer({
      openAnalyzer: false,
      analyzerMode: 'json',
      reportFilename: 'bundle-report.json'
    }),

    // Minification
    terser({
      compress: {
        drop_console: true,
        drop_debugger: true,
        pure_funcs: ['console.log']
      },
      mangle: {
        properties: {
          regex: /^_/  // Mangle private properties
        }
      }
    })
  ]
}
```

### Build Performance
```javascript
// Fast development builds
const isDev = process.env.NODE_ENV === 'development'

export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es'
  },

  plugins: [
    resolve(),
    commonjs(),

    // Fast TypeScript compilation
    isDev ? esbuild({
      target: 'es2020'
    }) : typescript(),

    // Skip minification in development
    !isDev && terser()
  ].filter(Boolean),

  // Faster builds in development
  watch: isDev ? {
    include: 'src/**',
    exclude: 'node_modules/**',
    chokidar: {
      usePolling: false
    }
  } : false
}
```

## Common Issues & Solutions

### Import/Export Issues
**Problem**: Mixing CommonJS and ES modules
**Solution**: Proper external configuration and plugin setup
```javascript
export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },
  external: [
    // Mark Node.js built-ins as external
    'fs', 'path', 'url', 'util',
    // Mark dependencies as external
    'react', 'react-dom'
  ],
  plugins: [
    resolve({
      preferBuiltins: true  // Prefer Node.js built-ins
    }),
    commonjs({
      // Convert CommonJS to ES modules
      transformMixedEsModules: true
    })
  ]
}
```

### TypeScript Declaration Issues
**Problem**: Type declarations not generated correctly
**Solution**: Proper TypeScript plugin configuration
```javascript
import typescript from '@rollup/plugin-typescript'

export default {
  input: 'src/index.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },
  plugins: [
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist/types',
      rootDir: 'src'
    })
  ]
}

// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "declaration": true,
    "outDir": "dist",
    "rootDir": "src",
    "strict": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### Circular Dependency Issues
**Problem**: Circular dependencies causing build errors
**Solution**: Restructure code and use proper imports
```bash
# Detect circular dependencies
npm install --save-dev circular-dependency-plugin

# In rollup config
import circularDependency from 'rollup-plugin-circular-dependency'

export default {
  plugins: [
    circularDependency({
      failOnCircular: true,
      skipExternal: true
    })
  ]
}
```

## Integration with Development Tools

### VS Code Integration
```json
{
  "scripts": {
    "build": "rollup -c",
    "dev": "rollup -c -w"
  },
  "devDependencies": {
    "@types/node": "^18.0.0"
  }
}

// .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Rollup Build",
      "type": "npm",
      "script": "build",
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      }
    }
  ]
}
```

### Jest Testing Integration
```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  setupFilesAfterEnv: ['<rootDir>/src/test/setup.ts']
}

// Test TypeScript build output
import { MyLibrary } from '../dist/index.esm.js'

describe('Built library', () => {
  test('should work correctly', () => {
    const lib = new MyLibrary({ apiKey: 'test' })
    expect(lib).toBeDefined()
  })
})
```

## Useful Resources
- **Official Documentation**: https://rollupjs.org/
- **Plugin Directory**: https://github.com/rollup/plugins
- **Awesome Rollup**: https://github.com/rollup/awesome
- **Configuration Examples**: https://github.com/rollup/rollup/tree/master/docs
- **Performance Guide**: https://rollupjs.org/guide/en/#big-list-of-options

## Tool-Specific Guidelines

### Best Practices
- Use Rollup for libraries, Webpack for applications
- Prefer ES modules for better tree shaking
- External dependencies that users should provide
- Generate multiple output formats (CJS, ESM, UMD)
- Include TypeScript declarations for TypeScript projects

### Performance Tips
- Use esbuild plugin for faster TypeScript compilation
- External large dependencies to reduce bundle size
- Enable tree shaking with proper ES module exports
- Use code splitting for large applications
- Cache build results with rollup-plugin-cache

### Security Considerations
- Validate all inputs in custom plugins
- Use trusted plugins from the official repository
- Keep dependencies updated for security patches
- Review generated bundles for sensitive information
- Use source maps appropriately (external for production)

## Version Compatibility
- **Node.js**: 18+ (16+ minimum for Rollup 4.x)
- **TypeScript**: 4.5+ (with @rollup/plugin-typescript)
- **React**: Any version (with proper externals)
- **Babel**: 7+ (with @rollup/plugin-babel)

## Troubleshooting

### Debug Mode
```bash
# Verbose logging
rollup -c --verbose

# Silent mode
rollup -c --silent

# Generate stats
rollup -c --stats

# Check plugin execution
DEBUG=rollup:* rollup -c
```

### Common Error Messages
- **Error**: `Could not resolve 'module'`
  **Cause**: Missing dependency or incorrect import
  **Solution**: Install dependency or configure resolve plugin

- **Error**: `Unexpected token 'export'`
  **Cause**: CommonJS module with ES syntax
  **Solution**: Add to commonjs plugin include pattern

- **Error**: `'default' is not exported by module`
  **Cause**: Named/default export mismatch
  **Solution**: Configure commonjs plugin with namedExports
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
