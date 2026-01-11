# Maintenance window: allow admin IPs only
sudo ufw deny 80/tcp
sudo ufw deny 443/tcp
sudo ufw allow from 203.0.113.10 to any port 22 proto tcp
# Revert afterwards with saved baseline (document baseline rules)