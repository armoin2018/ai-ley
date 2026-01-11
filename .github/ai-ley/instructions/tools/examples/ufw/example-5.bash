# Complex port ranges and protocols
sudo ufw allow 6000:6100/tcp                    # Port range
sudo ufw allow proto udp from any to any port 53 # DNS UDP
sudo ufw allow out 123/udp                      # NTP outbound

# Interface-specific rules (if needed)
sudo ufw allow in on eth0 to any port 22 proto tcp
sudo ufw allow out on eth1 from any to any port 53

# Application-specific profiles
sudo ufw app list                               # List available profiles
sudo ufw allow 'Nginx HTTP'                    # HTTP only
sudo ufw allow 'Postfix SMTPS'                 # Secure SMTP

# IPv6 specific rules
sudo ufw allow from 2001:db8::/32 to any port 22 proto tcp