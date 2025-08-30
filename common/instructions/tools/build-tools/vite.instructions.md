# Vite Build Tool Instructions

## Tool Overview
- **Tool Name**: Vite (French word for "quick", pronounced /vit/)
- **Version**: 4.4+ (stable), 5.0+ (latest with enhanced features)
- **Category**: Build Tools
- **Purpose**: Next generation frontend build tool with instant hot module replacement
- **Prerequisites**: Node.js 16+ (18+ recommended), npm/yarn/pnpm

## Installation & Setup
### Package Manager Installation
```bash
# npm installation
npm create vite@latest my-app
npm create vite@latest my-app -- --template react
npm create vite@latest my-app -- --template vue
npm create vite@latest my-app -- --template svelte

# yarn installation
yarn create vite my-app
yarn create vite my-app --template react-ts

# pnpm installation
pnpm create vite my-app
pnpm create vite my-app --template vanilla-ts

# Available templates
# vanilla, vanilla-ts, vue, vue-ts, react, react-ts, react-swc, react-swc-ts
# preact, preact-ts, lit, lit-ts, svelte, svelte-ts, solid, solid-ts, qwik, qwik-ts

# Add to existing project
npm install --save-dev vite
yarn add --dev vite
pnpm add -D vite
```

### Project Integration
```bash
# Initialize new Vite project
npm create vite@latest my-project
cd my-project
npm install
npm run dev

# Add Vite to existing project
npm install --save-dev vite
# Create vite.config.js
touch vite.config.js

# Basic package.json scripts
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  }
}
```

## Configuration

### vite.config.js (Basic)
```javascript
import { defineConfig } from 'vite'

export default defineConfig({
  // Base public path
  base: '/',

  // Development server
  server: {
    port: 3000,
    open: true,
    host: true, // Listen on all addresses
  },

  // Build configuration
  build: {
    outDir: 'dist',
    sourcemap: true,
    minify: 'terser', // or 'esbuild'
  },

  // Preview server (for production build preview)
  preview: {
    port: 4173,
    open: true,
  },
})
```

### Advanced Configuration
```javascript
import { defineConfig, loadEnv } from 'vite'
import { resolve } from 'path'

export default defineConfig(({ command, mode }) => {
  // Load env file based on `mode` in the current working directory
  const env = loadEnv(mode, process.cwd(), '')

  return {
    // Environment variables
    define: {
      __APP_ENV__: JSON.stringify(env.APP_ENV),
    },

    // Path resolution
    resolve: {
      alias: {
        '@': resolve(__dirname, 'src'),
        '@components': resolve(__dirname, 'src/components'),
        '@utils': resolve(__dirname, 'src/utils'),
        '@assets': resolve(__dirname, 'src/assets'),
      },
    },

    // CSS configuration
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `@import "@/styles/variables.scss";`,
        },
        less: {
          math: 'parens-division',
        },
      },
      modules: {
        generateScopedName: '[name]__[local]___[hash:base64:5]',
      },
    },

    // Development server
    server: {
      port: parseInt(env.VITE_PORT) || 3000,
      host: true,
      open: true,
      cors: true,

      // Proxy API requests
      proxy: {
        '/api': {
          target: 'http://localhost:8080',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, ''),
        },
        '/socket.io': {
          target: 'ws://localhost:8080',
          ws: true,
        },
      },

      // HTTPS configuration
      https: {
        key: './certs/key.pem',
        cert: './certs/cert.pem',
      },
    },

    // Build configuration
    build: {
      outDir: 'dist',
      assetsDir: 'assets',
      sourcemap: command === 'serve',
      minify: 'terser',

      // Rollup options
      rollupOptions: {
        input: {
          main: resolve(__dirname, 'index.html'),
          admin: resolve(__dirname, 'admin.html'),
        },
        output: {
          manualChunks: {
            vendor: ['react', 'react-dom'],
            utils: ['lodash', 'axios'],
          },
        },
      },

      // Build targets
      target: 'esnext',

      // Terser options
      terserOptions: {
        compress: {
          drop_console: true,
          drop_debugger: true,
        },
      },

      // Chunk size warning limit
      chunkSizeWarningLimit: 1000,
    },

    // Optimization
    optimizeDeps: {
      include: ['react', 'react-dom'],
      exclude: ['@vite/client', '@vite/env'],
    },

    // Preview server
    preview: {
      port: 4173,
      host: true,
      cors: true,
    },
  }
})
```

