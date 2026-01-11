# Check RPM version and configuration
rpm --version
rpm --showrc | grep -E "(topdir|buildroot)"

# Query RPM database
rpm -qa | head -10              # List installed packages
rpm -qi bash                    # Package information
rpm -ql bash | head -10         # Package file list

# Verify package signatures
rpm --checksig package.rpm

# Import GPG keys
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-*