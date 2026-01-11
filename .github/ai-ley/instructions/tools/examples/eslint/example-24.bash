# Check for config file existence
ls -la eslint.config.js .eslintrc.*

# Initialize configuration if missing
npx eslint --init

# Specify config explicitly
eslint --config ./path/to/config.js src/