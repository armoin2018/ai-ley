# Check YUM configuration
yum --version
cat /etc/yum.conf

# Update package cache
yum clean all
yum makecache

# List enabled repositories
yum repolist enabled

# Check for available updates
yum check-update

# System update
yum update -y