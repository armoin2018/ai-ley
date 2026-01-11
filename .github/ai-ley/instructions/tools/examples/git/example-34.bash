# Update local repository
git fetch origin

# Check what will be merged
git log HEAD..origin/main

# Pull with rebase to maintain clean history
git pull --rebase origin main

# Force push with safety (only if certain)
git push --force-with-lease origin main

# Reset to match remote exactly
git reset --hard origin/main