# Start new feature
git checkout develop
git checkout -b feature/new-feature

# Work on feature
git add .
git commit -m "Implement new feature"

# Finish feature
git checkout develop
git merge --no-ff feature/new-feature
git branch -d feature/new-feature

# Create release
git checkout -b release/1.0.0 develop
# Make release preparations
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Version 1.0.0"
git checkout develop
git merge --no-ff release/1.0.0