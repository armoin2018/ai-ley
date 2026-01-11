# Create .editorconfig in project root
touch .editorconfig

# Alternative: create in subdirectories for specific rules
mkdir -p src/frontend
touch src/frontend/.editorconfig

# Verify file placement
find . -name ".editorconfig" -type f