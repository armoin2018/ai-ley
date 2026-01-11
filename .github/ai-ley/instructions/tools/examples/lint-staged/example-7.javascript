// lint-staged.config.js - Advanced configuration
const path = require('path');

module.exports = {
  // Dynamic command generation
  '*.{js,jsx,ts,tsx}': (filenames) => {
    const commands = [];

    // ESLint with specific config based on file location
    commands.push(
      filenames
        .map((filename) => {
          const isTestFile = filename.includes('.test.') || filename.includes('.spec.');
          const config = isTestFile ? '.eslintrc.test.js' : '.eslintrc.js';
          return `eslint --config ${config} --fix ${filename}`;
        })
        .join(' && '),
    );

    // Prettier formatting
    commands.push(`prettier --write ${filenames.join(' ')}`);

    // Type checking for TypeScript files
    const tsFiles = filenames.filter((file) => file.endsWith('.ts') || file.endsWith('.tsx'));
    if (tsFiles.length > 0) {
      commands.push('npx tsc --noEmit');
    }

    // Run related tests
    commands.push(`jest --bail --findRelatedTests ${filenames.join(' ')} --passWithNoTests`);

    return commands;
  },

  // CSS/SCSS with conditional Sass compilation
  '*.{css,scss}': (filenames) => {
    const commands = ['stylelint --fix', 'prettier --write'];

    const scssFiles = filenames.filter((file) => file.endsWith('.scss'));
    if (scssFiles.length > 0) {
      commands.push('npm run build:css');
    }

    return commands.concat(filenames.map((f) => `git add ${f}`));
  },

  // Package.json validation and sorting
  'package.json': ['npm audit fix --force', 'sort-package-json', 'prettier --write', 'git add'],

  // Documentation with link checking
  '*.md': ['markdownlint --fix', 'prettier --write', 'markdown-link-check'],
};