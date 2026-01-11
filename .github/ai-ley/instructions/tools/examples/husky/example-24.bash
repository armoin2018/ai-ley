# .husky/pre-commit - Jest with coverage thresholds
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🧪 Running tests with coverage..."

# Run tests for changed files with coverage
npm run test -- --coverage --changedSince=HEAD^ || {
  echo "❌ Tests failed or coverage below threshold"
  exit 1
}

# Check if coverage reports were generated
if [ -d "coverage" ]; then
  echo "📊 Coverage report generated in coverage/"
fi