# Install all dependencies
pnpm install
pnpm i                              # Short form

# Install production dependencies only
pnpm install --prod
pnpm install --production

# Install with specific options
pnpm install --frozen-lockfile      # Don't update lock file
pnpm install --prefer-offline       # Use cache when possible
pnpm install --ignore-scripts       # Skip pre/post scripts

# Add new dependencies
pnpm add react react-dom            # Add to dependencies
pnpm add -D typescript @types/node   # Add to devDependencies
pnpm add -O eslint                  # Add to optionalDependencies
pnpm add -P express                 # Add to dependencies (explicit)

# Add with version specifications
pnpm add react@18.2.0              # Exact version
pnpm add lodash@^4.17.0             # Compatible version
pnpm add typescript@latest          # Latest version
pnpm add @types/node@~18.0.0        # Tilde range

# Add from different sources
pnpm add github:user/repo           # GitHub repository
pnpm add git+https://github.com/user/repo.git  # Git URL
pnpm add file:../local-package      # Local package
pnpm add https://registry.com/package.tgz      # Tarball URL