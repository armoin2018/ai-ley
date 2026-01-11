# Package Database Management
dpkg --audit                           # Check for broken package installations
dpkg --pending                         # Process pending package operations
dpkg --triggers-only                   # Process only package triggers
dpkg --verify package-name             # Verify package file integrity

# Advanced Configuration Management
dpkg-reconfigure package-name          # Reconfigure package interactively
dpkg-divert --add --rename file-path   # Divert file to alternative location
dpkg-divert --remove file-path         # Remove file diversion
dpkg-statoverride --add user group mode file  # Override file permissions

# Package Selection and Holds
dpkg --get-selections | grep hold      # List packages on hold
echo "package-name hold" | dpkg --set-selections  # Put package on hold
echo "package-name install" | dpkg --set-selections  # Remove hold

# System Recovery and Maintenance
dpkg --force-depends -i package.deb    # Force installation ignoring dependencies
dpkg --force-confnew -i package.deb    # Use new config files during upgrade
dpkg --force-confold -i package.deb    # Keep old config files during upgrade