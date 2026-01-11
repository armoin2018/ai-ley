# GPG signature verification
rpm --checksig package.rpm          # Check package signature
rpm --import key.asc                # Import GPG key
rpm -q --qf "%{SIGPGP:pgpsig}\n" package  # Show signature info

# Package integrity
rpm -Va                             # Verify all packages
rpm -V package-name                 # Verify specific package
rpm -Vf /path/to/file              # Verify file's package
rpm --verify --nodeps package-name # Verify without dependency check

# Database operations
rpm --rebuilddb                     # Rebuild RPM database
rpm --initdb                       # Initialize RPM database
rpmdb_verify /var/lib/rpm/Packages # Verify database integrity