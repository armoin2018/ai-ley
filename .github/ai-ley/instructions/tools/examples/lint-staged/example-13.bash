# Team setup workflow
npm install lint-staged husky eslint prettier --save-dev

# Configure lint-staged in package.json
cat > package.json << 'EOF'
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ],
    "*.{css,scss}": [
      "stylelint --fix",
      "prettier --write"
    ]
  }
}
EOF

# Set up pre-commit hook
npx husky init
echo "npx lint-staged" > .husky/pre-commit
chmod +x .husky/pre-commit

# Commit the configuration
git add .
git commit -m "feat: add lint-staged for code quality automation"