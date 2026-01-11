# .husky/pre-commit - Conditional based on changed files
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Get list of changed files
CHANGED_FILES=$(git diff --cached --name-only)

# Check if any JS/TS files were changed
if echo "$CHANGED_FILES" | grep -qE '\.(js|jsx|ts|tsx)$'; then
  echo "📝 JavaScript/TypeScript files changed, running linting..."
  npm run lint
fi

# Check if any CSS files were changed
if echo "$CHANGED_FILES" | grep -qE '\.(css|scss|less)$'; then
  echo "🎨 Stylesheet files changed, running style linting..."
  npm run lint:css
fi

# Check if package.json or package-lock.json changed
if echo "$CHANGED_FILES" | grep -q "package"; then
  echo "📦 Package files changed, running security audit..."
  npm audit --audit-level moderate
fi

# Check if documentation files changed
if echo "$CHANGED_FILES" | grep -qE '\.(md|mdx)$'; then
  echo "📚 Documentation changed, running markdown linting..."
  npm run lint:markdown
fi

# Always run tests for safety
echo "🧪 Running tests..."
npm run test