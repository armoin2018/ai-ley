# Parcel CLI commands
parcel src/index.html                    # Development server
parcel build src/index.html              # Production build
parcel serve dist                        # Serve built files
parcel watch src/index.html              # Watch mode

# Bundle analysis
npx parcel-bundle-analyzer dist          # Analyze bundle size
parcel build --reporter @parcel/reporter-bundle-analyzer src/index.html

# Performance optimization
parcel build --no-source-maps src/index.html    # Disable source maps
parcel build --no-optimize src/index.html       # Disable optimization
parcel build --log-level verbose src/index.html # Verbose logging