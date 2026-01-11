# Check types separately
npx tsc --noEmit

# Then bundle with esbuild
npx esbuild src/index.ts --bundle --outfile=dist/bundle.js

# Or use both in package.json
{
  "scripts": {
    "type-check": "tsc --noEmit",
    "build": "npm run type-check && esbuild src/index.ts --bundle --outfile=dist/bundle.js"
  }
}