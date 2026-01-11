# Web services with application profiles
sudo ufw allow 'Nginx Full'     # HTTP + HTTPS
sudo ufw allow 'Apache Full'    # HTTP + HTTPS
sudo ufw allow 'OpenSSH'        # SSH

# Database services with source restriction
sudo ufw allow from 192.168.1.0/24 to any port 3306 proto tcp    # MySQL
sudo ufw allow from 192.168.1.0/24 to any port 5432 proto tcp    # PostgreSQL
sudo ufw allow from 192.168.1.0/24 to any port 27017 proto tcp   # MongoDB

# Application services
sudo ufw allow 8080/tcp         # Application server
sudo ufw allow 9000/tcp         # PHP-FPM
sudo ufw allow 11211/tcp        # Memcached (local only)

# Monitoring and management
sudo ufw allow from 192.168.1.0/24 to any port 9100 proto tcp    # Node exporter
sudo ufw allow from 192.168.1.0/24 to any port 3000 proto tcp    # Grafana

# Rate limiting for sensitive services
sudo ufw limit ssh/tcp          # SSH rate limiting
sudo ufw limit 443/tcp          # HTTPS rate limiting (optional)