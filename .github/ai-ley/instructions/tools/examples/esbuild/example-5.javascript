// build.js - Advanced esbuild configuration
const esbuild = require('esbuild')
const path = require('path')

const isProduction = process.env.NODE_ENV === 'production'
const isDevelopment = !isProduction

const buildConfig = {
  entryPoints: [
    'src/index.ts',
    'src/worker.ts'
  ],
  bundle: true,
  outdir: 'dist',
  platform: 'browser',
  target: ['es2020'],
  format: 'esm',
  splitting: true,
  chunkNames: 'chunks/[name]-[hash]',
  assetNames: 'assets/[name]-[hash]',
  publicPath: '/static/',
  sourcemap: isDevelopment ? 'inline' : 'external',
  minify: isProduction,
  treeShaking: true,
  metafile: true,

  // Loaders for different file types
  loader: {
    '.png': 'file',
    '.jpg': 'file',
    '.jpeg': 'file',
    '.gif': 'file',
    '.svg': 'file',
    '.woff': 'file',
    '.woff2': 'file',
    '.ttf': 'file',
    '.eot': 'file',
    '.css': 'css',
    '.module.css': 'local-css'
  },

  // Define global variables
  define: {
    'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
    '__DEV__': JSON.stringify(isDevelopment),
    '__VERSION__': JSON.stringify(require('./package.json').version),
    'global': 'globalThis'
  },

  // External dependencies (not bundled)
  external: [
    'react',
    'react-dom'
  ],

  // Inject polyfills or setup code
  inject: ['./src/polyfills.js'],

  // Banner and footer
  banner: {
    js: `/* Built with esbuild at ${new Date().toISOString()} */`,
    css: `/* Styles built with esbuild */`
  },

  // Resolve configuration
  resolveExtensions: ['.tsx', '.ts', '.jsx', '.js', '.json'],
  mainFields: ['browser', 'module', 'main'],
  conditions: ['browser', 'import', 'module', 'default'],

  // Drop console and debugger in production
  drop: isProduction ? ['console', 'debugger'] : [],

  // Keep names for better debugging
  keepNames: isDevelopment,

  // Legal comments handling
  legalComments: isProduction ? 'none' : 'inline'
}

async function build() {
  try {
    const result = await esbuild.build(buildConfig)

    if (result.metafile) {
      // Analyze bundle
      const analysis = await esbuild.analyzeMetafile(result.metafile, {
        verbose: true
      })
      console.log(analysis)

      // Write metafile for analysis tools
      require('fs').writeFileSync('meta.json', JSON.stringify(result.metafile))
    }

    console.log('Build completed successfully!')
  } catch (error) {
    console.error('Build failed:', error)
    process.exit(1)
  }
}

// Watch mode
async function watch() {
  const ctx = await esbuild.context(buildConfig)
  await ctx.watch()
  console.log('Watching for changes...')
}

if (process.argv.includes('--watch')) {
  watch()
} else {
  build()
}