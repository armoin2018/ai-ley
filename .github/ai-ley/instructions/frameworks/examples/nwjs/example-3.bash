# Setup with webpack
npm install --save-dev webpack webpack-cli html-webpack-plugin

# Setup with Vite (for development)
npm install --save-dev vite

# Create vite.config.js for NW.js
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'

export default defineConfig({
  base: './',
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    rollupOptions: {
      output: {
        format: 'iife'
      }
    }
  },
  server: {
    port: 3000
  }
})
EOF

# Update package.json scripts
npm pkg set scripts.dev:web="vite"
npm pkg set scripts.build:web="vite build"
npm pkg set scripts.dev="concurrently "npm run dev:web" "npm start""