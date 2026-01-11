# Create new project
mkdir my-uikit-project
cd my-uikit-project

# Initialize package.json
npm init -y

# Install UIKit and build tools
npm install uikit less webpack webpack-cli webpack-dev-server --save
npm install less-loader css-loader style-loader html-webpack-plugin --save-dev

# Create project structure
mkdir src dist
touch src/index.html src/styles.less src/scripts.js