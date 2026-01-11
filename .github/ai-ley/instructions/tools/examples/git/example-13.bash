# Repository setup
git init                     # Initialize repository
git clone <url>              # Clone repository

# Basic operations
git status                   # Check status
git add <file>               # Stage changes
git commit -m "message"      # Commit changes
git push                     # Push to remote
git pull                     # Pull from remote

# Branching
git branch                   # List branches
git checkout <branch>        # Switch branch
git merge <branch>           # Merge branch

# History and information
git log                      # View commit history
git show <commit>            # Show commit details
git diff                     # Show differences

# Undoing changes
git reset --hard HEAD        # Reset to last commit
git revert <commit>          # Revert specific commit
git checkout -- <file>      # Discard changes to file