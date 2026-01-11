# Essential daily commands
eslint src/                           # Lint all files in src directory
eslint src/ --fix                     # Lint and auto-fix issues
eslint src/ --max-warnings 0          # Fail on any warnings
eslint --help                         # Get command help

# Advanced operations
eslint src/ --format json             # Output results in JSON format
eslint src/ --config custom.config.js # Use custom config file
eslint src/ --debug                   # Enable debug output
eslint src/ --cache                   # Use caching for better performance
eslint src/ --fix-dry-run             # Preview fixes without applying

# Specific file type targeting
eslint "**/*.{js,jsx}"               # Only JavaScript files
eslint "**/*.{ts,tsx}"               # Only TypeScript files
eslint "src/**/*.test.js"            # Only test files