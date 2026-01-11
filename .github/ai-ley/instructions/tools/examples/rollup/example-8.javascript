// Source: utils.js
export function usedFunction() {
  return 'This will be included'
}

export function unusedFunction() {
  return 'This will be removed'
}

// Source: index.js
import { usedFunction } from './utils.js'
console.log(usedFunction())

// Rollup automatically removes unusedFunction from the bundle

// Configuration for tree shaking
export default {
  input: 'src/index.js',
  output: {
    file: 'dist/bundle.js',
    format: 'es'
  },
  treeshake: {
    moduleSideEffects: false,  // Assume modules have no side effects
    propertyReadSideEffects: false,
    tryCatchDeoptimization: false
  }
}