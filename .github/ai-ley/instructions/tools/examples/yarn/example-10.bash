# Installation and setup
yarn                               # Install dependencies
yarn install                       # Install dependencies
yarn install --frozen-lockfile     # Install with locked versions
yarn add [package]                 # Add dependency
yarn add --dev [package]           # Add dev dependency
yarn remove [package]              # Remove dependency

# Package information
yarn list                          # List installed packages
yarn info [package]                # Show package information
yarn outdated                      # Show outdated packages
yarn audit                         # Security audit
yarn audit fix                     # Fix security issues (Yarn 1.x)

# Workspace management
yarn workspaces info               # Workspace information
yarn workspace [name] [command]    # Run command in workspace
yarn workspaces run [script]       # Run script in all workspaces

# Cache and cleaning
yarn cache list                    # List cached packages
yarn cache dir                     # Show cache directory
yarn cache clean                   # Clean cache
yarn cache clean [package]         # Clean specific package

# Script execution
yarn run [script]                  # Run package.json script
yarn [script]                      # Run script (shorthand)
yarn start                         # Run start script
yarn test                          # Run test script
yarn build                         # Run build script

# Version management
yarn version                       # Interactive version bump
yarn version --patch               # Bump patch version
yarn version --minor               # Bump minor version
yarn version --major               # Bump major version

# Global packages
yarn global add [package]          # Install globally
yarn global remove [package]       # Remove global package
yarn global list                   # List global packages
yarn global bin                    # Show global bin directory

# Configuration
yarn config list                   # Show configuration
yarn config get [key]              # Get configuration value
yarn config set [key] [value]      # Set configuration value
yarn config delete [key]           # Delete configuration value

# Publishing (Yarn 1.x)
yarn login                         # Login to registry
yarn publish                       # Publish package
yarn publish --tag beta            # Publish with tag