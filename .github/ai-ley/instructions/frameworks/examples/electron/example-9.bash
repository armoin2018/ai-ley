# Development workflow
npm start                     # Start development server
npm run lint                  # Run ESLint
npm run type-check           # TypeScript type checking
npm test                     # Run tests

# Building for distribution
npm run make                 # Build for current platform
npm run make -- --platform=darwin  # Build for macOS
npm run make -- --platform=win32   # Build for Windows
npm run make -- --platform=linux   # Build for Linux

# Publishing
npm run publish              # Build and publish to GitHub releases

# Debugging
npm run start:debug          # Start with DevTools enabled
npm run start:inspect        # Start with Node.js inspector