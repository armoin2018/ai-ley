# Package Building Tools
dpkg-buildpackage -us -uc              # Build package from source directory
dpkg-source -b source-directory        # Build source package
dpkg-gencontrol                        # Generate package control file
dpkg-genchanges                        # Generate changes file for upload

# Control File Structure
cat > DEBIAN/control << 'EOF'
Package: my-application
Version: 1.0.0
Section: utils
Priority: optional
Architecture: amd64
Depends: libc6 (>= 2.3), python3 (>= 3.6)
Maintainer: Developer <dev@example.com>
Description: My Custom Application
 Detailed description of the application
 functionality and features.
EOF

# Post-installation Scripts
cat > DEBIAN/postinst << 'EOF'
#!/bin/bash
set -e
case "$1" in
    configure)
        # Configuration steps after installation
        systemctl enable my-service
        systemctl start my-service
        ;;
    abort-upgrade|abort-remove|abort-deconfigure)
        ;;
    *)
        echo "postinst called with unknown argument \`$1'" >&2
        exit 1
        ;;
esac
exit 0
EOF
chmod 755 DEBIAN/postinst