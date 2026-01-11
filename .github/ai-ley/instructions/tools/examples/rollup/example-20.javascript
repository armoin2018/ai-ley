// rollup.config.js - Size optimization
export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },

  // External dependencies
  external: [
    'react',
    'react-dom',
    'lodash',
    /^@babel\/runtime/
  ],

  // Tree shaking configuration
  treeshake: {
    moduleSideEffects: false,
    propertyReadSideEffects: false,
    tryCatchDeoptimization: false
  },

  plugins: [
    resolve({
      // Only bundle what's needed
      preferBuiltins: true
    }),

    // Analyze bundle size
    bundleAnalyzer({
      openAnalyzer: false,
      analyzerMode: 'json',
      reportFilename: 'bundle-report.json'
    }),

    // Minification
    terser({
      compress: {
        drop_console: true,
        drop_debugger: true,
        pure_funcs: ['console.log']
      },
      mangle: {
        properties: {
          regex: /^_/  // Mangle private properties
        }
      }
    })
  ]
}