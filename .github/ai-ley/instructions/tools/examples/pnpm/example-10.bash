# Package installation and management
pnpm install                        # Install dependencies
pnpm add <package>                  # Add dependency
pnpm remove <package>               # Remove dependency
pnpm update                         # Update dependencies
pnpm update --interactive           # Interactive update

# Package information
pnpm list                           # List installed packages
pnpm outdated                       # Show outdated packages
pnpm audit                          # Security audit
pnpm why <package>                  # Show dependency tree
pnpm licenses list                  # Show package licenses

# Script execution
pnpm run <script>                   # Run npm script
pnpm start                          # Run start script
pnpm test                           # Run test script
pnpm build                          # Run build script

# Workspace operations
pnpm -r run build                   # Run script recursively
pnpm --filter <package> <command>   # Run command in specific package
pnpm --filter="./packages/*" test   # Run in filtered packages

# Global operations
pnpm add -g <package>               # Install globally
pnpm list -g                        # List global packages
pnpm update -g                      # Update global packages

# Cache and store management
pnpm store status                   # Check store status
pnpm store prune                    # Remove orphaned packages
pnpm store path                     # Show store location

# Development and debugging
pnpm exec <command>                 # Execute command in project context
pnpm dlx <command>                  # Download and execute
pnpm create <template>              # Create project from template