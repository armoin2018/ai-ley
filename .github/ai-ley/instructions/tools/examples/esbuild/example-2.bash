# Create build script in package.json
{
  "scripts": {
    "build": "esbuild src/index.js --bundle --outfile=dist/bundle.js",
    "build:watch": "esbuild src/index.js --bundle --outfile=dist/bundle.js --watch",
    "build:dev": "esbuild src/index.js --bundle --outfile=dist/bundle.js --sourcemap --watch",
    "build:prod": "esbuild src/index.js --bundle --minify --outfile=dist/bundle.js"
  }
}

# Create esbuild configuration file
touch esbuild.config.js
touch build.js