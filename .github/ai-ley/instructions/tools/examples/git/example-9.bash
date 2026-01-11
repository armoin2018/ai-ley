# Apply specific commit to current branch
git cherry-pick abc123
git cherry-pick --no-commit abc123  # Don't auto-commit
git cherry-pick -x abc123           # Add cherry-pick note

# Cherry-pick range of commits
git cherry-pick abc123..def456