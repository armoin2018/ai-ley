# Create branch from current state
git checkout -b new-branch-name

# Or return to a branch
git checkout main

# If you made commits in detached state
git branch temp-branch commit-hash
git checkout main
git merge temp-branch