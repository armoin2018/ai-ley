# Installation commands
pip install [package]              # Install package
pip install -r requirements.txt    # Install from requirements file
pip install -e .                   # Editable install (development)
pip install --upgrade [package]    # Upgrade package
pip install --user [package]       # Install for current user only

# Package information
pip list                           # List installed packages
pip list --outdated               # Show outdated packages
pip show [package]                 # Show package information
pip show --files [package]         # Show installed files
pip check                          # Check for dependency conflicts

# Package removal
pip uninstall [package]            # Uninstall package
pip uninstall -r requirements.txt  # Uninstall from requirements file
pip uninstall -y [package]         # Auto-confirm uninstall

# Requirements management
pip freeze                         # Show installed packages in requirements format
pip freeze > requirements.txt      # Save requirements to file
pip freeze --local                 # Only show packages in virtual environment

# Cache management
pip cache dir                      # Show cache directory
pip cache info                     # Show cache information
pip cache list                     # List cached packages
pip cache remove [package]         # Remove package from cache
pip cache purge                    # Clear entire cache

# Configuration
pip config list                    # Show configuration
pip config edit                    # Edit configuration file
pip config set global.index-url [url]  # Set configuration value
pip config unset global.index-url      # Remove configuration value

# Debugging and troubleshooting
pip install --verbose [package]    # Verbose output
pip install --dry-run [package]    # Show what would be installed
pip install --no-cache-dir [package]  # Disable cache
pip debug --verbose               # Show debug information