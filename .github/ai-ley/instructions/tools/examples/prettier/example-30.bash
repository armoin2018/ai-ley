# Use .prettierignore to exclude large files
echo 'node_modules/
dist/
*.min.js
coverage/' > .prettierignore

# Format only specific files
prettier --write "src/**/*.{js,ts}" --ignore-path .gitignore

# Use lint-staged for incremental formatting