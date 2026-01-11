# Essential file operations
touch .editorconfig                   # Create EditorConfig file
cp .editorconfig backup/.editorconfig # Backup configuration
find . -name ".editorconfig"          # Find all EditorConfig files

# Validation and testing
editorconfig-checker .                # Check files against EditorConfig
editorconfig-tools check .            # Validate EditorConfig syntax
editorconfig-tools format .           # Auto-format files

# Integration commands
git add .editorconfig                 # Add to version control
git commit -m "Add EditorConfig"      # Commit configuration
echo ".editorconfig" >> .gitignore    # Exclude from tracking (not recommended)

# Editor integration verification
code .editorconfig                    # Edit in VS Code
vim .editorconfig                     # Edit in Vim