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