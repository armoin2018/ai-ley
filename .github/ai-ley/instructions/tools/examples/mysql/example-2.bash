# Package manager installation
# Ubuntu/Debian
sudo apt update && sudo apt install mysql-server

# macOS
brew install mysql

# Start MySQL service
sudo systemctl start mysql

# Secure installation
sudo mysql_secure_installation

# Docker installation
docker run -d --name mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=myapp \
  -e MYSQL_USER=appuser \
  -e MYSQL_PASSWORD=apppassword \
  -v mysql_data:/var/lib/mysql \
  mysql:8.0

# Cloud service setup
# AWS RDS
aws rds create-db-instance --db-instance-identifier mydb \
  --db-instance-class db.t3.micro --engine mysql \
  --master-username admin --master-user-password password