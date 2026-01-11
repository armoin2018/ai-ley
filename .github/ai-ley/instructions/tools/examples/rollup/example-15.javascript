import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import typescript from '@rollup/plugin-typescript'
import babel from '@rollup/plugin-babel'
import json from '@rollup/plugin-json'
import replace from '@rollup/plugin-replace'
import { terser } from 'rollup-plugin-terser'
import postcss from 'rollup-plugin-postcss'
import serve from 'rollup-plugin-serve'
import livereload from 'rollup-plugin-livereload'

export default {
  input: 'src/index.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'umd',
    name: 'MyLibrary'
  },
  plugins: [
    // Resolve node modules
    resolve({
      browser: true,
      preferBuiltins: false,
      extensions: ['.js', '.jsx', '.ts', '.tsx']
    }),

    // CommonJS conversion
    commonjs({
      include: 'node_modules/**'
    }),

    // TypeScript compilation
    typescript({
      tsconfig: './tsconfig.json',
      sourceMap: true,
      inlineSources: true
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
      extensions: ['.js', '.jsx', '.ts', '.tsx']
    }),

    // CSS processing
    postcss({
      extract: true,
      minimize: true,
      sourceMap: true
    }),

    // Development server
    process.env.NODE_ENV === 'development' && serve({
      contentBase: 'dist',
      port: 3000,
      open: true
    }),

    // Live reload
    process.env.NODE_ENV === 'development' && livereload('dist'),

    // Minification
    process.env.NODE_ENV === 'production' && terser()
  ].filter(Boolean)
}