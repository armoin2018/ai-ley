// lint-staged.config.js for monorepo
const path = require('path');

module.exports = {
  // Frontend package
  'packages/frontend/**/*.{js,jsx,ts,tsx}': [
    'eslint --config packages/frontend/.eslintrc.js --fix',
    'prettier --config packages/frontend/.prettierrc --write',
    'jest --config packages/frontend/jest.config.js --findRelatedTests',
  ],

  // Backend package
  'packages/backend/**/*.{js,ts}': [
    'eslint --config packages/backend/.eslintrc.js --fix',
    'prettier --config packages/backend/.prettierrc --write',
    'jest --config packages/backend/jest.config.js --findRelatedTests',
  ],

  // Shared utilities
  'packages/shared/**/*.{js,ts}': [
    'eslint --config packages/shared/.eslintrc.js --fix',
    'prettier --write',
    'npm run test:shared',
  ],

  // Root level configuration files
  'package.json': ['sort-package-json', 'prettier --write'],
  'packages/*/package.json': ['sort-package-json', 'prettier --write'],

  // Documentation
  '*.md': ['markdownlint --fix', 'prettier --write'],
  'docs/**/*.md': ['markdownlint --config docs/.markdownlint.json --fix'],
};