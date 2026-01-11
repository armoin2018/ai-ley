# Analyze dependencies
yarn list --depth=0               # Top-level dependencies only
yarn why lodash                   # Why is this package installed?
yarn audit --summary              # Security audit summary

# Package analysis tools
yarn dlx webpack-bundle-analyzer dist/
yarn dlx source-map-explorer dist/bundle.js