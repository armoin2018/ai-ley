# Create project structure
mkdir custom-neutralino-app && cd custom-neutralino-app

# Download Neutralino binaries
neu init --template minimal

# Set up custom frontend build process
mkdir src public
touch src/index.html src/main.js src/style.css

# Configure build tools (webpack, vite, parcel, etc.)
npm init -y
npm install --save-dev vite