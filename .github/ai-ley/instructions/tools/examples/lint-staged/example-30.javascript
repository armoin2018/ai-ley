// Prevent processing of sensitive files
module.exports = {
  // Exclude sensitive file patterns
  '*.{js,ts}': ['eslint --fix', 'prettier --write'],

  // Explicitly exclude sensitive patterns
  '!.env*': [],
  '!**/secrets/**': [],
  '!**/node_modules/**': [],

  // Validate against sensitive patterns
  '*': (filenames) => {
    const sensitivePatterns = ['.env', 'secret', 'password', 'key'];
    const hasSensitiveFiles = filenames.some((f) =>
      sensitivePatterns.some((pattern) => f.includes(pattern)),
    );

    if (hasSensitiveFiles) {
      throw new Error('Sensitive files detected in staging area');
    }

    return [];
  },
};