# List branches
git branch                   # Local branches
git branch -r                # Remote branches
git branch -a                # All branches

# Create and switch branches
git branch feature-login     # Create branch
git checkout feature-login   # Switch to branch
git checkout -b feature-user # Create and switch
git switch feature-login     # Modern way to switch
git switch -c feature-new    # Create and switch (new syntax)

# Merge branches
git checkout main
git merge feature-login      # Merge feature into main
git merge --no-ff feature-login  # Create merge commit
git merge --squash feature-login # Squash merge

# Rebase branches
git rebase main              # Rebase current branch onto main
git rebase -i HEAD~3         # Interactive rebase last 3 commits
git rebase --abort           # Abort ongoing rebase
git rebase --continue        # Continue after resolving conflicts

# Delete branches
git branch -d feature-login  # Delete merged branch
git branch -D feature-login  # Force delete branch
git push origin --delete feature-login  # Delete remote branch