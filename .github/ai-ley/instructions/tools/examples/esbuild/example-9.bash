# TypeScript compilation
esbuild src/index.ts --outfile=dist/index.js

# TypeScript with bundling
esbuild src/index.ts --bundle --outfile=dist/bundle.js

# Multiple TypeScript files
esbuild src/**/*.ts --outdir=dist

# TypeScript with declaration files (type checking only)
tsc --noEmit && esbuild src/index.ts --bundle --outfile=dist/bundle.js

# TypeScript configuration
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "jsx": "preserve",
    "noEmit": true
  }
}