# Add test scripts to package.json
{
  "scripts": {
    "test": "vitest",
    "test:run": "vitest run",
    "test:watch": "vitest watch",
    "test:ui": "vitest --ui",
    "test:coverage": "vitest run --coverage"
  }
}

# Create basic test file
mkdir src/__tests__
touch src/__tests__/example.test.ts

# Initialize configuration (optional)
npx vitest init