# Safe Package Operations
dpkg --simulate -i package.deb         # Simulate installation without changes
dpkg -s package-name | grep Status     # Check package installation status
dpkg --list | grep "^ii"               # List only properly installed packages
dpkg --audit | head -20                # Check for broken packages (limit output)

# Backup and Recovery Strategies
dpkg --get-selections > package-selections.txt
debconf-get-selections > debconf-selections.txt
dpkg -l > installed-packages.txt
tar -czf /backup/dpkg-state.tar.gz /var/lib/dpkg/status /var/lib/dpkg/available

# Configuration File Management
dpkg -s package-name | grep "^Conffiles:"  # List configuration files
dpkg --force-confask -i package.deb        # Interactive config file handling
find /etc -name "*.dpkg-*"                 # Find config file backups