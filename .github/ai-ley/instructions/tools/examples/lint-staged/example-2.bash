# Install Husky and lint-staged together
npm install husky lint-staged --save-dev

# Initialize Husky
npx husky init

# Create pre-commit hook with lint-staged
echo "npx lint-staged" > .husky/pre-commit
chmod +x .husky/pre-commit

# Test the setup
git add .
git commit -m "test: verify lint-staged setup"