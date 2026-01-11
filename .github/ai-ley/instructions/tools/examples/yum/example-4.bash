#!/bin/bash
# Enterprise YUM repository setup script

set -euo pipefail

# Configuration
LOG_FILE="/var/log/yum-setup.log"
BACKUP_DIR="/root/yum-backups"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Backup current configuration
backup_configuration() {
    log "Backing up YUM configuration"
    
    mkdir -p "$BACKUP_DIR"
    cp /etc/yum.conf "$BACKUP_DIR/yum.conf.backup.$(date +%Y%m%d_%H%M%S)"
    cp -r /etc/yum.repos.d "$BACKUP_DIR/repos.d.backup.$(date +%Y%m%d_%H%M%S)"
    
    log "Configuration backup completed"
}

# Configure base repositories
configure_base_repos() {
    log "Configuring base repositories"
    
    # Enable CentOS base repositories
    cat > /etc/yum.repos.d/CentOS-Base.repo << 'EOF'
[base]
name=CentOS-$releasever - Base
baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
priority=1

[updates]
name=CentOS-$releasever - Updates
baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
priority=1

[extras]
name=CentOS-$releasever - Extras
baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
priority=1
EOF
}

# Configure EPEL repository
configure_epel() {
    log "Installing and configuring EPEL repository"
    
    # Install EPEL release package
    yum install -y epel-release
    
    # Configure EPEL with priority
    cat > /etc/yum.repos.d/epel.repo << 'EOF'
[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=https://download.fedoraproject.org/pub/epel/7/$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
priority=10
EOF
    
    log "EPEL repository configured"
}

# Configure YUM settings
configure_yum_settings() {
    log "Configuring YUM settings"
    
    # Backup original configuration
    cp /etc/yum.conf /etc/yum.conf.original
    
    # Configure optimized YUM settings
    cat > /etc/yum.conf << 'EOF'
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache=1
debuglevel=2
logfile=/var/log/yum.log
exactarch=1
obsoletes=1
gpgcheck=1
plugins=1
installonly_limit=3
clean_requirements_on_remove=1
best=1
skip_if_unavailable=1

# Security settings
localpkg_gpgcheck=1
repo_gpgcheck=1

# Performance settings
deltarpm=1
metadata_expire=7d
mirrorlist_expire=86400
timeout=30
retries=10
throttle=0

# Exclude kernel updates (manual control)
exclude=kernel*

# Plugin settings
tsflags=nodocs
EOF
    
    log "YUM configuration completed"
}

# Install essential packages
install_essential_packages() {
    log "Installing essential packages"
    
    # Update package cache
    yum clean all
    yum makecache
    
    # Essential system packages
    ESSENTIAL_PACKAGES=(
        "curl"
        "wget"
        "git"
        "vim"
        "htop"
        "tree"
        "ntp"
        "firewalld"
        "fail2ban"
        "logrotate"
        "rsyslog"
        "crontabs"
        "which"
        "lsof"
        "net-tools"
        "bind-utils"
    )
    
    for package in "${ESSENTIAL_PACKAGES[@]}"; do
        log "Installing $package"
        yum install -y "$package"
    done
    
    log "Essential packages installation completed"
}

# Configure automatic updates
configure_auto_updates() {
    log "Configuring automatic updates"
    
    # Install yum-cron
    yum install -y yum-cron
    
    # Configure yum-cron for security updates only
    cat > /etc/yum/yum-cron.conf << 'EOF'
[commands]
update_cmd = security
update_messages = yes
download_updates = yes
apply_updates = yes
random_sleep = 360

[emitters]
system_name = None
emit_via = email
output_width = 80

[email]
email_from = root@localhost
email_to = admin@example.com
email_host = localhost

[groups]
group_list = None
group_package_types = mandatory, default

[base]
debuglevel = -2
mdpolicy = group:main
skip_broken = True
EOF

    # Configure yum-cron-hourly for metadata updates
    cat > /etc/yum/yum-cron-hourly.conf << 'EOF'
[commands]
update_cmd = default
update_messages = no
download_updates = no
apply_updates = no
random_sleep = 15

[emitters]
system_name = None
emit_via = stdio
output_width = 80

[email]
email_from = root
email_to = root
email_host = localhost

[groups]
group_list = None
group_package_types = mandatory, default

[base]
debuglevel = -2
mdpolicy = group:main
skip_broken = True
EOF

    # Enable and start yum-cron
    systemctl enable yum-cron
    systemctl start yum-cron
    
    log "Automatic updates configuration completed"
}

# Main setup function
main() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
    fi
    
    log "Starting YUM repository setup"
    
    backup_configuration
    configure_base_repos
    configure_epel
    configure_yum_settings
    install_essential_packages
    configure_auto_updates
    
    # Final system update
    yum update -y
    
    log "YUM setup completed successfully"
    echo "YUM repository setup completed. Check $LOG_FILE for details."
}

main "$@"