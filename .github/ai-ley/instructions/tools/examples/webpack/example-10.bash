# Build commands
npx webpack                        # Build with default config
npx webpack --config webpack.config.js  # Specific config file
npx webpack --mode=production      # Production build
npx webpack --mode=development     # Development build

# Watch mode
npx webpack --watch               # Watch for changes
npx webpack -w                    # Short form

# Development server
npx webpack serve                 # Start dev server
npx webpack serve --mode=development  # Dev server in dev mode
npx webpack serve --open          # Open browser automatically

# Bundle analysis
npx webpack-bundle-analyzer dist/bundle.js  # Analyze bundle
npx webpack --profile --json > stats.json   # Generate stats

# Environment-specific builds
npx webpack --env production      # Pass environment variables
npx webpack --env development --env api=localhost

# Verbose output
npx webpack --progress            # Show build progress
npx webpack --verbose             # Detailed output

# Performance analysis
npx webpack --analyze             # Bundle analysis
ANALYZE=true npm run build        # With environment variable