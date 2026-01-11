# Cache operations
npm cache verify                   # Verify cache integrity
npm cache clean --force            # Clear all cached data
npm cache ls                       # List cached packages

# Cache configuration
npm config set cache /path/to/cache
npm config get cache

# Offline installation
npm install --prefer-offline       # Use cache when available
npm install --offline             # Only use cache (fail if not cached)