# Initialize new project
mkdir my-electron-app
cd my-electron-app
npm init -y

# Install Electron
npm install --save-dev electron

# Install development dependencies
npm install --save-dev @electron/rebuild
npm install --save-dev electron-builder # for packaging

# Add start script to package.json
npm pkg set scripts.start="electron ."
npm pkg set main="src/main.js"