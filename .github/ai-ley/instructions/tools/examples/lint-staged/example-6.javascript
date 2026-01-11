module.exports = {
  // JavaScript/TypeScript files
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
    // Run tests for related files
    'jest --bail --findRelatedTests --passWithNoTests',
  ],

  // Stylesheet files
  '*.{css,scss,less,styl}': ['stylelint --fix', 'prettier --write'],

  // Documentation and config files
  '*.{json,md,mdx,yaml,yml}': ['prettier --write'],

  // Python files (if using Python tools)
  '*.py': ['black', 'isort', 'flake8'],

  // Conditional processing based on file patterns
  '*.{png,jpg,jpeg,gif,svg}': (filenames) => {
    // Only run image optimization on files larger than 10KB
    return filenames
      .filter((filename) => {
        const stats = require('fs').statSync(filename);
        return stats.size > 10240; // 10KB
      })
      .map((filename) => `imagemin ${filename} --out-dir=optimized/`);
  },

  // Environment-specific configuration
  '*.{js,ts}':
    process.env.NODE_ENV === 'production'
      ? ['eslint --fix', 'prettier --write', 'npm run test:unit']
      : ['eslint --fix', 'prettier --write'],
};