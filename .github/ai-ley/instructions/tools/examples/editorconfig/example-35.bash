# Validate EditorConfig files before committing
editorconfig-checker .editorconfig

# Automated validation in CI
npm install --save-dev editorconfig-checker
echo "editorconfig-checker" >> package.json scripts.lint

# Pre-commit hook validation
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Validate EditorConfig
if command -v editorconfig-checker >/dev/null 2>&1; then
    editorconfig-checker
fi
EOF