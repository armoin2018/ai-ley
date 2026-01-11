# Basic bundling
esbuild src/index.js --bundle --outfile=dist/bundle.js

# Multiple entry points
esbuild src/page1.js src/page2.js --bundle --outdir=dist

# TypeScript support
esbuild src/index.ts --bundle --outfile=dist/bundle.js

# JSX/React support
esbuild src/App.jsx --bundle --outfile=dist/bundle.js --jsx=automatic

# Development mode with sourcemap
esbuild src/index.js --bundle --outfile=dist/bundle.js --sourcemap --watch

# Production mode with minification
esbuild src/index.js --bundle --minify --outfile=dist/bundle.js

# Target specific environments
esbuild src/index.js --bundle --outfile=dist/bundle.js --target=es2020
esbuild src/index.js --bundle --outfile=dist/bundle.js --target=node16
esbuild src/index.js --bundle --outfile=dist/bundle.js --target=chrome90,firefox88