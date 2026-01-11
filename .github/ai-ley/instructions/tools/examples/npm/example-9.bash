# Package installation
npm install [package]              # Install package
npm install -g [package]           # Install globally
npm install --save-dev [package]   # Install as dev dependency
npm ci                             # Clean install for CI/CD

# Package management
npm update                         # Update all packages
npm uninstall [package]            # Remove package
npm outdated                       # Check for outdated packages
npm audit                          # Security audit
npm audit fix                      # Fix security vulnerabilities

# Information and search
npm list                           # List installed packages
npm view [package]                 # View package information
npm search [keyword]               # Search for packages
npm info [package]                 # Detailed package info

# Publishing and registry
npm login                          # Login to npm registry
npm publish                        # Publish package
npm unpublish [package]@[version]  # Unpublish version
npm deprecate [package]@[version]  # Deprecate version

# Configuration
npm config list                    # Show configuration
npm config set [key] [value]       # Set configuration
npm config get [key]               # Get configuration value
npm config delete [key]            # Delete configuration

# Cache management
npm cache verify                   # Verify cache integrity
npm cache clean --force            # Clear cache
npm cache ls                       # List cached packages

# Workspace management (npm 7+)
npm init -w packages/package-a     # Create workspace package
npm run test --workspace=package-a # Run script in workspace
npm install lodash --workspace=package-a  # Install in workspace