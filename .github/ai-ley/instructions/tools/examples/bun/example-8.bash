# Run tests
bun test                     # Run all tests
bun test --watch            # Watch mode
bun test --coverage         # Generate coverage report

# Run specific tests
bun test math.test.ts       # Run specific file
bun test --grep="addition"  # Run tests matching pattern
bun test src/              # Run tests in directory

# Test configuration and options
bun test --timeout=10000    # Set timeout
bun test --reporter=json    # JSON output
bun test --verbose          # Verbose output
bun test --silent          # Minimal output

# Example test file
// math.test.ts
import { expect, test, describe, beforeAll, afterAll } from "bun:test";

describe("Math operations", () => {
  beforeAll(() => {
    console.log("Setup tests");
  });

  test("addition", () => {
    expect(2 + 2).toBe(4);
  });

  test("async operation", async () => {
    const result = await Promise.resolve(42);
    expect(result).toBe(42);
  });
});