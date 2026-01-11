# .husky/pre-commit - Basic pre-commit hook
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run lint
npm run format:check
npm run test