# Install PECL (usually included with PHP development packages)
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install php-pear php-dev build-essential

# CentOS/RHEL
sudo yum install php-pear php-devel gcc gcc-c++ make

# macOS with Homebrew
brew install php
xcode-select --install  # For development tools

# Verify PECL installation
pecl version
pecl list-all | head -20  # Show available extensions

# Update PECL channel and package list
pecl channel-update pecl.php.net
pecl update-channels