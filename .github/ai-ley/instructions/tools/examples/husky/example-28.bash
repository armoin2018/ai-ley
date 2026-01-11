# Make hooks executable (Unix/Linux/macOS)
chmod +x .husky/pre-commit
chmod +x .husky/pre-push

# For Windows (using Git Bash)
git update-index --chmod=+x .husky/pre-commit

# Verify permissions
ls -la .husky/