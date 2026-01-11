# List installed packages
pip list                               # All packages
pip list --outdated                    # Show outdated packages
pip list --uptodate                    # Show up-to-date packages
pip list --user                        # User-installed packages
pip list --format=freeze              # Requirements format

# Show package information
pip show requests                      # Package details
pip show -v requests                   # Verbose package info
pip show --files requests             # Show installed files

# Update packages
pip install --upgrade requests         # Upgrade specific package
pip install -U requests               # Short form
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U  # Upgrade all

# Remove packages
pip uninstall requests                 # Remove package
pip uninstall -r requirements.txt     # Remove packages from file
pip uninstall -y requests             # Auto-confirm removal

# Check dependencies
pip check                              # Check for dependency conflicts
pip show --dependencies requests       # Show package dependencies

# Generate requirements
pip freeze                             # All installed packages
pip freeze > requirements.txt         # Save to file
pip freeze --local                     # Only packages in virtual env
pip freeze | grep -v "^-e"            # Exclude editable packages