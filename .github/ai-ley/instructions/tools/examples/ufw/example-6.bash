# Web server (Nginx)
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 'Nginx Full'
sudo ufw allow from 203.0.113.10 to any port 22 proto tcp  # admin IP

# Database server (internal-only)
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 10.0.0.0/24 to any port 5432 proto tcp
sudo ufw allow from 10.0.0.0/24 to any port 9100 proto tcp  # node exporter

# VPN gateway
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 1194/udp
sudo ufw allow from 10.8.0.0/24 to any