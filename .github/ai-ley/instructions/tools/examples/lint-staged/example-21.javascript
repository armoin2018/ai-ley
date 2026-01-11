// lint-staged.config.js - Advanced Jest integration
module.exports = {
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
    // Smart test execution
    (filenames) => {
      const testFiles = filenames.filter((f) => f.includes('.test.') || f.includes('.spec.'));
      const sourceFiles = filenames.filter((f) => !f.includes('.test.') && !f.includes('.spec.'));

      const commands = [];

      // Run test files directly
      if (testFiles.length > 0) {
        commands.push(`jest ${testFiles.join(' ')} --passWithNoTests`);
      }

      // Find and run tests related to source files
      if (sourceFiles.length > 0) {
        commands.push(`jest --findRelatedTests ${sourceFiles.join(' ')} --passWithNoTests`);
      }

      return commands;
    },
  ],
};