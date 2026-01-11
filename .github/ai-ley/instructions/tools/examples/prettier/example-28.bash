# Check for config file existence
ls -la .prettierrc* prettier.config.*

# Create basic configuration
echo '{"semi": true, "singleQuote": true}' > .prettierrc.json

# Verify configuration is loaded
prettier --find-config-path src/component.js