# Install Parcel globally (optional)
npm install -g parcel

# Or install locally in project
npm install --save-dev parcel

# Initialize new project
mkdir my-app && cd my-app
npm init -y

# Create basic project structure
mkdir src
echo '<div id="app">Hello Parcel!</div>' > src/index.html
echo 'console.log("Hello from Parcel!");' > src/index.js

# Add scripts to package.json
npm pkg set scripts.dev="parcel src/index.html"
npm pkg set scripts.build="parcel build src/index.html"