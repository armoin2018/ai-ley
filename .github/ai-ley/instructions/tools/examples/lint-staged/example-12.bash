# Essential daily commands
npx lint-staged                      # Run on staged files
npx lint-staged --debug              # Debug mode with verbose output
npx lint-staged --verbose            # Verbose output
npx lint-staged --dry-run            # Preview what would run

# Configuration and testing
npx lint-staged --config=.lintstagedrc.json  # Use specific config
npx lint-staged --allow-empty         # Allow execution with no staged files
npx lint-staged --no-stash            # Don't stash unstaged changes

# Advanced operations
npx lint-staged --shell               # Use shell for command execution
npx lint-staged --quiet               # Minimal output
npx lint-staged --concurrent false    # Disable concurrent execution

# Integration commands
git add file.js && npx lint-staged    # Manual staging and processing
husky add .husky/pre-commit "npx lint-staged"  # Husky integration