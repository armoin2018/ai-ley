# Manage remotes
git remote -v                # List remotes
git remote add origin https://github.com/user/repo.git
git remote remove origin     # Remove remote
git remote rename origin upstream  # Rename remote

# Fetch and pull
git fetch origin             # Download objects from remote
git fetch --all              # Fetch from all remotes
git pull origin main         # Fetch and merge
git pull --rebase origin main  # Fetch and rebase

# Push changes
git push origin main         # Push to remote branch
git push -u origin feature   # Push and set upstream
git push --force-with-lease  # Safer force push
git push --tags              # Push tags

# Track remote branches
git checkout -b local-branch origin/remote-branch
git branch --set-upstream-to=origin/main main