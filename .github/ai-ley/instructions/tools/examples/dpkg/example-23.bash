# Advanced package building workflow
mkdir -p my-package/{DEBIAN,usr/bin,etc/systemd/system}

# Create comprehensive control file
cat > my-package/DEBIAN/control << 'EOF'
Package: my-enterprise-app
Version: 2.1.0-1
Section: utils
Priority: optional
Architecture: amd64
Depends: python3 (>= 3.8), systemd, logrotate
Recommends: postgresql-client
Suggests: redis-tools
Conflicts: old-enterprise-app
Replaces: old-enterprise-app
Provides: enterprise-app
Maintainer: DevOps Team <devops@company.com>
Description: Enterprise Application Suite
 Comprehensive business application providing:
 .
 * Customer relationship management
 * Inventory tracking and management
 * Financial reporting and analytics
 * Real-time dashboard monitoring
EOF

# Advanced post-installation script
cat > my-package/DEBIAN/postinst << 'EOF'
#!/bin/bash
set -e

case "$1" in
    configure)
        # Create application user
        if ! getent passwd enterprise-app >/dev/null; then
            useradd --system --home /opt/enterprise-app --shell /bin/false enterprise-app
        fi
        
        # Set up directories and permissions
        mkdir -p /var/log/enterprise-app /var/lib/enterprise-app
        chown enterprise-app:enterprise-app /var/log/enterprise-app /var/lib/enterprise-app
        chmod 750 /var/log/enterprise-app /var/lib/enterprise-app
        
        # Configure systemd service
        systemctl daemon-reload
        systemctl enable enterprise-app.service
        
        # Initialize database if needed
        if command -v postgresql >/dev/null; then
            sudo -u enterprise-app /opt/enterprise-app/bin/init-db.sh
        fi
        
        # Start service
        systemctl start enterprise-app.service
        ;;
esac

exit 0
EOF

chmod 755 my-package/DEBIAN/postinst
dpkg-deb --build my-package