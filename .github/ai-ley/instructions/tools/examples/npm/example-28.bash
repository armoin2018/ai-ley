# Enable verbose logging
npm install --loglevel verbose
npm --verbose install

# Debug npm operations
npm config set loglevel verbose
npm config set progress true

# Check npm configuration
npm config list
npm config list -l              # Show all settings
npm doctor                      # Diagnose npm setup