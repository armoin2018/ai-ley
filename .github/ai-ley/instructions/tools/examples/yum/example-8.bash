# Package analysis and management tools
yum list installed                     # List all installed packages
yum list available                     # List available packages
yum search "pattern"                   # Search for packages
yum info package-name                  # Show detailed package information
yum deplist package-name               # Show package dependencies
yum history                           # Show YUM transaction history
yum history info ID                   # Show details of specific transaction

# Repository management
yum repolist                          # List enabled repositories
yum repolist all                      # List all repositories
yum-config-manager --enable repo-id   # Enable repository
yum-config-manager --disable repo-id  # Disable repository
yum clean all                         # Clean all caches
yum makecache                         # Build metadata cache

# Package groups
yum grouplist                         # List package groups
yum groupinfo "Group Name"            # Show group information
yum groupinstall "Group Name"         # Install package group
yum groupremove "Group Name"          # Remove package group