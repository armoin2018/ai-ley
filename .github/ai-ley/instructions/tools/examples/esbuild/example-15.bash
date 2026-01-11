# Use native esbuild binary instead of npm package
go install github.com/evanw/esbuild/cmd/esbuild@latest

# Optimize for development speed
esbuild src/index.js \
  --bundle \
  --sourcemap=inline \
  --target=esnext \
  --format=esm \
  --outfile=dist/bundle.js

# Incremental builds
node -e "
const esbuild = require('esbuild');
esbuild.context({
  entryPoints: ['src/index.js'],
  bundle: true,
  outfile: 'dist/bundle.js',
  incremental: true
}).then(ctx => ctx.rebuild())
"

# Parallel builds for multiple targets
npm run build:browser & npm run build:node & wait