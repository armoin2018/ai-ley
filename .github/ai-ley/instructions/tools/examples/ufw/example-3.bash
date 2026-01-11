# 1) CRITICAL: Allow SSH BEFORE enabling the firewall
sudo ufw allow OpenSSH   # or: sudo ufw allow 22/tcp

# 2) Enable and set default policies with audit logging
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw logging medium
sudo ufw enable

# 3) Verify configuration
sudo ufw status verbose
sudo ufw status numbered