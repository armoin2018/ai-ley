# List installed packages
npm list                    # Current project
npm list --depth=0          # Top-level only
npm list -g                 # Global packages
npm list express            # Specific package

# Update packages
npm update                  # Update all packages
npm update express          # Update specific package
npm update -g               # Update global packages

# Remove packages
npm uninstall express       # Remove dependency
npm uninstall -D jest       # Remove dev dependency
npm uninstall -g nodemon    # Remove global package

# View package information
npm view express            # Package details
npm view express version    # Specific field
npm view express versions   # All available versions
npm outdated               # Show outdated packages