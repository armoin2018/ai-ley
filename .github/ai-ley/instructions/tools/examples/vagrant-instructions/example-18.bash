# Check port usage
netstat -tulpn | grep :3000

# Test connectivity
telnet localhost 3000