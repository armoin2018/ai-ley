// Handle tools that return non-zero exit codes
module.exports = {
  '*.js': [
    'eslint --fix --max-warnings=0', // Fail on warnings
    'prettier --write --check', // Check formatting after write
  ],

  // Alternative: ignore exit codes for specific tools
  '*.css': 'stylelint --fix || true', // Continue even if stylelint fails
};