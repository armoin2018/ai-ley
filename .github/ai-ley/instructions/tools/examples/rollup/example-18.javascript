// rollup.config.js for TypeScript library
import typescript from '@rollup/plugin-typescript'
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import { terser } from 'rollup-plugin-terser'

export default {
  input: 'src/index.ts',

  output: [
    // CommonJS for Node.js
    {
      file: 'dist/index.cjs.js',
      format: 'cjs',
      exports: 'named',
      sourcemap: true
    },

    // ES modules for bundlers
    {
      file: 'dist/index.esm.js',
      format: 'es',
      sourcemap: true
    },

    // UMD for browsers
    {
      file: 'dist/index.umd.js',
      format: 'umd',
      name: 'MyLibrary',
      sourcemap: true
    },

    // Minified UMD
    {
      file: 'dist/index.umd.min.js',
      format: 'umd',
      name: 'MyLibrary',
      plugins: [terser()]
    }
  ],

  external: ['react', 'react-dom'],

  plugins: [
    resolve(),
    commonjs(),
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist'
    })
  ]
}