const config = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  loader: {
    '.css': 'css',
    '.png': 'file',
    '.svg': 'file'
  },
  assetNames: 'assets/[name]-[hash]',
  publicPath: '/static/', // For assets served from different path
  external: [], // Make sure CSS files aren't external
}