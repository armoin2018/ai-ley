// rollup.config.js - Environment-based configuration
const isProduction = process.env.NODE_ENV === 'production'
const isDevelopment = !isProduction

const baseConfig = {
  input: 'src/index.js',
  external: ['react', 'react-dom'],
  plugins: [
    resolve(),
    commonjs(),
    typescript()
  ]
}

const developmentConfig = {
  ...baseConfig,
  output: {
    file: 'dist/bundle.dev.js',
    format: 'es',
    sourcemap: true
  },
  watch: {
    include: 'src/**'
  }
}

const productionConfig = {
  ...baseConfig,
  output: [
    {
      file: 'dist/bundle.cjs.js',
      format: 'cjs',
      exports: 'named'
    },
    {
      file: 'dist/bundle.esm.js',
      format: 'es'
    },
    {
      file: 'dist/bundle.umd.js',
      format: 'umd',
      name: 'MyLibrary'
    }
  ],
  plugins: [
    ...baseConfig.plugins,
    terser({
      compress: {
        drop_console: true
      }
    })
  ]
}

export default isDevelopment ? developmentConfig : productionConfig