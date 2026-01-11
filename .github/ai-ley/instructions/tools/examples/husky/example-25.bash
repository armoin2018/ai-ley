# .husky/pre-commit - TypeScript with incremental checking
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Type check with incremental compilation
echo "📘 Incremental TypeScript checking..."
npx tsc --noEmit --incremental || {
  echo "❌ TypeScript compilation errors found"
  exit 1
}

# Check for TypeScript-specific linting
echo "📝 TypeScript-specific linting..."
npx eslint --ext .ts,.tsx src/ || {
  echo "❌ TypeScript linting failed"
  exit 1
}