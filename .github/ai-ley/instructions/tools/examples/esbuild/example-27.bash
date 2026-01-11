# Use incremental builds
node build.js --incremental

# Analyze bundle size
esbuild src/index.js --bundle --metafile=meta.json --outfile=dist/bundle.js
esbuild --analyze meta.json

# External large dependencies
esbuild src/index.js \
  --bundle \
  --external:three.js \
  --external:d3 \
  --outfile=dist/bundle.js