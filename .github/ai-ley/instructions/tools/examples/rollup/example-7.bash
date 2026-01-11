# Basic bundling
rollup src/index.js --file dist/bundle.js --format umd --name MyLibrary

# Multiple formats
rollup src/index.js --file dist/bundle.cjs.js --format cjs
rollup src/index.js --file dist/bundle.esm.js --format es
rollup src/index.js --file dist/bundle.umd.js --format umd --name MyLibrary

# With configuration file
rollup -c
rollup --config rollup.config.js

# Watch mode
rollup -c -w
rollup --config --watch

# Environment-specific builds
rollup -c --environment NODE_ENV:production
rollup -c --environment BUILD:development