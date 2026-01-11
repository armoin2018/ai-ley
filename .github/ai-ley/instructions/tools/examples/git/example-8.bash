# Create hotfix from main
git checkout main
git checkout -b hotfix/critical-bug

# Fix the bug
git add .
git commit -m "Fix critical security issue"

# Merge to main and develop
git checkout main
git merge --no-ff hotfix/critical-bug
git tag -a v1.0.1 -m "Hotfix 1.0.1"

git checkout develop
git merge --no-ff hotfix/critical-bug
git branch -d hotfix/critical-bug