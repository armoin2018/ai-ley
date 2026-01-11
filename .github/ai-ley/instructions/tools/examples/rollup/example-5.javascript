// rollup.config.js - Multiple entries
export default [
  // Main library build
  {
    input: 'src/index.ts',
    output: [
      { file: 'dist/index.cjs.js', format: 'cjs' },
      { file: 'dist/index.esm.js', format: 'es' }
    ],
    external: ['react', 'react-dom'],
    plugins: [resolve(), commonjs(), typescript()]
  },

  // CLI tool build
  {
    input: 'src/cli.ts',
    output: {
      file: 'dist/cli.js',
      format: 'cjs',
      banner: '#!/usr/bin/env node'
    },
    external: ['fs', 'path', 'process'],
    plugins: [resolve(), commonjs(), typescript()]
  },

  // Browser-specific build
  {
    input: 'src/browser.ts',
    output: {
      file: 'dist/browser.js',
      format: 'iife',
      name: 'MyLibraryBrowser'
    },
    plugins: [
      resolve({ browser: true }),
      commonjs(),
      typescript(),
      terser()
    ]
  }
]