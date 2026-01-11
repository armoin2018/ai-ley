# See verbose status and order
sudo ufw status verbose

# Check kernel packet path and conflicts
sudo iptables -S | head -50           # or: sudo nft list ruleset

# Inspect logs
sudo tail -f /var/log/ufw.log

# Common fixes
sudo ufw reload                       # Apply changes
sudo ufw reset                        # Clean slate (requires re-allowing SSH)