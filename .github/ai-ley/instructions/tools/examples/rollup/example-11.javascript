// Custom plugin example
function customPlugin(options = {}) {
  return {
    name: 'custom-plugin',

    // Build hooks
    buildStart(opts) {
      console.log('Build starting...')
    },

    // Resolve imports
    resolveId(id, importer) {
      if (id === 'virtual:custom') {
        return id
      }
      return null
    },

    // Load modules
    load(id) {
      if (id === 'virtual:custom') {
        return 'export default "Custom virtual module"'
      }
      return null
    },

    // Transform code
    transform(code, id) {
      if (id.endsWith('.special')) {
        return {
          code: `export default ${JSON.stringify(code)}`,
          map: null
        }
      }
      return null
    },

    // Generate bundle
    generateBundle(opts, bundle) {
      // Modify bundle before write
      Object.keys(bundle).forEach(fileName => {
        const file = bundle[fileName]
        if (file.type === 'chunk') {
          file.code = `/* Custom header */\n${file.code}`
        }
      })
    },

    // Write bundle
    writeBundle(opts, bundle) {
      console.log('Bundle written successfully')
    }
  }
}

// Use custom plugin
export default {
  input: 'src/index.js',
  output: { file: 'dist/bundle.js', format: 'es' },
  plugins: [customPlugin({ option: 'value' })]
}