### React Configuration
```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'

export default defineConfig({
  plugins: [
    react({
      // Enable React Fast Refresh
      fastRefresh: true,

      // Babel configuration
      babel: {
        plugins: [
          ['@babel/plugin-proposal-decorators', { legacy: true }],
        ],
      },
    }),
  ],

  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },

  server: {
    port: 3000,
    open: true,
  },

  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          react: ['react', 'react-dom'],
          vendor: ['axios', 'lodash'],
        },
      },
    },
  },
})
```

### Vue Configuration
```javascript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [
    vue({
      // Vue-specific options
      reactivityTransform: true,
    }),
  ],

  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
      'vue': 'vue/dist/vue.esm-bundler.js',
    },
  },

  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@import "@/styles/variables.scss";`,
      },
    },
  },
})
```

### Environment Variables
```bash
# .env
VITE_API_URL=http://localhost:8080
VITE_APP_TITLE=My Vite App
VITE_BUILD_VERSION=1.0.0

# .env.local (not committed to git)
VITE_SECRET_KEY=my-secret-key

# .env.development
VITE_API_URL=http://localhost:8080
VITE_DEBUG=true

# .env.production
VITE_API_URL=https://api.production.com
VITE_DEBUG=false

# Usage in code
console.log(import.meta.env.VITE_API_URL)
console.log(import.meta.env.MODE) // 'development' or 'production'
console.log(import.meta.env.DEV)  // boolean
console.log(import.meta.env.PROD) // boolean
```

## Core Features

### Lightning Fast Hot Module Replacement (HMR)
- **Purpose**: Instant updates during development without losing application state
- **Usage**: Automatic with supported frameworks
- **Example**:
```javascript
// Vite provides HMR API for custom integrations
if (import.meta.hot) {
  import.meta.hot.accept('./dependency.js', (newModule) => {
    // Handle hot update
  })

  import.meta.hot.dispose((data) => {
    // Cleanup before hot update
  })

  import.meta.hot.invalidate() // Force full reload
}

// Framework-specific HMR (React)
if (import.meta.hot) {
  import.meta.hot.accept('../App', () => {
    // React Fast Refresh handles this automatically
  })
}
```

### Plugin System
- **Purpose**: Extend Vite functionality with plugins
- **Usage**: Add plugins for frameworks, utilities, and build optimizations
- **Example**:
```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'
import legacy from '@vitejs/plugin-legacy'
import { defineConfig } from 'vite'

export default defineConfig({
  plugins: [
    // React support
    react(),

    // Legacy browser support
    legacy({
      targets: ['defaults', 'not IE 11'],
    }),

    // PWA support
    VitePWA({
      registerType: 'autoUpdate',
      workbox: {
        globPatterns: ['**/*.{js,css,html,ico,png,svg}'],
      },
    }),

    // Bundle analyzer
    process.env.ANALYZE && bundleAnalyzer(),

    // Mock API during development
    process.env.NODE_ENV === 'development' && mockDevPlugin(),
  ].filter(Boolean),
})

// Custom plugin example
function mockDevPlugin() {
  return {
    name: 'mock-dev',
    configureServer(server) {
      server.middlewares.use('/api/mock', (req, res, next) => {
        res.setHeader('Content-Type', 'application/json')
        res.end(JSON.stringify({ message: 'Mock API response' }))
      })
    },
  }
}
```

### Asset Processing
- **Purpose**: Handle various asset types with optimal processing
- **Usage**: Import assets directly in JavaScript/TypeScript
- **Example**:
```javascript
// Static asset imports
import imageUrl from './image.png'
import jsonData from './data.json'
import csvContent from './data.csv?raw'
import svgComponent from './icon.svg?component'
import workerUrl from './worker.js?worker&url'

// Dynamic imports
const getAsset = async (name) => {
  const module = await import(`./assets/${name}.png`)
  return module.default
}

// Asset processing with query parameters
import textContent from './file.txt?raw'          // Raw text
import base64 from './image.png?base64'           // Base64 string
import dataUrl from './image.png?url'             // Data URL
import inlineSvg from './icon.svg?inline'         // Inline SVG

// CSS asset handling
import styles from './Component.module.css'       // CSS Modules
import './global.css'                             // Global CSS
import scssVars from './variables.scss?export'   // Export SCSS variables

