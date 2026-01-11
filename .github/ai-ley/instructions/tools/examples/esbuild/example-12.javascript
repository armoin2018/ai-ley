const buildConfig = {
  entryPoints: ['src/index.js'],
  bundle: true,
  outdir: 'dist',
  loader: {
    // Image files
    '.png': 'file',     // Copy to output and return URL
    '.jpg': 'file',
    '.jpeg': 'file',
    '.gif': 'file',
    '.webp': 'file',

    // SVG handling
    '.svg': 'file',     // As file URL
    // '.svg': 'text',  // As text content
    // '.svg': 'dataurl', // As data URL

    // Font files
    '.woff': 'file',
    '.woff2': 'file',
    '.ttf': 'file',
    '.otf': 'file',
    '.eot': 'file',

    // CSS and styles
    '.css': 'css',
    '.module.css': 'local-css',

    // Data files
    '.json': 'json',
    '.txt': 'text',
    '.xml': 'text',

    // Web Assembly
    '.wasm': 'file',

    // TypeScript
    '.ts': 'ts',
    '.tsx': 'tsx',

    // JavaScript variations
    '.js': 'js',
    '.jsx': 'jsx',
    '.mjs': 'js'
  },
  assetNames: 'assets/[name]-[hash]'
}