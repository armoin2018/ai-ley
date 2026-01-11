// Optimize for performance
module.exports = {
  '*.{js,ts}': [
    'eslint --fix --cache', // Use ESLint cache
    'prettier --write --cache', // Use Prettier cache
  ],

  // Skip large files
  '*.js': (filenames) => {
    const fs = require('fs');
    const smallFiles = filenames.filter((f) => {
      const stats = fs.statSync(f);
      return stats.size < 100000; // Skip files > 100KB
    });
    return `eslint --fix ${smallFiles.join(' ')}`;
  },
};