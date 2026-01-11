# .husky/pre-commit - Validate EditorConfig compliance
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check EditorConfig compliance
if command -v editorconfig-checker >/dev/null 2>&1; then
    echo "🔍 Checking EditorConfig compliance..."
    editorconfig-checker

    if [ $? -ne 0 ]; then
        echo "❌ EditorConfig violations found. Please fix formatting issues."
        exit 1
    fi
    echo "✅ EditorConfig compliance verified"
fi