# Basic bundling
bun build src/index.ts --outdir=dist
bun build src/index.ts --outfile=dist/bundle.js

# Advanced bundling options
bun build src/index.ts \
  --outdir=dist \
  --target=browser \
  --format=esm \
  --minify \
  --sourcemap=external \
  --splitting

# Multiple entry points
bun build src/client.ts src/worker.ts --outdir=dist

# Node.js target
bun build src/server.ts \
  --target=node \
  --outfile=dist/server.js \
  --minify

# Library bundling
bun build src/lib.ts \
  --outdir=dist \
  --format=esm \
  --format=cjs \
  --external=react