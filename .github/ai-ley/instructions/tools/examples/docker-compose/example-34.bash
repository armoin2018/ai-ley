# Find processes using ports
sudo lsof -i :3000
netstat -tulpn | grep :3000

# Use different ports in override file
echo "services:
  web:
    ports:
      - '3001:3000'" > docker-compose.override.yml