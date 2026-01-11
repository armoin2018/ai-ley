# Team lead setup
npm install husky lint-staged --save-dev
npx husky init

# Create comprehensive pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit validation..."

# Lint staged files
npx lint-staged

# Type check
if [ -f "tsconfig.json" ]; then
  npm run type-check
fi

echo "✅ Pre-commit validation passed!"
EOF

chmod +x .husky/pre-commit

# Create pre-push hook
cat > .husky/pre-push << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push validation..."

# Full test suite
npm run test

# Build verification
npm run build

echo "✅ Pre-push validation passed!"
EOF

chmod +x .husky/pre-push

# Commit configuration
git add .
git commit -m "feat: add Husky Git hooks for code quality"