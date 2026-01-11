# Use caching for repeated runs
eslint --cache --cache-location .eslintcache src/

# Profile performance
time eslint src/

# Use worker threads (experimental)
ESLINT_USE_FLAT_CONFIG=true eslint src/