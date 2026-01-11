# .husky/pre-commit - Advanced with error handling
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit checks..."

# Run linting
echo "📝 Checking code style..."
npm run lint || {
  echo "❌ Linting failed. Please fix the issues above."
  exit 1
}

# Run Prettier formatting check
echo "🎨 Checking code formatting..."
npm run format:check || {
  echo "❌ Code formatting issues found. Run 'npm run format' to fix."
  exit 1
}

# Type checking for TypeScript projects
if [ -f "tsconfig.json" ]; then
  echo "📘 Type checking..."
  npm run type-check || {
    echo "❌ TypeScript type checking failed."
    exit 1
  }
fi

# Run tests
echo "🧪 Running tests..."
npm run test || {
  echo "❌ Tests failed. Please fix failing tests."
  exit 1
}

echo "✅ All pre-commit checks passed!"