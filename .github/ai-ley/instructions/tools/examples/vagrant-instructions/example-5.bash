#!/bin/bash
# scripts/security-hardening.sh - Enterprise security baseline

set -euo pipefail

# Configuration
LOG_FILE="/var/log/enterprise-hardening.log"
COMPLIANCE_FRAMEWORK="${1:-SOC2}"
ENVIRONMENT="${2:-development}"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting enterprise security hardening for $ENVIRONMENT environment..."

# System updates and security patches
log "Applying security updates..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
apt-get install -y unattended-upgrades apt-listchanges

# Configure automatic security updates
cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF

# Install security tools
log "Installing security tools..."
apt-get install -y
    fail2ban
    ufw
    rkhunter
    chkrootkit
    aide
    auditd
    clamav
    clamav-daemon
    clamav-freshclam
    lynis
    openssh-server

# SSH hardening
log "Hardening SSH configuration..."
SSH_CONFIG="/etc/ssh/sshd_config"
cp "$SSH_CONFIG" "$SSH_CONFIG.backup"

# SSH security settings
cat >> "$SSH_CONFIG" << EOF

# Enterprise SSH Hardening
Protocol 2
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
X11Forwarding no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers vagrant
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
IgnoreRhosts yes
HostbasedAuthentication no
EOF

systemctl restart sshd

# Firewall configuration
log "Configuring firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https

# Allow specific enterprise services
if [ "$ENVIRONMENT" = "development" ]; then
    ufw allow 3000:3010/tcp  # Development ports
    ufw allow 8000:8010/tcp  # Additional dev services
elif [ "$ENVIRONMENT" = "production" ]; then
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw allow from 10.0.0.0/8 to any port 22  # Internal network only
fi

ufw --force enable

# Fail2Ban configuration
log "Configuring Fail2Ban..."
cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3
backend = auto

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600

[apache-auth]
enabled = true
port = http,https
filter = apache-auth
logpath = /var/log/apache2/*error.log
maxretry = 3
EOF

systemctl enable fail2ban
systemctl start fail2ban

# File integrity monitoring with AIDE
log "Setting up file integrity monitoring..."
if [ "$COMPLIANCE_FRAMEWORK" = "SOC2" ] || [ "$COMPLIANCE_FRAMEWORK" = "PCI-DSS" ]; then
    aide --init
    mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

    # Create cron job for daily AIDE checks
    cat > /etc/cron.daily/aide << 'EOF'
#!/bin/bash
/usr/bin/aide --check 2>&1 | mail -s "AIDE Report $(hostname)" admin@enterprise.local
EOF
    chmod +x /etc/cron.daily/aide
fi

# ClamAV antivirus setup
log "Configuring antivirus scanning..."
freshclam --quiet
systemctl enable clamav-daemon
systemctl start clamav-daemon

# Daily virus scan
cat > /etc/cron.daily/clamav-scan << 'EOF'
#!/bin/bash
clamscan -r --remove --exclude-dir='^/sys' --exclude-dir='^/proc' --exclude-dir='^/dev' / 2>&1 | mail -s "ClamAV Scan Report $(hostname)" security@enterprise.local
EOF
chmod +x /etc/cron.daily/clamav-scan

# Audit logging
log "Configuring audit logging..."
cat > /etc/audit/rules.d/enterprise.rules << EOF
# Enterprise audit rules for $COMPLIANCE_FRAMEWORK compliance

# System calls
-a always,exit -F arch=b64 -S execve
-a always,exit -F arch=b32 -S execve

# File access monitoring
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/sudoers -p wa -k sudo_rules

# Network monitoring
-a always,exit -F arch=b64 -S socket -F a0=10 -k network_ipv4
-a always,exit -F arch=b64 -S socket -F a0=2 -k network_ipv4

# Login monitoring
-w /var/log/lastlog -p wa -k logins
-w /var/log/faillog -p wa -k logins

# SSH monitoring
-w /etc/ssh/sshd_config -p wa -k ssh_config

# Critical system files
-w /boot -p wa -k boot
-w /etc/crontab -p wa -k cron
-w /etc/cron.hourly/ -p wa -k cron
-w /etc/cron.daily/ -p wa -k cron
-w /etc/cron.weekly/ -p wa -k cron
-w /etc/cron.monthly/ -p wa -k cron
EOF

systemctl enable auditd
systemctl start auditd

# System hardening
log "Applying system hardening..."

# Kernel parameter hardening
cat > /etc/sysctl.d/99-enterprise-hardening.conf << EOF
# Enterprise security hardening
net.ipv4.ip_forward = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
kernel.exec-shield = 1
kernel.randomize_va_space = 2
EOF

sysctl -p /etc/sysctl.d/99-enterprise-hardening.conf

log "Enterprise security hardening completed successfully."