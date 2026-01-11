# Install lint-staged
npm install lint-staged --save-dev

# Configure in package.json
{
  "lint-staged": {
    "*.{js,ts}": ["eslint --fix", "prettier --write"]
  }
}

# Update pre-commit hook
echo "npx lint-staged" > .husky/pre-commit