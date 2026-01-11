// Automatic code splitting
const splittingConfig = {
  entryPoints: [
    'src/home.js',
    'src/about.js',
    'src/contact.js'
  ],
  bundle: true,
  splitting: true,  // Enable code splitting
  format: 'esm',    // Required for splitting
  outdir: 'dist',
  chunkNames: 'chunks/[name]-[hash]'
}

// Manual chunk splitting with dynamic imports
// src/index.js
async function loadModule() {
  const { default: heavyModule } = await import('./heavy-module.js')
  return heavyModule
}

// This creates a separate chunk for heavy-module.js