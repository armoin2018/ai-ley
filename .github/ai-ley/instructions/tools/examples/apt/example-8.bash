# Package analysis and management tools
apt list --installed                    # List all installed packages
apt list --upgradable                  # Show packages with available updates
apt search "pattern"                   # Search for packages
apt show package-name                  # Show detailed package information
apt depends package-name               # Show package dependencies
apt rdepends package-name              # Show reverse dependencies

# Advanced package management
aptitude                               # Interactive package manager
apt-file search filename              # Find which package provides a file
deborphan                             # Find orphaned packages
debsums                               # Verify package file checksums
apt-listchanges                       # Show changelog for package updates

# Repository management
add-apt-repository ppa:user/ppa-name  # Add PPA repository
apt-cache policy package-name         # Show package policy and pinning
apt-cache madison package-name        # Show available package versions