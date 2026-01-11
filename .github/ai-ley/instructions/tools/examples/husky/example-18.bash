# New developer workflow
git clone <repository>
cd <project>
npm install  # Automatically sets up Husky hooks

# Verify hooks are installed
ls -la .husky/
git config core.hooksPath  # Should show .husky

# Make first commit (hooks will run automatically)
echo "# Test" >> README.md
git add README.md
git commit -m "docs: test commit with hooks"