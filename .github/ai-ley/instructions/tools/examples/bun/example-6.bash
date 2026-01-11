# Install dependencies
bun install                    # Install all dependencies
bun i                         # Short form

# Install specific packages
bun add react react-dom       # Add to dependencies
bun add -d typescript         # Add to devDependencies
bun add -D @types/node        # Same as -d
bun add --optional sharp      # Add to optionalDependencies
bun add --exact lodash@4.17.21  # Install exact version

# Install from various sources
bun add github:user/repo      # GitHub repository
bun add git+ssh://git@github.com:user/repo.git  # SSH Git URL
bun add file:../local-package # Local package
bun add @scope/package@tag    # Specific tag

# Remove packages
bun remove react-router-dom   # Remove dependency
bun rm lodash                # Short form

# Update packages
bun update                    # Update all packages
bun update react             # Update specific package
bun outdated                 # Check outdated packages