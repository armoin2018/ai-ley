# Remove sensitive data from history
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch secrets.txt' \
  --prune-empty --tag-name-filter cat -- --all

# Modern alternative using git-filter-repo
git filter-repo --path secrets.txt --invert-paths

# Prevent future accidents
echo "secrets.txt" >> .gitignore
git add .gitignore
git commit -m "Add secrets.txt to gitignore"