# Install NW.js globally
npm install -g nw

# Verify installation
nw --version

# Create new project
mkdir my-nwjs-app && cd my-nwjs-app

# Initialize package.json
npm init -y

# Install NW.js as dev dependency for specific version control
npm install --save-dev nw

# Create basic application structure
mkdir src
touch src/index.html src/main.js src/style.css

# Create package.json for NW.js app
cat > package.json << 'EOF'
{
  "name": "my-nwjs-app",
  "version": "1.0.0",
  "description": "My NW.js Application",
  "main": "src/index.html",
  "node-remote": "http://localhost:*",
  "webkit": {
    "plugin": true
  },
  "window": {
    "title": "My NW.js App",
    "width": 1200,
    "height": 800,
    "min_width": 800,
    "min_height": 600,
    "position": "center",
    "resizable": true,
    "show_in_taskbar": true,
    "frame": true,
    "kiosk": false,
    "show": true
  },
  "scripts": {
    "start": "nw .",
    "dev": "nw . --debug",
    "build": "nwbuild -p win32,win64,osx64,linux32,linux64 -v 0.75.0 .",
    "dist": "npm run build"
  },
  "devDependencies": {
    "nw": "^0.75.0",
    "nw-builder": "^3.7.0"
  }
}
EOF

# Start development
npm start