// Secure command configuration
module.exports = {
  // Use array syntax to prevent shell injection
  '*.js': ['eslint --fix', 'prettier --write'],

  // Avoid dynamic command generation with user input
  // BAD: `eslint ${userInput}`
  // GOOD: predefined commands only

  // Validate file paths
  '*.js': (filenames) => {
    const safePaths = filenames.filter((f) => !f.includes('..') && f.startsWith('src/'));
    return [`eslint --fix ${safePaths.join(' ')}`];
  },
};