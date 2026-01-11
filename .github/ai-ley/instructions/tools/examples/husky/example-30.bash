# Use lint-staged for file-specific operations
npm install lint-staged --save-dev

# Optimize hook to run only necessary checks
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Time the hook execution
start_time=$(date +%s)

# Use lint-staged instead of full project linting
npx lint-staged

# Skip heavy operations in pre-commit, move to pre-push
# npm run test  # Move to pre-push hook

end_time=$(date +%s)
echo "Hook execution time: $((end_time - start_time)) seconds"