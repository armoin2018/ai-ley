# Interactive rebase for cleaning up commit history
git rebase -i HEAD~3

# Rebase onto another branch
git rebase main feature-branch

# Abort rebase if things go wrong
git rebase --abort

# Continue rebase after resolving conflicts
git rebase --continue

# Example interactive rebase commands:
# pick = use commit
# reword = use commit, but edit the commit message
# edit = use commit, but stop for amending
# squash = use commit, but meld into previous commit
# fixup = like squash, but discard commit message
# drop = remove commit