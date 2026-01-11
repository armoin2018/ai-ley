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