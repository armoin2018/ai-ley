#!/bin/bash
# Comprehensive package management script

set -euo pipefail

# Configuration
LOG_FILE="/var/log/package-management.log"
BACKUP_DIR="/var/backups/package-lists"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup current package state
backup_package_state() {
    log "Creating package state backup"
    
    # Backup installed packages list
    dpkg --get-selections > "$BACKUP_DIR/installed-packages-$(date +%Y%m%d_%H%M%S).txt"
    
    # Backup APT sources
    cp -r /etc/apt/sources.list* "$BACKUP_DIR/"
    
    # Backup APT preferences
    if [ -d /etc/apt/preferences.d ]; then
        cp -r /etc/apt/preferences.d "$BACKUP_DIR/"
    fi
    
    log "Package state backup completed"
}

# Verify repository signatures
verify_repositories() {
    log "Verifying repository signatures"
    
    # Check for repositories without GPG verification
    if grep -r "trusted=yes" /etc/apt/sources.list*; then
        log "WARNING: Found repositories with disabled signature verification"
    fi
    
    # Update package cache with signature verification
    if ! apt-get update; then
        log "ERROR: Failed to update package cache"
        exit 1
    fi
    
    log "Repository verification completed"
}

# Intelligent package upgrade
upgrade_packages() {
    log "Starting package upgrade process"
    
    # Show packages that will be upgraded
    apt list --upgradable
    
    # Perform upgrade with error handling
    if apt-get upgrade -y; then
        log "Package upgrade completed successfully"
    else
        log "ERROR: Package upgrade failed"
        exit 1
    fi
    
    # Clean up obsolete packages
    apt-get autoremove -y
    apt-get autoclean
    
    log "Package cleanup completed"
}

# Security updates
apply_security_updates() {
    log "Applying security updates"
    
    # Install unattended-upgrades if not present
    if ! dpkg -l | grep -q unattended-upgrades; then
        apt-get install -y unattended-upgrades
    fi
    
    # Configure automatic security updates
    cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Download-Upgradeable-Packages "1";
EOF

    # Configure unattended-upgrades
    cat > /etc/apt/apt.conf.d/50unattended-upgrades << EOF
Unattended-Upgrade::Allowed-Origins {
    "\${distro_id}:\${distro_codename}-security";
    "\${distro_id}ESMApps:\${distro_codename}-apps-security";
    "\${distro_id}ESM:\${distro_codename}-infra-security";
};

Unattended-Upgrade::DevRelease "false";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Remove-New-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "false";
Unattended-Upgrade::Automatic-Reboot-Time "02:00";
Unattended-Upgrade::Mail "admin@example.com";
Unattended-Upgrade::MailOnlyOnError "true";
EOF

    log "Security update configuration completed"
}

# Main execution
main() {
    log "Starting package management maintenance"
    
    backup_package_state
    verify_repositories
    upgrade_packages
    apply_security_updates
    
    log "Package management maintenance completed successfully"
}

# Run main function
main "$@"