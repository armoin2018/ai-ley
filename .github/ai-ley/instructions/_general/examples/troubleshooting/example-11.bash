# Essential system monitoring commands
# CPU usage
top
htop
vmstat 1

# Memory usage
free -h
cat /proc/meminfo

# Disk I/O
iostat -x 1
iotop

# Network
netstat -tuln
ss -tuln
tcpdump -i eth0

# Process monitoring
ps aux
pstree
lsof -p <pid>