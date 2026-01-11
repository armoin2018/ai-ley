// rollup.config.js - React component library
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import typescript from '@rollup/plugin-typescript'
import peerDepsExternal from 'rollup-plugin-peer-deps-external'
import postcss from 'rollup-plugin-postcss'
import { terser } from 'rollup-plugin-terser'

export default {
  input: 'src/index.ts',

  output: [
    {
      file: 'dist/index.cjs.js',
      format: 'cjs',
      sourcemap: true,
      exports: 'named'
    },
    {
      file: 'dist/index.esm.js',
      format: 'esm',
      sourcemap: true
    }
  ],

  plugins: [
    // Automatically externalize peer dependencies
    peerDepsExternal(),

    // Resolve node modules
    resolve(),

    // CommonJS support
    commonjs(),

    // TypeScript compilation
    typescript({
      tsconfig: './tsconfig.json',
      declaration: true,
      declarationDir: 'dist/types'
    }),

    // CSS processing
    postcss({
      extract: 'styles.css',
      minimize: true,
      modules: true
    }),

    // Minification
    terser()
  ],

  external: ['react', 'react-dom']
}