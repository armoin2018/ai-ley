# .husky/commit-msg - Enforce conventional commits
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx commitlint --edit "$1"