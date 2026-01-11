// lint-staged.config.js - Multi-stage processing pipeline
const { ESLint } = require('eslint');

module.exports = {
  // Stage 1: Fast checks (syntax, basic linting)
  '*.{js,jsx,ts,tsx}': async (filenames) => {
    const eslint = new ESLint({ fix: true });

    // Quick syntax check first
    const results = await eslint.lintFiles(filenames);
    const hasErrors = results.some((result) => result.errorCount > 0);

    if (hasErrors) {
      // If there are errors, only run basic fixes
      return ['eslint --fix --quiet', 'prettier --write'];
    } else {
      // If no errors, run full pipeline
      return [
        'eslint --fix',
        'prettier --write',
        'jest --bail --findRelatedTests --passWithNoTests',
        'npm run type-check',
      ];
    }
  },

  // Stage 2: Asset optimization (runs after main checks)
  '*.{png,jpg,jpeg,gif,svg}': ['imagemin-lint-staged', 'node scripts/update-asset-manifest.js'],
};