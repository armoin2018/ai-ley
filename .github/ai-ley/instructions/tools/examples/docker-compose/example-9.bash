# Docker Desktop (includes Compose)
# macOS
brew install --cask docker

# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Compose plugin (if not included)
sudo apt-get update
sudo apt-get install docker-compose-plugin

# Verify installation
docker compose version