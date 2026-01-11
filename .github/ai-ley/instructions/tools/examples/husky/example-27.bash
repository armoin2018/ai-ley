# Check if Husky is properly installed
ls -la .husky/
cat .husky/pre-commit

# Verify Git hooks path
git config core.hooksPath

# Reinstall Husky if needed
rm -rf .husky
npx husky init
echo "npm test" > .husky/pre-commit
chmod +x .husky/pre-commit

# Check hook permissions (Unix/Linux/macOS)
chmod +x .husky/*