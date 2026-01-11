# .husky/pre-commit - Cross-platform script
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Works on all platforms
npm run lint
npm run test