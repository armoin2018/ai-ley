# Enable debug logging
bun --verbose install
bun --inspect src/index.ts

# Check installation issues
bun install --verbose
bun pm ls

# Test debugging
bun test --verbose
bun test --reporter=verbose

# Build debugging
bun build --verbose src/index.ts