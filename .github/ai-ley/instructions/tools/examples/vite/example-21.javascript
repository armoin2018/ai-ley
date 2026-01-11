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