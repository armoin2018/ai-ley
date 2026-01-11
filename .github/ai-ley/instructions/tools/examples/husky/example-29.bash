# Add debugging to hook script
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

set -e  # Exit on any error
set -x  # Print commands as they execute

echo "Starting pre-commit hook..."
npm run lint
echo "Lint completed successfully"

# Test hook manually
./.husky/pre-commit

# Check specific command failures
npm run lint  # Run individual commands to isolate issues