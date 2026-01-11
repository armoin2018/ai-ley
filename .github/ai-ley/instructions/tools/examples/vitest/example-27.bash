# Enable debug logging
DEBUG=vitest:* npm test

# Run with Node.js inspector
npx vitest --inspect-brk

# Debug specific test file
npx vitest --inspect-brk src/component.test.tsx

# Run single test in debug mode
npx vitest --run --reporter=verbose button.test.ts