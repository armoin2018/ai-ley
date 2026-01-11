# Package Installation and Management
dpkg -i package.deb                     # Install package from .deb file
dpkg -r package-name                    # Remove package (keep config files)
dpkg --purge package-name               # Remove package and config files
dpkg --configure package-name           # Configure partially installed package
dpkg --configure -a                     # Configure all unconfigured packages

# Package Information and Queries
dpkg -l                                 # List all installed packages
dpkg -l package-pattern                 # List packages matching pattern
dpkg -s package-name                    # Show package status and information
dpkg -L package-name                    # List files owned by package
dpkg -S file-path                       # Find package owning specific file

# Package File Analysis
dpkg -c package.deb                     # List contents of .deb package
dpkg -I package.deb                     # Show package information from .deb
dpkg -e package.deb directory           # Extract control information
dpkg -x package.deb directory           # Extract package contents

# Advanced Package Management
dpkg --get-selections                   # Export package selection list
dpkg --set-selections < selection-file  # Import package selection list
dpkg --clear-selections                 # Clear all package selections
dpkg --yet-to-unpack                   # Show packages not yet unpacked