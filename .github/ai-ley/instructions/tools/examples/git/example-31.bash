# Check conflict status
git status

# Open conflicted files and resolve manually
# Look for conflict markers: <<<<<<<, =======, >>>>>>>
# Edit file to keep desired changes

# After resolving conflicts
git add resolved-file.js
git commit -m "Resolve merge conflicts"

# Abort merge if needed
git merge --abort

# Use merge tool for visual resolution
git mergetool