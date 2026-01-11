# Package Security Verification
apt-key list                            # List trusted package signing keys
dpkg-sig --verify package.deb           # Verify package signature
debsums -c                              # Check all package file checksums
dpkg --verify | grep "^.5"              # Find files with changed checksums

# Secure Package Installation
dpkg --force-confask -i package.deb     # Interactive configuration handling
dpkg --no-triggers -i package.deb       # Install without running triggers
systemd-run --scope dpkg -i package.deb # Install in isolated scope

# Package Provenance Tracking
cat > /etc/dpkg/dpkg.cfg.d/01_admin_logging << 'EOF'
log /var/log/dpkg.log
status-fd 3
EOF