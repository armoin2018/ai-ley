# Production bundling with optimizations
bun build src/index.ts \
  --outdir=dist \
  --minify \
  --splitting \
  --target=browser \
  --format=esm

# Tree shaking and dead code elimination
bun build src/index.ts \
  --outfile=dist/bundle.js \
  --minify \
  --external=react

# Generate source maps for debugging
bun build src/index.ts \
  --outdir=dist \
  --sourcemap=external \
  --minify