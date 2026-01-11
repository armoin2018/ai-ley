// development.config.js
module.exports = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  sourcemap: 'inline',
  watch: true,
  define: {
    'process.env.NODE_ENV': '"development"',
    '__DEV__': 'true'
  },
  banner: {
    js: '// Development build - not optimized'
  }
}