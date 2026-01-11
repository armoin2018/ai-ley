# Initialize project with custom build setup
npm init -y
npm install uikit webpack webpack-cli less less-loader css-loader style-loader html-webpack-plugin --save-dev

# Create project structure
mkdir src dist
touch src/index.html src/styles.less src/scripts.js