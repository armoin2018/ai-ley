# Test pattern matching
# Create test files and check if rules apply

# Debug pattern syntax
# Use specific patterns instead of complex globs
[*.js]        # Instead of [**/*.js]
[src/*.py]    # Instead of [src/**/*.py]

# Check for typos in file extensions
[*.{js,jsx,ts,tsx}]  # Correct
[*.{js,jsx,ts,tsx]   # Missing closing brace - incorrect