# Ubuntu/Debian installation
sudo apt update
sudo apt install mariadb-server mariadb-client

# CentOS/RHEL installation
sudo yum install mariadb-server mariadb

# macOS installation with Homebrew
brew install mariadb

# Start and enable MariaDB service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure installation
sudo mysql_secure_installation