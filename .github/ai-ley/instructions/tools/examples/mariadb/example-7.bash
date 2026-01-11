# Development environment setup
docker run --name mariadb-dev \
  -e MYSQL_ROOT_PASSWORD=development \
  -e MYSQL_DATABASE=myapp \
  -e MYSQL_USER=developer \
  -e MYSQL_PASSWORD=devpass \
  -p 3306:3306 \
  -d mariadb:10.11

# Production deployment with configuration
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb