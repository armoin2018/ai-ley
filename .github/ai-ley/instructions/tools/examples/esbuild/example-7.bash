# Basic bundling
esbuild src/index.js --bundle --outfile=dist/bundle.js

# Multiple entry points
esbuild src/app.js src/worker.js --bundle --outdir=dist

# TypeScript bundling
esbuild src/index.ts --bundle --outfile=dist/bundle.js

# React/JSX bundling
esbuild src/App.jsx --bundle --jsx=automatic --outfile=dist/bundle.js

# Node.js bundling
esbuild src/server.js --bundle --platform=node --outfile=dist/server.js

# Code splitting
esbuild src/index.js --bundle --splitting --format=esm --outdir=dist

# Tree shaking (automatic)
esbuild src/index.js --bundle --outfile=dist/bundle.js # Dead code eliminated