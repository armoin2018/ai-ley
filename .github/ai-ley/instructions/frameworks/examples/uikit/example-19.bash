# Project creation and setup
mkdir uikit-project && cd uikit-project
npm init -y
npm install uikit

# Development server
webpack serve --mode development
npm run dev

# Build commands
webpack --mode production
npm run build

# Watch mode
webpack --watch
npm run watch