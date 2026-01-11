# Undo last commit but keep changes
git reset HEAD~1

# Undo last commit and discard changes
git reset --hard HEAD~1

# Undo staging
git reset HEAD file.js

# Discard local changes
git checkout -- file.js
git restore file.js  # Modern syntax

# Revert commit (creates new commit)
git revert commit-hash