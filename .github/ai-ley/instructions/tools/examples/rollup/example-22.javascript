export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },
  external: [
    // Mark Node.js built-ins as external
    'fs', 'path', 'url', 'util',
    // Mark dependencies as external
    'react', 'react-dom'
  ],
  plugins: [
    resolve({
      preferBuiltins: true  // Prefer Node.js built-ins
    }),
    commonjs({
      // Convert CommonJS to ES modules
      transformMixedEsModules: true
    })
  ]
}