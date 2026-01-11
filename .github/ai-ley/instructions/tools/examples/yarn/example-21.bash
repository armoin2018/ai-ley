# Cache management
yarn cache list                   # List cached packages
yarn cache dir                    # Show cache directory
yarn cache clean                  # Clean all cache
yarn cache clean lodash           # Clean specific package

# Global cache (Yarn 3+)
yarn config set enableGlobalCache true
yarn config set globalFolder ~/.yarn/global