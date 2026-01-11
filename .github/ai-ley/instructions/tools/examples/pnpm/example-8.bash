# Remove dependencies
pnpm remove react-router-dom        # Remove from dependencies
pnpm rm lodash                      # Short form
pnpm remove -D @types/jest          # Remove from devDependencies

# Update dependencies
pnpm update                         # Update all packages
pnpm up                            # Short form
pnpm update react react-dom        # Update specific packages
pnpm update --latest               # Update to latest versions
pnpm update --interactive          # Interactive update

# Check outdated packages
pnpm outdated                      # Show outdated packages
pnpm outdated --format=table       # Table format
pnpm outdated react                # Check specific package

# List installed packages
pnpm list                          # List project dependencies
pnpm ls                           # Short form
pnpm list --depth=0               # Top-level only
pnpm list --prod                  # Production dependencies only
pnpm list --global                # Global packages