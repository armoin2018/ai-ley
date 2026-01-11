# Enable/Disable with enterprise logging
sudo ufw enable
sudo ufw disable

# Default policies with compliance validation
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# Logging levels with SIEM integration
sudo ufw logging off      # No logging (compliance risk)
sudo ufw logging low      # Basic connection logging
sudo ufw logging medium   # Recommended for production
sudo ufw logging high     # Detailed packet logging
sudo ufw logging full     # Complete packet capture (performance impact)

# Status and monitoring
sudo ufw status                    # Basic status
sudo ufw status verbose            # Detailed configuration
sudo ufw status numbered          # Rule numbers for management

# Rule management
sudo ufw delete 3                 # Delete rule number 3
sudo ufw delete allow 80/tcp      # Delete specific rule
sudo ufw insert 1 allow from 192.168.1.0/24  # Insert at position

# Configuration backup and restore
sudo ufw reset                    # Reset all rules (DANGEROUS)