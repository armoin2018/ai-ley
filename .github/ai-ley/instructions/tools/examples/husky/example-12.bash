# Create pre-commit hook
echo "npm run lint && npm run test" > .husky/pre-commit
chmod +x .husky/pre-commit

# Create pre-push hook
echo "npm run build && npm run test:e2e" > .husky/pre-push
chmod +x .husky/pre-push