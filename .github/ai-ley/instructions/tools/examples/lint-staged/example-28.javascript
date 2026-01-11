// Optimized configuration for large projects
module.exports = {
  // Use concurrency for independent operations
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix --cache --cache-location .eslintcache',
    'prettier --write --cache',
  ],

  // Separate CPU-intensive operations
  '*.{css,scss}': 'stylelint --fix --cache',

  // Group similar operations
  '*.{json,md,yaml}': 'prettier --write',

  // Use shell commands for complex operations
  'package*.json': 'sort-package-json && npm audit fix --force || true',

  // Conditional expensive operations
  '*.{png,jpg,jpeg}': (filenames) => {
    if (process.env.OPTIMIZE_IMAGES === 'true') {
      return `imagemin ${filenames.join(' ')} --out-dir=optimized/`;
    }
    return [];
  },
};