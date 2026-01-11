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