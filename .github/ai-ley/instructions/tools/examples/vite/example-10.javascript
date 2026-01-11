// Static asset imports
import imageUrl from './image.png'
import jsonData from './data.json'
import csvContent from './data.csv?raw'
import svgComponent from './icon.svg?component'
import workerUrl from './worker.js?worker&url'

// Dynamic imports
const getAsset = async (name) => {
  const module = await import(`./assets/${name}.png`)
  return module.default
}

// Asset processing with query parameters
import textContent from './file.txt?raw'          // Raw text
import base64 from './image.png?base64'           // Base64 string
import dataUrl from './image.png?url'             // Data URL
import inlineSvg from './icon.svg?inline'         // Inline SVG

// CSS asset handling
import styles from './Component.module.css'       // CSS Modules
import './global.css'                             // Global CSS
import scssVars from './variables.scss?export'   // Export SCSS variables

// Advanced asset handling in vite.config.js
export default defineConfig({
  assetsInclude: ['**/*.lottie'], // Include custom asset types

  build: {
    assetsInlineLimit: 4096, // Inline assets smaller than 4kb
    rollupOptions: {
      output: {
        assetFileNames: (assetInfo) => {
          const info = assetInfo.name.split('.')
          const extType = info[info.length - 1]

          if (/png|jpe?g|svg|gif|tiff|bmp|ico/i.test(extType)) {
            return `images/[name]-[hash][extname]`
          }
          if (/css/i.test(extType)) {
            return `css/[name]-[hash][extname]`
          }
          return `assets/[name]-[hash][extname]`
        },
      },
    },
  },
})