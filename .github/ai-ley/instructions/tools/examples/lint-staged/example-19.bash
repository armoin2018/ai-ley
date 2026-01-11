# Complete Husky + lint-staged setup
npm install husky lint-staged --save-dev

# Initialize Husky
npx husky init

# Create pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Run lint-staged
npx lint-staged

# Additional checks
npm run type-check
EOF

chmod +x .husky/pre-commit

# Create pre-push hook for comprehensive checks
cat > .husky/pre-push << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Run full test suite before push
npm run test:coverage
npm run build
EOF

chmod +x .husky/pre-push