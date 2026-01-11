# Basic operations
rollup src/index.js --file dist/bundle.js --format umd --name MyLib    # Bundle to UMD
rollup src/index.js --file dist/bundle.js --format es                  # Bundle to ES modules
rollup src/index.js --file dist/bundle.js --format cjs                 # Bundle to CommonJS

# Configuration-based builds
rollup -c                           # Use rollup.config.js
rollup --config custom.config.js   # Use custom config
rollup -c -w                        # Watch mode
rollup -c --watch                   # Watch mode (explicit)

# Environment and variables
rollup -c --environment NODE_ENV:production        # Set environment
rollup -c --environment BUILD:dev,TARGET:browser   # Multiple variables

# Output options
rollup src/index.js -o dist/bundle.js -f umd -n MyLib     # Short flags
rollup src/index.js --dir dist --format es                # Output directory

# Plugin and external handling
rollup -c --external react,react-dom                      # External dependencies
rollup -c --globals react:React,react-dom:ReactDOM        # Global variable mapping

# Development and debugging
rollup -c --sourcemap              # Generate source maps
rollup -c --silent                 # Suppress output
rollup -c --verbose                # Verbose logging
rollup -c --stats                  # Bundle analysis

# Production builds
rollup -c --environment NODE_ENV:production,BUILD:prod    # Production environment
rollup -c --compact                # Compact output