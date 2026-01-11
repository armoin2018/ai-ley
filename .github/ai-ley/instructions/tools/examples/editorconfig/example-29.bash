# Check tool configurations for compatibility
cat .prettierrc.json
cat .editorconfig

# Align configurations
# Example: Make sure indent_size matches Prettier tabWidth
# Example: Ensure end_of_line matches Prettier endOfLine

# Use .editorconfig-ignore for problematic files
echo "generated/**" >> .editorconfig-ignore