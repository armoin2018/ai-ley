# Install dependencies
yarn                               # Install from package.json/yarn.lock
yarn install                       # Same as above
yarn install --frozen-lockfile     # Install exact versions (CI/CD)
yarn install --production         # Install only production deps

# Add packages
yarn add lodash                    # Add production dependency
yarn add --dev jest                # Add development dependency
yarn add --peer react             # Add peer dependency
yarn add --optional fsevents      # Add optional dependency

# Version specifications
yarn add express@4.18.2           # Specific version
yarn add express@^4.18.0          # Compatible version range
yarn add express@latest           # Latest version
yarn add express@beta             # Beta version

# Install from different sources
yarn add lodash                    # npm registry
yarn add lodash@npm:^4.17.0       # Explicit npm protocol
yarn add github:lodash/lodash     # GitHub repository
yarn add https://github.com/user/repo.git  # Git URL
yarn add file:../local-package    # Local file system
yarn add link:../local-package    # Symlink to local package