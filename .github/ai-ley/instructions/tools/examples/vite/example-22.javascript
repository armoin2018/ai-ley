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