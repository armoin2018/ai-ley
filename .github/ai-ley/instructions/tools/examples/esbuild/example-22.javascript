// production.config.js
module.exports = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  minify: true,
  sourcemap: 'external',
  treeShaking: true,
  define: {
    'process.env.NODE_ENV': '"production"',
    '__DEV__': 'false'
  },
  drop: ['console', 'debugger'],
  legalComments: 'none'
}