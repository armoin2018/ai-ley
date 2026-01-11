// React development setup
const reactDevConfig = {
  entryPoints: ['src/index.tsx'],
  bundle: true,
  outdir: 'dist',
  platform: 'browser',
  target: ['es2020'],
  format: 'esm',
  jsx: 'automatic',
  jsxDev: true,
  sourcemap: true,
  define: {
    'process.env.NODE_ENV': '"development"'
  },
  loader: {
    '.svg': 'file',
    '.css': 'css',
    '.module.css': 'local-css'
  },
  banner: {
    js: `
      // React Fast Refresh
      if (typeof window !== 'undefined' && window.__REACT_DEVTOOLS_GLOBAL_HOOK__) {
        window.__REACT_DEVTOOLS_GLOBAL_HOOK__.onCommitFiberRoot = (id, root) => {
          // Fast refresh logic
        }
      }
    `
  }
}

// React production build
const reactProdConfig = {
  ...reactDevConfig,
  minify: true,
  sourcemap: 'external',
  jsxDev: false,
  define: {
    'process.env.NODE_ENV': '"production"'
  },
  drop: ['console', 'debugger']
}