// Advanced asset handling in vite.config.js
export default defineConfig({
  assetsInclude: ['**/*.lottie'], // Include custom asset types

  build: {
    assetsInlineLimit: 4096, // Inline assets smaller than 4kb
    rollupOptions: {
      output: {
        assetFileNames: (assetInfo) => {
          const info = assetInfo.name.split('.')
          const extType = info[info.length - 1]

          if (/png|jpe?g|svg|gif|tiff|bmp|ico/i.test(extType)) {
            return `images/[name]-[hash][extname]`
          }
          if (/css/i.test(extType)) {
            return `css/[name]-[hash][extname]`
          }
          return `assets/[name]-[hash][extname]`
        },
      },
    },
  },
})
```

## Common Commands
```bash
# Development commands
npm run dev                        # Start development server
npm run dev -- --port 3001        # Custom port
npm run dev -- --host 0.0.0.0     # Expose to network
npm run dev -- --open /admin      # Open specific path

# Build commands
npm run build                      # Production build
npm run build -- --mode staging   # Custom mode
npm run build -- --base /app/     # Custom base path

# Preview production build
npm run preview                    # Preview built app
npm run preview -- --port 4174    # Custom preview port

# Vite CLI commands
npx vite                          # Start dev server
npx vite build                    # Build for production
npx vite preview                  # Preview production build
npx vite optimize                 # Pre-bundle dependencies

# Advanced commands
npx vite build --watch            # Watch mode for build
npx vite build --minify false     # Build without minification
npx vite --force                  # Force re-optimize dependencies

# Plugin and dependency management
npx vite optimize --force         # Force re-optimize deps
npx vite build --reporter verbose # Detailed build output

# Configuration validation
npx vite --config vite.config.ts  # Use TypeScript config
npx vite build --mode production  # Specify build mode
```

## Advanced Features

### Custom Plugin Development
```javascript
// my-plugin.js
export function myPlugin(options = {}) {
  return {
    name: 'my-plugin',

    // Plugin initialization
    buildStart(opts) {
      console.log('Build starting...')
    },

    // Transform imports
    resolveId(id, importer) {
      if (id === 'virtual:my-module') {
        return id
      }
    },

    // Load custom modules
    load(id) {
      if (id === 'virtual:my-module') {
        return 'export const msg = "Hello from virtual module"'
      }
    },

    // Transform code
    transform(code, id) {
      if (id.endsWith('.special')) {
        return `export default ${JSON.stringify(code)}`
      }
    },

    // Development server middleware
    configureServer(server) {
      server.middlewares.use('/api', (req, res, next) => {
        if (req.url === '/api/health') {
          res.end('OK')
        } else {
          next()
        }
      })
    },

    // Build hooks
    generateBundle(options, bundle) {
      // Modify bundle before write
    },

    // HTML transformation
    transformIndexHtml(html, context) {
      return html.replace(
        /<title>(.*?)<\/title>/,
        `<title>Custom Title</title>`
      )
    },
  }
}

// Usage in vite.config.js
import { myPlugin } from './plugins/my-plugin.js'

export default defineConfig({
  plugins: [
    myPlugin({
      option: 'value',
    }),
  ],
})
```

### Library Mode
```javascript
// vite.config.js for library
import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
  build: {
    lib: {
      entry: resolve(__dirname, 'lib/main.js'),
      name: 'MyLib',
      fileName: (format) => `my-lib.${format}.js`,
      formats: ['es', 'cjs', 'umd', 'iife'],
    },
    rollupOptions: {
      // Externalize deps that shouldn't be bundled
      external: ['react', 'react-dom', 'lodash'],
      output: {
        globals: {
          react: 'React',
          'react-dom': 'ReactDOM',
          lodash: '_',
        },
      },
    },
  },
})

// package.json for library
{
  "name": "my-lib",
  "type": "module",
  "files": ["dist"],
  "main": "./dist/my-lib.cjs.js",
  "module": "./dist/my-lib.es.js",
  "exports": {
    ".": {
      "import": "./dist/my-lib.es.js",
      "require": "./dist/my-lib.cjs.js"
    }
  }
}
```

### Multi-Page Application
```javascript
import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        admin: resolve(__dirname, 'admin/index.html'),
        login: resolve(__dirname, 'login/index.html'),
      },
    },
  },

  // Conditional plugin loading
  plugins: [
    // Apply React plugin only to main and admin
    ...(process.env.PAGE !== 'login' ? [react()] : []),
  ],
})
```

### Server-Side Rendering (SSR)
```javascript
// vite.config.js
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    ssr: true,
  },
  ssr: {
    noExternal: ['react-helmet-async'],
    external: ['express'],
  },
})

// server.js
import express from 'express'
import { createServer as createViteServer } from 'vite'

