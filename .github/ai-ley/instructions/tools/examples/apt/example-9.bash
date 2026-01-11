# APT log analysis
tail -f /var/log/apt/history.log      # Monitor APT operations
grep "install\|remove\|upgrade" /var/log/dpkg.log  # Package change history

# System maintenance
apt-get check                         # Check for broken dependencies
apt-get -f install                    # Fix broken dependencies
dpkg --configure -a                   # Configure any unpacked packages
apt-get clean                         # Remove downloaded package files
apt-get autoclean                     # Remove obsolete package files
apt-get autoremove                    # Remove orphaned packages

# Security auditing
debsecan                              # Security vulnerability scanner
apt-listbugs list package-name        # Show known bugs for package