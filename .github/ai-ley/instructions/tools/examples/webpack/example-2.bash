# Initialize new project with webpack
mkdir my-webpack-project
cd my-webpack-project
npm init -y
npm install --save-dev webpack webpack-cli

# Create basic project structure
mkdir src dist
touch src/index.js webpack.config.js

# Basic webpack configuration
echo 'const path = require("path");

module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
};' > webpack.config.js