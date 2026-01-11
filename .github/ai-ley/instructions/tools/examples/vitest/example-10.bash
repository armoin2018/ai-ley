# Basic test execution
npm test                           # Run tests in watch mode
npm run test:run                   # Run tests once
npm run test:watch                 # Explicit watch mode

# Test filtering
npx vitest math                    # Run tests matching "math"
npx vitest --run src/utils         # Run tests in specific directory
npx vitest button.test.ts          # Run specific test file

# Coverage reporting
npm run test:coverage              # Run with coverage
npx vitest --coverage              # Direct coverage command
npx vitest --coverage.enabled      # Enable coverage flag

# UI and reporting
npm run test:ui                    # Open Vitest UI
npx vitest --ui                    # Direct UI command
npx vitest --reporter=verbose      # Verbose output
npx vitest --reporter=json         # JSON output

# Browser testing
npx vitest --browser               # Run in browser mode
npx vitest --browser.name=firefox  # Specific browser

# Configuration
npx vitest --config vitest.config.ts  # Custom config file
npx vitest --root ./packages/core     # Custom root directory

# Debug mode
npx vitest --inspect               # Enable Node.js inspector
npx vitest --inspect-brk           # Break on start
DEBUG=vitest:* npx vitest          # Debug logging

# Parallel execution
npx vitest --threads=false         # Disable threading
npx vitest --max-threads=4         # Limit thread count
npx vitest --min-threads=2         # Minimum threads

# File watching
npx vitest --watch=false           # Disable watch mode
npx vitest --changed               # Only changed files
npx vitest --related              # Files related to changed