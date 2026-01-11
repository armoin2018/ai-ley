# Tree shaking (automatic with ES modules)
esbuild src/index.js --bundle --format=esm --outfile=dist/bundle.js

# Minification and compression
esbuild src/index.js \
  --bundle \
  --minify \
  --mangle-props=_$ \
  --drop:console \
  --drop:debugger \
  --outfile=dist/bundle.min.js

# External dependencies
esbuild src/index.js \
  --bundle \
  --external:react \
  --external:react-dom \
  --external:lodash \
  --outfile=dist/bundle.js

# Bundle analysis
esbuild src/index.js \
  --bundle \
  --metafile=meta.json \
  --outfile=dist/bundle.js

# Analyze the metafile
npx esbuild --analyze meta.json