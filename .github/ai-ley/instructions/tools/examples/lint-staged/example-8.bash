# Only runs on staged files
git add src/component.js src/styles.css
npx lint-staged  # Only processes these 2 files

# Compared to full project processing
eslint src/         # Processes all files in src/
prettier --write src/**/*  # Processes all files