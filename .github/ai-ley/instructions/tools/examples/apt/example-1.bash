# Update package information
sudo apt update

# Upgrade all packages to latest versions
sudo apt upgrade

# Full system upgrade (handles changing dependencies)
sudo apt full-upgrade

# Check APT configuration
apt-config dump

# Verify repository sources
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d/