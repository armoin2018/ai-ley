# Basic minification
esbuild src/index.js --bundle --minify --outfile=dist/bundle.min.js

# Minify with sourcemap
esbuild src/index.js --bundle --minify --sourcemap --outfile=dist/bundle.min.js

# Minify and drop console statements
esbuild src/index.js --bundle --minify --drop:console --outfile=dist/bundle.min.js

# Advanced minification options
esbuild src/index.js \
  --bundle \
  --minify \
  --mangle-props=regex \
  --drop:console \
  --drop:debugger \
  --outfile=dist/bundle.min.js