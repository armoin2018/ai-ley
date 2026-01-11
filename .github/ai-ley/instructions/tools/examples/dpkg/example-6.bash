# Database Performance Tuning
dpkg --configure --pending              # Clear pending configurations
dpkg --audit | grep "^Package" | wc -l  # Count broken packages
du -sh /var/lib/dpkg/                   # Check database size

# Cleanup and Maintenance
dpkg --remove --dry-run package-name    # Preview removal effects
dpkg --purge $(dpkg -l | grep "^rc" | awk '{print $2}')  # Remove orphaned configs
apt-get autoclean && apt-get autoremove # Clean package cache