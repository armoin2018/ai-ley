# Install production dependencies
npm install express
npm install express@4.18.2          # Specific version
npm install express@^4.18.0         # Compatible version
npm install express@latest          # Latest version

# Install development dependencies
npm install --save-dev jest
npm install -D typescript eslint    # Short form

# Install globally
npm install -g nodemon
npm install --global @vue/cli

# Install from different sources
npm install lodash                   # npm registry
npm install github:lodash/lodash    # GitHub
npm install git+https://github.com/user/repo.git  # Git URL
npm install https://registry.com/package.tgz      # Tarball URL
npm install file:../local-package   # Local file system

# Install all dependencies
npm install                          # Install from package.json
npm ci                              # Clean install (CI/CD)