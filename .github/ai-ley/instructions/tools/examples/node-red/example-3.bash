# Update system
sudo apt update && sudo apt upgrade

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Node-RED
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)

# Enable auto-start
sudo systemctl enable nodered.service

# Start service
sudo systemctl start nodered.service