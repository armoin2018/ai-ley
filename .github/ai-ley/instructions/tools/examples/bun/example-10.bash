# Package management
bun install                  # Install dependencies
bun add <package>           # Add package
bun remove <package>        # Remove package
bun update                  # Update packages
bun outdated               # Check outdated packages

# Script execution
bun run <script>           # Run npm script
bun start                  # Run start script
bun dev                    # Run dev script
bun build                  # Run build script

# Direct execution
bun <file>                 # Run JavaScript/TypeScript file
bun --hot <file>           # Run with hot reload
bun --watch <file>         # Run with file watching

# Testing
bun test                   # Run tests
bun test --watch          # Watch mode
bun test --coverage       # Generate coverage

# Bundling
bun build <input>         # Bundle for production
bun build --watch         # Bundle with watching

# Utilities
bun create <template>     # Create new project
bun init                  # Initialize package.json
bun upgrade              # Update Bun itself
bun pm cache clear       # Clear package cache