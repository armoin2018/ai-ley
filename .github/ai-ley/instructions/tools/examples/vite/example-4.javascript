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