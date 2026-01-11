#!/bin/sh
# .git/hooks/pre-commit
# Run tests before commit

echo "Running tests..."
npm test

if [ $? -ne 0 ]; then
    echo "Tests failed. Commit aborted."
    exit 1
fi

echo "All tests passed. Proceeding with commit."
exit 0