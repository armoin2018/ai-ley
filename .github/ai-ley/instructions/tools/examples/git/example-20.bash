# Essential daily commands
git status                        # Check repository status
git add .                         # Stage all changes
git commit -m "message"           # Commit with message
git pull                          # Pull latest changes
git push                          # Push local changes
git log --oneline                 # View commit history

# Branch management
git branch                        # List local branches
git checkout -b branch-name       # Create and switch to branch
git merge branch-name             # Merge branch into current
git branch -d branch-name         # Delete merged branch

# Remote operations
git remote -v                     # List remote repositories
git fetch origin                  # Fetch from remote
git push origin branch-name       # Push branch to remote

# History and information
git log                           # Detailed commit history
git log --graph --oneline         # Visual branch history
git show commit-hash              # Show specific commit details
git diff                          # Show unstaged changes
git diff --staged                 # Show staged changes

# Advanced operations
git stash                         # Temporarily save changes
git stash pop                     # Apply stashed changes
git reset HEAD~1                  # Undo last commit (keep changes)
git reset --hard HEAD~1           # Undo last commit (discard changes)
git revert commit-hash            # Create commit that undoes changes

# Troubleshooting commands
git reflog                        # View reference logs
git fsck                          # Check repository integrity
git gc                            # Garbage collection and optimization
git clean -fd                     # Remove untracked files and directories