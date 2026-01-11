// Dynamic imports for code splitting
export default {
  input: ['src/main.js', 'src/module.js'],
  output: {
    dir: 'dist',
    format: 'es',
    chunkFileNames: 'chunks/[name]-[hash].js'
  },
  plugins: [resolve(), commonjs()]
}

// Manual chunks
export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es'
  },
  manualChunks: {
    vendor: ['react', 'react-dom'],
    utils: ['lodash', 'moment']
  }
}

// Dynamic chunk generation
export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es'
  },
  manualChunks(id) {
    if (id.includes('node_modules')) {
      return 'vendor'
    }
    if (id.includes('src/utils')) {
      return 'utils'
    }
  }
}