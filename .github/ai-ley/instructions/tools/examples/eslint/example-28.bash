# Enable verbose output
eslint --debug src/components/

# Print configuration for specific file
eslint --print-config src/components/Button.tsx

# Test specific rule
eslint --rule '{"no-console": "error"}' src/utils/

# Check what files will be linted
eslint --print-config-path src/