async function createServer() {
  const app = express()

  // Create Vite server in middleware mode
  const vite = await createViteServer({
    server: { middlewareMode: true },
    appType: 'custom',
  })

  app.use(vite.ssrFixStacktrace)
  app.use(vite.middlewares)

  app.use('*', async (req, res) => {
    try {
      // Load the server entry
      const { render } = await vite.ssrLoadModule('/src/entry-server.js')

      // Render the app HTML
      const appHtml = await render(req.originalUrl)

      // Send the HTML
      res.status(200).set({ 'Content-Type': 'text/html' }).end(appHtml)
    } catch (e) {
      vite.ssrFixStacktrace(e)
      res.status(500).end(e.message)
    }
  })

  app.listen(3000)
}

createServer()
```

## Common Patterns

### React + TypeScript Setup
```bash
# Create React TypeScript project
npm create vite@latest my-react-app -- --template react-ts
cd my-react-app

# Install additional dependencies
npm install @types/node
npm install -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
```

```javascript
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
  },
})
```

```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

### Vue 3 + Composition API Setup
```javascript
// vite.config.js
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@import "@/styles/variables.scss";`,
      },
    },
  },
})
```

### Monorepo Setup with Vite
```javascript
// packages/shared/vite.config.js
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    lib: {
      entry: './src/index.ts',
      name: 'Shared',
      fileName: (format) => `index.${format}.js`,
    },
  },
})

// apps/web/vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@shared': resolve(__dirname, '../../packages/shared/src'),
    },
  },
})
```

## Performance Optimization

### Build Optimization
```javascript
export default defineConfig({
  build: {
    // Enable build analysis
    reportCompressedSize: true,

    // Chunk splitting strategy
    rollupOptions: {
      output: {
        manualChunks: {
          // Vendor chunks
          react: ['react', 'react-dom'],
          router: ['react-router-dom'],
          ui: ['@mui/material', '@emotion/react'],
          utils: ['lodash', 'date-fns', 'axios'],

          // Dynamic chunking function
          ...((id) => {
            if (id.includes('node_modules')) {
              if (id.includes('react')) return 'react-vendor'
              if (id.includes('@mui')) return 'mui-vendor'
              return 'vendor'
            }
          }),
        },
      },
    },

    // Compression settings
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
        pure_funcs: ['console.log'],
      },
    },

    // Asset optimization
    assetsInlineLimit: 4096,
  },

  // Dependency optimization
  optimizeDeps: {
    include: [
      'react',
      'react-dom',
      'react-router-dom',
    ],
    exclude: ['@vite/client'],
  },
})
```

### Development Performance
```javascript
export default defineConfig({
  server: {
    // Improve HMR performance
    hmr: {
      overlay: false, // Disable error overlay for performance
    },

    // File watching optimization
    watch: {
      ignored: ['**/node_modules/**', '**/dist/**'],
    },
  },

  // Faster dependency resolution
  resolve: {
    dedupe: ['react', 'react-dom'],
  },

  // Build cache optimization
  cacheDir: 'node_modules/.vite',
})
```

### Bundle Analysis
```bash
# Install bundle analyzer
npm install --save-dev rollup-plugin-visualizer

# Add to vite config
import { visualizer } from 'rollup-plugin-visualizer'

export default defineConfig({
  plugins: [
    // ... other plugins
    visualizer({
      filename: 'dist/stats.html',
      open: true,
      gzipSize: true,
    }),
  ],
})

# Build and analyze
npm run build
# Opens stats.html in browser
```

## Common Issues & Solutions

### Import Path Issues
**Problem**: Absolute imports not working
**Solution**: Configure path aliases properly
```javascript
// vite.config.js
import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
      '@components': resolve(__dirname, 'src/components'),
    },
  },
})

