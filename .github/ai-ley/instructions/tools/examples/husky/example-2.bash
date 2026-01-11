# Initialize Husky (creates .husky directory and installs Git hooks)
npx husky init

# Add your first hook (pre-commit example)
echo "npm test" > .husky/pre-commit

# Make hook executable (Unix/Linux/macOS)
chmod +x .husky/pre-commit

# Verify installation
ls -la .husky/
cat .husky/pre-commit