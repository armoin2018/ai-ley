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