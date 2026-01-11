# Verbose logging
esbuild src/index.js --bundle --log-level=verbose --outfile=dist/bundle.js

# Debug specific loader
esbuild src/index.js --bundle --log-level=debug --outfile=dist/bundle.js

# Analyze resolution
esbuild src/index.js --bundle --log-level=info --outfile=dist/bundle.js

# Check metafile
esbuild src/index.js --bundle --metafile=meta.json --outfile=dist/bundle.js
cat meta.json | jq '.inputs'