# Check repository status
git status
git status --short  # Abbreviated output

# Add files to staging area
git add file.txt              # Add specific file
git add .                     # Add all files in current directory
git add *.js                  # Add all JavaScript files
git add -A                    # Add all changes (including deletions)
git add -p                    # Interactive staging

# Commit changes
git commit -m "Add new feature"
git commit -am "Update existing feature"  # Add and commit
git commit --amend -m "Updated commit message"  # Amend last commit

# View commit history
git log
git log --oneline            # Compact view
git log --graph              # Show branch graph
git log --author="John"      # Filter by author
git log --since="2 weeks ago"  # Filter by date
git log file.txt             # History of specific file

# Show differences
git diff                     # Working directory vs staging
git diff --staged            # Staging vs last commit
git diff HEAD~1              # Compare with previous commit
git diff branch1..branch2    # Compare branches