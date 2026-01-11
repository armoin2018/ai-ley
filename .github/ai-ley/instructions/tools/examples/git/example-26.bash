# Save current work temporarily
git stash
git stash push -m "Work in progress on authentication"

# Save including untracked files
git stash -u

# List all stashes
git stash list

# Apply specific stash
git stash apply stash@{2}

# Apply and remove stash
git stash pop

# Show stash contents
git stash show stash@{0}
git stash show -p stash@{0}  # Show full diff

# Drop specific stash
git stash drop stash@{1}

# Clear all stashes
git stash clear