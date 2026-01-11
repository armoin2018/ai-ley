// Fast development builds
const isDev = process.env.NODE_ENV === 'development'

export default {
  input: 'src/index.js',
  output: {
    dir: 'dist',
    format: 'es'
  },

  plugins: [
    resolve(),
    commonjs(),

    // Fast TypeScript compilation
    isDev ? esbuild({
      target: 'es2020'
    }) : typescript(),

    // Skip minification in development
    !isDev && terser()
  ].filter(Boolean),

  // Faster builds in development
  watch: isDev ? {
    include: 'src/**',
    exclude: 'node_modules/**',
    chokidar: {
      usePolling: false
    }
  } : false
}