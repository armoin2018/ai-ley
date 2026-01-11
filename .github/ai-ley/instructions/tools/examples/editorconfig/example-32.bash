# Validate EditorConfig file syntax
editorconfig-checker --version
editorconfig-checker .editorconfig

# Test specific files
editorconfig-checker src/component.js

# Verbose output
editorconfig-checker --verbose .

# Check what rules apply to specific files
editorconfig-tools query src/component.js