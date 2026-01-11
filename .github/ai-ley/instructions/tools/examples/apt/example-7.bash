#!/bin/bash
# Server hardening script with package management

set -euo pipefail

# Minimal package set for server
ESSENTIAL_PACKAGES=(
    "curl"
    "wget"
    "gnupg"
    "ca-certificates"
    "apt-transport-https"
    "software-properties-common"
    "unattended-upgrades"
    "fail2ban"
    "ufw"
    "logrotate"
    "rsyslog"
)

# Remove unnecessary packages
remove_unnecessary_packages() {
    echo "Removing unnecessary packages..."
    
    # Packages commonly not needed on servers
    REMOVE_PACKAGES=(
        "snapd"
        "popularity-contest"
        "command-not-found"
        "friendly-recovery"
        "laptop-detect"
        "wireless-tools"
        "wpasupplicant"
    )
    
    for package in "${REMOVE_PACKAGES[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            echo "Removing $package..."
            apt-get remove --purge -y "$package"
        fi
    done
    
    apt-get autoremove -y
}

# Configure automatic security updates
configure_auto_updates() {
    echo "Configuring automatic security updates..."
    
    # Enable unattended upgrades
    cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

    # Configure security-only updates
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
Unattended-Upgrade::Automatic-Reboot-WithUsers "false";
Unattended-Upgrade::Automatic-Reboot-Time "02:00";
Unattended-Upgrade::InstallOnShutdown "false";
Unattended-Upgrade::Mail "admin@example.com";
Unattended-Upgrade::MailOnlyOnError "true";
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Skip-Updates-On-Metered-Connections "true";
Unattended-Upgrade::Verbose "false";
Unattended-Upgrade::Debug "false";
EOF

    # Test configuration
    unattended-upgrade --dry-run --debug
}

# Lock down package management
lock_down_packages() {
    echo "Implementing package management security..."
    
    # Disable source packages
    sed -i 's/^deb-src/#deb-src/g' /etc/apt/sources.list
    
    # Configure APT to use only HTTPS
    cat > /etc/apt/apt.conf.d/99security << EOF
APT::Get::AllowUnauthenticated "false";
APT::Get::AllowInsecureRepositories "false";
APT::Get::AllowDowngradeToInsecureRepositories "false";
Acquire::AllowInsecureRepositories "false";
Acquire::AllowDowngradeToInsecureRepositories "false";
EOF

    # Set up package verification
    cat > /etc/apt/apt.conf.d/99verify << EOF
APT::Get::Always-Include-Phased-Updates "false";
DPkg::Lock::Timeout "60";
EOF
}

# Main hardening function
main() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
    fi
    
    echo "Starting server hardening with package management..."
    
    # Update system first
    apt-get update
    apt-get upgrade -y
    
    # Install essential packages
    apt-get install -y "${ESSENTIAL_PACKAGES[@]}"
    
    # Remove unnecessary packages
    remove_unnecessary_packages
    
    # Configure security
    configure_auto_updates
    lock_down_packages
    
    # Final cleanup
    apt-get autoremove -y
    apt-get autoclean
    
    echo "Server hardening completed successfully!"
    echo "Automatic security updates have been configured."
}

main "$@"