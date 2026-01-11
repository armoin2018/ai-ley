// rollup.config.js
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import typescript from '@rollup/plugin-typescript'
import { terser } from 'rollup-plugin-terser'
import babel from '@rollup/plugin-babel'
import json from '@rollup/plugin-json'
import replace from '@rollup/plugin-replace'

const isProduction = process.env.NODE_ENV === 'production'

export default {
  input: 'src/index.ts',

  output: [
    // CommonJS build
    {
      file: 'dist/index.cjs.js',
      format: 'cjs',
      exports: 'named',
      sourcemap: true
    },

    // ES modules build
    {
      file: 'dist/index.esm.js',
      format: 'es',
      sourcemap: true
    },

    // UMD build for browsers
    {
      file: 'dist/index.umd.js',
      format: 'umd',
      name: 'MyLibrary',
      globals: {
        'react': 'React',
        'react-dom': 'ReactDOM'
      },
      sourcemap: true
    }
  ],

  // External dependencies (not bundled)
  external: [
    'react',
    'react-dom',
    'lodash'
  ],

  plugins: [
    // Resolve node modules
    resolve({
      browser: true,
      preferBuiltins: false
    }),

    // Convert CommonJS to ES modules
    commonjs(),

    // TypeScript support
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist'
    }),

    // JSON imports
    json(),

    // Environment variables
    replace({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
      preventAssignment: true
    }),

    // Babel transpilation
    babel({
      babelHelpers: 'bundled',
      exclude: 'node_modules/**',
      presets: [
        ['@babel/preset-env', { targets: { node: '16' } }]
      ]
    }),

    // Minification for production
    isProduction && terser({
      compress: {
        drop_console: true,
        drop_debugger: true
      }
    })
  ].filter(Boolean),

  // Input options
  preserveEntrySignatures: 'strict',

  // Watch options
  watch: {
    include: 'src/**',
    exclude: 'node_modules/**'
  }
}