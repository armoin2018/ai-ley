#!/bin/bash
# Local YUM repository mirror setup

set -euo pipefail

# Configuration
MIRROR_ROOT="/var/www/html/repos"
SYNC_LOG="/var/log/repo-sync.log"
REPOS_TO_MIRROR=("base" "updates" "extras" "epel")

# Create directory structure
setup_directories() {
    echo "Setting up directory structure"
    
    mkdir -p "$MIRROR_ROOT"
    mkdir -p /var/log/repo-sync
    
    # Install required packages
    yum install -y \
        createrepo \
        reposync \
        httpd \
        yum-utils
    
    # Configure Apache
    systemctl enable httpd
    systemctl start httpd
    
    # Configure firewall
    firewall-cmd --permanent --add-service=http
    firewall-cmd --reload
}

# Sync repositories
sync_repositories() {
    echo "Syncing repositories"
    
    for repo in "${REPOS_TO_MIRROR[@]}"; do
        echo "Syncing $repo repository..."
        
        # Create repo directory
        mkdir -p "$MIRROR_ROOT/$repo"
        
        # Sync repository
        reposync \
            --repoid="$repo" \
            --download_path="$MIRROR_ROOT" \
            --downloadcomps \
            --download-metadata \
            --newest-only \
            2>&1 | tee -a "$SYNC_LOG"
        
        # Create repository metadata
        createrepo \
            --database \
            --update \
            --skip-stat \
            "$MIRROR_ROOT/$repo" \
            2>&1 | tee -a "$SYNC_LOG"
        
        echo "$repo repository sync completed"
    done
}

# Create client configuration
create_client_config() {
    local mirror_server="$1"
    
    echo "Creating client configuration for mirror server: $mirror_server"
    
    cat > /etc/yum.repos.d/local-mirror.repo << EOF
[local-base]
name=Local Mirror - Base
baseurl=http://$mirror_server/repos/base
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
priority=1

[local-updates]
name=Local Mirror - Updates
baseurl=http://$mirror_server/repos/updates
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
priority=1

[local-extras]
name=Local Mirror - Extras
baseurl=http://$mirror_server/repos/extras
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
priority=1

[local-epel]
name=Local Mirror - EPEL
baseurl=http://$mirror_server/repos/epel
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
enabled=1
priority=10
EOF
    
    echo "Client configuration created: /etc/yum.repos.d/local-mirror.repo"
}

# Setup sync cron job
setup_sync_cron() {
    echo "Setting up automatic sync cron job"
    
    cat > /etc/cron.d/repo-sync << 'EOF'
# Sync repositories daily at 2 AM
0 2 * * * root /usr/local/bin/repo-sync.sh >/dev/null 2>&1
EOF
    
    # Create sync script
    cat > /usr/local/bin/repo-sync.sh << 'EOF'
#!/bin/bash
# Automated repository sync script

MIRROR_ROOT="/var/www/html/repos"
REPOS=("base" "updates" "extras" "epel")
LOG_FILE="/var/log/repo-sync/daily-$(date +%Y%m%d).log"

for repo in "${REPOS[@]}"; do
    echo "[$(date)] Syncing $repo..." >> "$LOG_FILE"
    
    reposync \
        --repoid="$repo" \
        --download_path="$MIRROR_ROOT" \
        --newest-only \
        --delete \
        >> "$LOG_FILE" 2>&1
    
    createrepo --update "$MIRROR_ROOT/$repo" >> "$LOG_FILE" 2>&1
    
    echo "[$(date)] $repo sync completed" >> "$LOG_FILE"
done

# Clean old logs (keep 30 days)
find /var/log/repo-sync -name "daily-*.log" -mtime +30 -delete
EOF
    
    chmod +x /usr/local/bin/repo-sync.sh
    
    echo "Sync cron job configured"
}

# Main execution
main() {
    local mirror_server="${1:-localhost}"
    
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
    fi
    
    echo "Setting up local YUM repository mirror"
    echo "Mirror server: $mirror_server"
    
    setup_directories
    sync_repositories
    create_client_config "$mirror_server"
    setup_sync_cron
    
    echo "Local repository mirror setup completed"
    echo "Repository URL: http://$mirror_server/repos/"
    echo "Client configuration: /etc/yum.repos.d/local-mirror.repo"
    echo "Sync logs: $SYNC_LOG"
}

main "$@"