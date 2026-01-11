# .husky/pre-push - Comprehensive pre-push validation
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push checks..."

# Ensure all commits are properly formatted
echo "📋 Checking commit messages..."
npm run commitlint || {
  echo "❌ Commit message format is invalid."
  exit 1
}

# Run full test suite with coverage
echo "🧪 Running full test suite..."
npm run test:coverage || {
  echo "❌ Tests failed or coverage threshold not met."
  exit 1
}

# Security audit
echo "🔒 Running security audit..."
npm audit --audit-level moderate || {
  echo "⚠️  Security vulnerabilities found. Please review."
  # Don't exit on audit failures in development, but warn
}

# Build check
echo "🏗️ Checking build..."
npm run build || {
  echo "❌ Build failed."
  exit 1
}

echo "✅ All pre-push checks passed! Safe to push."