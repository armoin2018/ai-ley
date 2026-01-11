# Squash merge (combines all commits into one)
git merge --squash feature-branch
git commit -m "Add complete feature implementation"

# Merge with custom strategy
git merge -X ours feature-branch      # Prefer current branch
git merge -X theirs feature-branch    # Prefer merging branch

# Three-way merge with custom base
git merge-base main feature-branch
git merge --no-commit feature-branch