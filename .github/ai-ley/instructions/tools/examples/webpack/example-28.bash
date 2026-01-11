# Enable verbose logging
npx webpack --stats=verbose

# Debug specific loaders
DEBUG=webpack:* npx webpack

# Generate detailed stats
npx webpack --profile --json > stats.json

# Analyze bundle composition
npx webpack-bundle-analyzer stats.json