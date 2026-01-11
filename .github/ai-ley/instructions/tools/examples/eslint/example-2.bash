# Initialize ESLint in existing project (interactive setup)
npx eslint --init

# Quick setup with recommended configuration
npm init @eslint/config

# Manual configuration creation
touch eslint.config.js  # Flat config (ESLint 9.0+)
# or
touch .eslintrc.json    # Legacy config format