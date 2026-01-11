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