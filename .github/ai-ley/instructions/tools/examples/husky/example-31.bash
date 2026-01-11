# Enable Husky debugging
HUSKY_DEBUG=1 git commit -m "debug commit"

# Check hook configuration
cat .husky/pre-commit
ls -la .husky/

# Test hook execution manually
./.husky/pre-commit

# Verify Git hooks path
git config --list | grep hooks