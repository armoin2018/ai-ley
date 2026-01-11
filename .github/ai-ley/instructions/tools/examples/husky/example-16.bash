# Essential daily commands
npx husky init                        # Initialize Husky in project
npx husky add .husky/pre-commit "npm test"  # Add pre-commit hook
npx husky --help                      # Get command help

# Hook management
chmod +x .husky/pre-commit           # Make hook executable
rm .husky/pre-commit                 # Remove hook
ls -la .husky/                       # List all hooks

# Testing and debugging
git commit -m "test" --dry-run       # Test commit without executing
git commit --no-verify -m "bypass"  # Bypass hooks for one commit
HUSKY_DEBUG=1 git commit -m "debug"  # Debug hook execution

# Advanced operations
npx husky uninstall                  # Uninstall Husky hooks
git config core.hooksPath .husky    # Verify hooks path
git config --unset core.hooksPath   # Reset hooks path