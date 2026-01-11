# Core PECL Commands
pecl help                               # Show all available commands
pecl list-all                          # List all available packages
pecl search keyword                     # Search for packages
pecl remote-list                        # List packages from remote server
pecl download package                   # Download package without installing

# Package Information
pecl info package                       # Show package information
pecl list-files package                 # List files in installed package
pecl deps package                       # Show package dependencies
pecl list-upgrades                      # Show available upgrades

# Configuration Management
pecl config-get setting                 # Get configuration setting
pecl config-set setting value           # Set configuration setting
pecl config-show                        # Show all configuration settings

# Channel Management
pecl channel-discover channel.url       # Add new package channel
pecl channel-info channel               # Show channel information
pecl channel-delete channel             # Remove channel
pecl update-channels                    # Update all channels