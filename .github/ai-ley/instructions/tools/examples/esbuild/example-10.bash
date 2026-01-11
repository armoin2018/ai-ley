# Basic operations
esbuild src/index.js --bundle --outfile=dist/bundle.js    # Bundle JavaScript
esbuild src/index.ts --bundle --outfile=dist/bundle.js    # Bundle TypeScript
esbuild src/index.js --minify --outfile=dist/bundle.min.js # Minify code

# Development workflow
esbuild src/index.js --bundle --watch --outfile=dist/bundle.js     # Watch mode
esbuild src/index.js --bundle --sourcemap --outfile=dist/bundle.js # Source maps
esbuild src/index.js --bundle --serve=8000 --outdir=dist           # Development server

# Production build
esbuild src/index.js --bundle --minify --sourcemap=external --outfile=dist/bundle.js

# Platform targeting
esbuild src/index.js --bundle --platform=browser --outfile=dist/bundle.js  # Browser
esbuild src/server.js --bundle --platform=node --outfile=dist/server.js    # Node.js

# Format targeting
esbuild src/index.js --bundle --format=esm --outfile=dist/bundle.mjs   # ES modules
esbuild src/index.js --bundle --format=cjs --outfile=dist/bundle.cjs   # CommonJS
esbuild src/index.js --bundle --format=iife --outfile=dist/bundle.js   # IIFE

# Multiple entry points
esbuild src/page1.js src/page2.js --bundle --outdir=dist              # Multiple bundles
esbuild src/index.js --bundle --splitting --format=esm --outdir=dist   # Code splitting

# Asset handling
esbuild src/index.js --bundle --loader:.png=file --outfile=dist/bundle.js    # File loader
esbuild src/index.js --bundle --loader:.svg=text --outfile=dist/bundle.js    # Text loader

# Environment and defines
esbuild src/index.js --bundle --define:process.env.NODE_ENV='"production"' --outfile=dist/bundle.js

# External dependencies
esbuild src/index.js --bundle --external:react --external:react-dom --outfile=dist/bundle.js

# Analysis and debugging
esbuild src/index.js --bundle --metafile=meta.json --outfile=dist/bundle.js  # Generate metafile
esbuild --analyze meta.json                                                  # Analyze bundle