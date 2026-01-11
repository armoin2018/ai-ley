# Check file patterns and location
npx mocha --dry-run

# Verify test file naming conventions
ls test/**/*.test.js
ls test/**/*.spec.js

# Check configuration
cat .mocharc.json
cat package.json | grep -A5 '"mocha"'

# Run with verbose output
npx mocha --verbose