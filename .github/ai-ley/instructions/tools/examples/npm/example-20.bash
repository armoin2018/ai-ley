# Analyze bundle size
npx webpack-bundle-analyzer dist/
npx source-map-explorer dist/bundle.js
npm install -g cost-of-modules && cost-of-modules

# Reduce bundle size
npm install --production           # Only production dependencies
npm prune                         # Remove unused packages