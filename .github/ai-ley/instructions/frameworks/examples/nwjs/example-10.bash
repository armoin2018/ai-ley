# Development workflow
npm start                    # Start application in development mode
npm run dev                  # Start with debugging enabled

# Building for different platforms
npm run build               # Build for all platforms
nwbuild -p win32,win64 .    # Build for Windows
nwbuild -p osx64 .         # Build for macOS
nwbuild -p linux32,linux64 . # Build for Linux

# Using nw-builder programmatically
node build.js              # Custom build script

# Development with hot reload (using webpack-dev-server)
npm run dev:webpack         # Start webpack dev server
npm run build:webpack       # Build with webpack

# Testing
npm test                    # Run unit tests
npm run test:e2e           # Run end-to-end tests

# Debugging
npm run debug              # Start with DevTools open
nw . --remote-debugging-port=9222 # Remote debugging