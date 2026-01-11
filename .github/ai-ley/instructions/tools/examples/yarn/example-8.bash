# List installed packages
yarn list                          # All packages
yarn list --depth=0               # Top-level only
yarn list --pattern="webpack*"    # Filter by pattern
yarn global list                  # Global packages

# Update packages
yarn upgrade                       # Update all packages
yarn upgrade lodash                # Update specific package
yarn upgrade-interactive          # Interactive update (with plugin)
yarn upgrade lodash@^4.17.21      # Update to specific version

# Remove packages
yarn remove lodash                 # Remove dependency
yarn remove --dev jest             # Remove dev dependency
yarn global remove nodemon        # Remove global package

# Package information
yarn info lodash                   # Package details
yarn info lodash version          # Specific field
yarn info lodash versions         # All available versions
yarn outdated                     # Show outdated packages
yarn audit                        # Security audit
yarn audit --summary              # Audit summary only