# .husky/pre-commit - Environment-aware execution
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check if we're in CI environment
if [ "$CI" = "true" ]; then
  echo "🤖 Running in CI environment, skipping local-only checks..."
  npm run test
  exit 0
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt "18" ]; then
  echo "⚠️  Node.js 18+ required for full validation"
  echo "📝 Running basic checks only..."
  npm run lint:basic
  exit 0
fi

# Full validation for appropriate environment
echo "🔍 Running full pre-commit validation..."
npx lint-staged
npm run type-check
npm run test