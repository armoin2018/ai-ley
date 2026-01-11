# Check if files are actually staged
git status --porcelain

# Stage files manually
git add file.js

# Check lint-staged configuration
npx lint-staged --debug

# Verify file patterns match staged files
npx lint-staged --dry-run --verbose