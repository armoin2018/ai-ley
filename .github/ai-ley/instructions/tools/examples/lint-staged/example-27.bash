# Enable comprehensive debugging
npx lint-staged --debug --verbose

# Check what commands would run
npx lint-staged --dry-run

# Test with specific files
git add specific-file.js
npx lint-staged --debug

# Verify configuration loading
npx lint-staged --help
npx lint-staged --print-config