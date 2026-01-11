# Development workflow
neu run                      # Start development server
neu run --frontend-lib-dev   # Start with frontend dev server

# Building
neu build                    # Build for current platform
neu build --release          # Build optimized release

# Cross-platform building
neu build --target linux     # Build for Linux
neu build --target windows   # Build for Windows
neu build --target mac       # Build for macOS

# Testing
npm test                     # Run frontend tests
neu run --mode=browser       # Test in browser mode

# Frontend build integration
npm run build               # Build frontend first
neu build                   # Then build Neutralino app

# Extension development
neu ext install extension-name
neu ext uninstall extension-name

# Distribution
neu dist                    # Create distribution packages

# Debugging
neu run --enable-inspector  # Enable Chrome DevTools
neu run --verbose          # Verbose logging