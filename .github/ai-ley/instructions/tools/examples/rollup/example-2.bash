# Create rollup configuration
touch rollup.config.js
touch rollup.config.mjs  # For ES modules

# Basic package.json setup
{
  "scripts": {
    "build": "rollup -c",
    "build:watch": "rollup -c -w",
    "build:dev": "rollup -c --environment NODE_ENV:development",
    "build:prod": "rollup -c --environment NODE_ENV:production"
  },
  "main": "dist/bundle.cjs.js",
  "module": "dist/bundle.esm.js",
  "browser": "dist/bundle.umd.js",
  "types": "dist/index.d.ts"
}

# Initialize with npm init
npm init -y