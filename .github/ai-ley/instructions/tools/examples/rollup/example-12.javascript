import { createFilter } from '@rollup/pluginutils'
import path from 'path'

// Asset plugin for handling images, fonts, etc.
function assetPlugin(options = {}) {
  const filter = createFilter(options.include, options.exclude)

  return {
    name: 'asset-plugin',
    load(id) {
      if (filter(id) && /\.(png|jpg|gif|svg|woff|woff2)$/.test(id)) {
        const referenceId = this.emitFile({
          type: 'asset',
          name: path.basename(id),
          source: require('fs').readFileSync(id)
        })

        return `export default import.meta.ROLLUP_FILE_URL_${referenceId}`
      }
    }
  }
}

// Configuration with asset handling
export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es',
    assetFileNames: 'assets/[name]-[hash][extname]'
  },
  plugins: [
    assetPlugin({
      include: ['**/*.png', '**/*.jpg', '**/*.svg']
    })
  ]
}