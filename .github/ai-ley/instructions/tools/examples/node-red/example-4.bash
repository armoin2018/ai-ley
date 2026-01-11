# Create project directory
mkdir my-node-red-project
cd my-node-red-project

# Initialize Node-RED project
node-red --userDir ./

# Install additional nodes
npm install node-red-contrib-mqtt
npm install node-red-contrib-influxdb
npm install node-red-dashboard