# Project setup
pnpm create react-app my-app --template typescript
cd my-app

# Add common development tools
pnpm add -D eslint prettier husky lint-staged
pnpm add -D @typescript-eslint/parser @typescript-eslint/eslint-plugin

# Setup git hooks
pnpm dlx husky-init
echo "pnpm lint-staged" > .husky/pre-commit