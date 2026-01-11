# Essential daily commands
prettier --write .                    # Format all files in project
prettier --check .                    # Check if files are formatted
prettier --write src/                 # Format specific directory
prettier --help                       # Get command help

# File-specific operations
prettier --write "**/*.{js,tsx}"      # Format JavaScript/TypeScript files
prettier --write "**/*.css"           # Format CSS files only
prettier --write README.md            # Format single file

# Advanced operations
prettier --config custom.config.js --write .  # Use custom config
prettier --ignore-path .gitignore --write .   # Use gitignore as ignore file
prettier --debug-check src/component.tsx      # Debug formatting issues
prettier --list-different .           # List files that would be changed

# CI/CD specific commands
prettier --check . --write false      # Check without modifying files
prettier --write . --log-level error  # Only show errors