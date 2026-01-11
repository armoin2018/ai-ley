# Node-RED lifecycle
node-red                           # Start Node-RED
node-red --port 1881              # Start on different port
node-red --userDir ./myproject    # Specify user directory
node-red --safe                   # Start in safe mode
node-red --help                   # Show help

# Package management
npm install node-red-contrib-[package]  # Install community nodes
npm list                                 # List installed packages
npm update                              # Update packages
npm uninstall node-red-contrib-[package] # Remove packages

# Flow management
node-red-admin hash-pw              # Generate password hash
node-red-admin target              # Set target Node-RED instance
node-red-admin login               # Login to Node-RED admin API
node-red-admin list flows          # List flows via API

# System service (Linux)
sudo systemctl start nodered      # Start service
sudo systemctl stop nodered       # Stop service
sudo systemctl restart nodered    # Restart service
sudo systemctl status nodered     # Check status