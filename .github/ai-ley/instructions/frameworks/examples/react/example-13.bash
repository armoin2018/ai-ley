# Enable React DevTools
npm install --save-dev react-devtools

# Debug bundle size
npm run build && npx webpack-bundle-analyzer build/static/js/*.js