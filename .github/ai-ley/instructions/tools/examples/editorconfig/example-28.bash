# Check if .editorconfig file exists and is properly placed
ls -la .editorconfig

# Verify file content and syntax
cat .editorconfig

# Check editor plugin installation
# VS Code:
code --list-extensions | grep EditorConfig

# Restart editor after plugin installation
# Close and reopen all files to apply new rules