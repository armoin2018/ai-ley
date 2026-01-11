# Create basic configuration
echo '{}' > .prettierrc.json

# Create ignore file
echo 'node_modules/
dist/
build/
coverage/' > .prettierignore

# Add npm scripts
npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.format:check="prettier --check ."