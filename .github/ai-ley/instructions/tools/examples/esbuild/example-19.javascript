// Node.js library configuration
const nodeLibConfig = {
  entryPoints: ['src/index.ts'],
  bundle: true,
  platform: 'node',
  target: ['node16'],
  format: 'cjs',
  outfile: 'dist/index.js',
  external: [
    'fs',
    'path',
    'url',
    'util'
  ],
  banner: {
    js: '#!/usr/bin/env node'
  }
}

// Dual package (CJS + ESM)
const dualPackageConfig = [
  {
    ...nodeLibConfig,
    format: 'cjs',
    outfile: 'dist/index.cjs'
  },
  {
    ...nodeLibConfig,
    format: 'esm',
    outfile: 'dist/index.mjs'
  }
]