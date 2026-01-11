#!/bin/bash
# Production server setup with YUM

set -euo pipefail

# Configuration
SERVER_TYPE="${1:-web}"
ENVIRONMENT="${2:-production}"
LOG_FILE="/var/log/server-setup.log"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# System hardening
harden_system() {
    log "Hardening system configuration"
    
    # Remove unnecessary packages
    yum remove -y \
        sendmail \
        postfix \
        telnet \
        rsh \
        rlogin
    
    # Install security packages
    yum install -y \
        fail2ban \
        aide \
        rkhunter \
        chkrootkit \
        clamav \
        clamav-update
    
    # Configure firewall
    systemctl enable firewalld
    systemctl start firewalld
    
    # Set SELinux to enforcing
    setenforce 1
    sed -i 's/SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
    
    log "System hardening completed"
}

# Install based on server type
install_server_packages() {
    local server_type="$1"
    
    log "Installing packages for $server_type server"
    
    case "$server_type" in
        "web")
            yum groupinstall -y "Web Server"
            yum install -y \
                nginx \
                php \
                php-fpm \
                php-mysql \
                php-gd \
                php-xml \
                mariadb-server \
                redis \
                certbot \
                python2-certbot-nginx
            ;;
        "database")
            yum install -y \
                mariadb-server \
                mariadb \
                mysql-utilities \
                percona-xtrabackup \
                redis \
                memcached
            ;;
        "application")
            yum groupinstall -y "Development Tools"
            yum install -y \
                python3 \
                python3-pip \
                nodejs \
                npm \
                java-11-openjdk \
                supervisor \
                nginx
            ;;
        *)
            log "Unknown server type: $server_type"
            exit 1
            ;;
    esac
    
    log "Package installation for $server_type completed"
}

# Configure monitoring
setup_monitoring() {
    log "Setting up monitoring"
    
    yum install -y \
        collectd \
        htop \
        iotop \
        sysstat \
        logwatch
    
    # Configure collectd
    systemctl enable collectd
    systemctl start collectd
    
    # Configure log rotation
    cat > /etc/logrotate.d/application << 'EOF'
/var/log/application/*.log {
    daily
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    create 644 nginx nginx
    postrotate
        systemctl reload nginx > /dev/null 2>&1 || true
    endscript
}
EOF
    
    log "Monitoring setup completed"
}

# Configure automatic updates
configure_updates() {
    log "Configuring automatic security updates"
    
    yum install -y yum-cron
    
    # Configure for security updates only in production
    if [[ "$ENVIRONMENT" == "production" ]]; then
        sed -i 's/update_cmd = default/update_cmd = security/' /etc/yum/yum-cron.conf
        sed -i 's/apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
    fi
    
    systemctl enable yum-cron
    systemctl start yum-cron
    
    log "Automatic updates configured"
}

# Main setup
main() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
    fi
    
    log "Starting server setup: Type=$SERVER_TYPE, Environment=$ENVIRONMENT"
    
    # Update system
    yum update -y
    
    # Install EPEL
    yum install -y epel-release
    
    # Setup components
    harden_system
    install_server_packages "$SERVER_TYPE"
    setup_monitoring
    configure_updates
    
    # Final cleanup
    yum clean all
    
    log "Server setup completed successfully"
    echo "Setup completed. Server type: $SERVER_TYPE, Environment: $ENVIRONMENT"
    echo "Check $LOG_FILE for detailed logs."
}

main "$@"