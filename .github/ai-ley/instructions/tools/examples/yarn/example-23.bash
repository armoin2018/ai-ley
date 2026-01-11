# Delete lock file and reinstall
rm yarn.lock
yarn install

# Or use git merge tools
git checkout --theirs yarn.lock
yarn install