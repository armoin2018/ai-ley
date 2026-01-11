// esbuild.config.js
const esbuild = require('esbuild')

const config = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  platform: 'browser', // or 'node'
  target: ['es2020', 'chrome90', 'firefox88'],
  format: 'esm', // or 'cjs', 'iife'
  sourcemap: true,
  minify: false,
  splitting: false,
  treeShaking: true,
  loader: {
    '.png': 'file',
    '.jpg': 'file',
    '.svg': 'text',
    '.css': 'css'
  },
  define: {
    'process.env.NODE_ENV': '"development"',
    '__VERSION__': '"1.0.0"'
  },
  external: ['react', 'react-dom'],
  banner: {
    js: '/* esbuild bundle */',
    css: '/* esbuild styles */'
  },
  footer: {
    js: '/* end of bundle */'
  }
}

if (process.argv.includes('--watch')) {
  esbuild.context(config).then(ctx => {
    ctx.watch()
    console.log('Watching for changes...')
  })
} else {
  esbuild.build(config).catch(() => process.exit(1))
}