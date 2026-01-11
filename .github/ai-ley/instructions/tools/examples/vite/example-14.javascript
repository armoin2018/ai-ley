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