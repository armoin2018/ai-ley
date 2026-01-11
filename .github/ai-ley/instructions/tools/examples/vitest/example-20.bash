# Run only unit tests
npx vitest --run src/**/*.unit.test.ts

# Skip integration tests
npx vitest --run --exclude="**/*.integration.test.ts"

# Run tests for specific components
npx vitest --run src/components/**/*.test.tsx

# Run tests based on changed files
npx vitest --run --changed HEAD~1

# Run tests with specific tags
npx vitest --run --grep="@fast"