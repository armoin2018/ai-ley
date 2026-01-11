# New team member setup
git clone project-repository
cd project-repository

# Verify EditorConfig presence
ls -la .editorconfig

# Install editor plugin (VS Code example)
code --install-extension EditorConfig.EditorConfig

# Verify plugin is working
echo "Testing EditorConfig..." > test.js
# Open test.js in editor - should apply configured formatting

# Clean up test
rm test.js