// tsconfig.json (for TypeScript)
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@components/*": ["./src/components/*"]
    }
  }
}
```

### Environment Variable Issues
**Problem**: Environment variables not accessible
**Solution**: Use VITE_ prefix and proper loading
```javascript
// .env
VITE_API_URL=http://localhost:8080  # ✓ Accessible
API_SECRET=secret                   # ✗ Not accessible (no VITE_ prefix)

// Usage
console.log(import.meta.env.VITE_API_URL) // ✓ Works
console.log(process.env.VITE_API_URL)     // ✗ Won't work in browser

// For server-side or Node.js scripts
import { loadEnv } from 'vite'

const env = loadEnv('development', process.cwd(), '')
console.log(env.API_SECRET) // ✓ Works in Node.js context
```

### CSS Import Issues
**Problem**: CSS imports not working correctly
**Solution**: Proper CSS configuration
```javascript
// vite.config.js
export default defineConfig({
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@import "@/styles/variables.scss";`,
        includePaths: ['node_modules'],
      },
    },
    modules: {
      generateScopedName: '[name]__[local]___[hash:base64:5]',
    },
  },
})

// Usage in components
import styles from './Component.module.css'  // CSS Modules
import './Component.scss'                    // Global styles
```

### Build Target Issues
**Problem**: Build not compatible with target browsers
**Solution**: Configure build targets and polyfills
```javascript
export default defineConfig({
  build: {
    target: ['es2020', 'edge88', 'firefox78', 'chrome87', 'safari13.1'],
  },

  plugins: [
    legacy({
      targets: ['defaults', 'not IE 11'],
      polyfills: ['es.promise.finally', 'es/map', 'es/set'],
      modernPolyfills: ['es.promise.finally'],
    }),
  ],
})
```

## Integration with Development Tools

### Package.json Scripts
```json
{
  "name": "my-vite-app",
  "scripts": {
    "dev": "vite",
    "dev:host": "vite --host",
    "dev:https": "vite --https",
    "build": "vite build",
    "build:staging": "vite build --mode staging",
    "build:analyze": "vite build && npx vite-bundle-analyzer dist",
    "preview": "vite preview",
    "preview:host": "vite preview --host",
    "clean": "rm -rf dist",
    "type-check": "vue-tsc --noEmit", // For Vue
    "lint": "eslint . --ext ts,tsx,js,jsx",
    "lint:fix": "eslint . --ext ts,tsx,js,jsx --fix"
  },
  "devDependencies": {
    "vite": "^5.0.0",
    "@vitejs/plugin-react": "^4.0.0",
    "typescript": "^5.0.0"
  }
}
```

### ESLint Configuration
```javascript
// .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es2020: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: ['react-refresh'],
  rules: {
    'react-refresh/only-export-components': 'warn',
  },
  globals: {
    // Vite globals
    import: 'readonly',
  },
}
```

### CI/CD Integration
```yaml
# GitHub Actions
name: Build and Deploy
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Type check
      run: npm run type-check

    - name: Lint
      run: npm run lint

    - name: Build
      run: npm run build
      env:
        VITE_API_URL: ${{ secrets.VITE_API_URL }}

    - name: Upload build artifacts
      uses: actions/upload-artifact@v3
      with:
        name: dist
        path: dist

    - name: Deploy to Netlify
      uses: nwtgck/actions-netlify@v2.0
      with:
        publish-dir: './dist'
        production-branch: main
      env:
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
```

### Docker Integration
```dockerfile
# Multi-stage Dockerfile
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built files
COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

## Useful Resources
- **Official Documentation**: https://vitejs.dev/
- **Plugin Directory**: https://github.com/vitejs/awesome-vite
- **Vite Ecosystem**: https://vitejs.dev/plugins/
- **Migration Guides**: https://vitejs.dev/guide/migration.html
- **Performance Guide**: https://vitejs.dev/guide/performance.html
- **Troubleshooting**: https://vitejs.dev/guide/troubleshooting.html

## Tool-Specific Guidelines

### Project Structure Best Practices
- Keep configuration simple and use conventions
- Use environment variables for different deployment targets
- Organize assets logically with clear naming conventions
- Leverage path aliases for cleaner imports
- Use TypeScript for better development experience

### Performance Guidelines
- Enable tree shaking with proper ES modules
- Use dynamic imports for code splitting
- Optimize asset loading with proper sizing
- Configure chunk splitting for better caching
- Monitor bundle size with analysis tools

### Plugin Development
- Follow Vite plugin conventions and naming
- Use proper hook timing for transformations
- Handle both development and build scenarios
- Provide clear error messages and debugging info
- Test plugins across different project types

## Version Compatibility
- **Vite**: 4.x (stable), 5.x (latest with enhanced features)
- **Node.js**: 16+ (minimum), 18+ (recommended), 20+ (optimal)
- **Package managers**: npm 8+, yarn 1.22+, pnpm 7+
- **Browser support**: Modern browsers with ES2020+ support

## Troubleshooting

### Debug Mode
```bash
# Enable debug logging
DEBUG=vite:* npm run dev

# Verbose build output
npm run build -- --reporter verbose

# Force dependency re-optimization
npm run dev -- --force

# Check dependency issues
npx vite optimize
```

### Common Error Messages
- **Error**: `Failed to resolve import`
  **Cause**: Incorrect import paths or missing dependencies
  **Solution**: Check import paths and install missing packages

- **Error**: `The following dependencies are imported but could not be resolved`
  **Cause**: Node.js modules used in browser code
  **Solution**: Configure proper polyfills or externals

- **Error**: `[vite] Internal server error: Failed to load url`
  **Cause**: Asset loading issues or incorrect base path
  **Solution**: Check asset paths and base configuration
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
