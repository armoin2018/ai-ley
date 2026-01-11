const path = require('path');

module.exports = {
  // Entry point
  entry: './src/index.js',

  // Output configuration
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
    clean: true, // Clean dist folder before each build
  },

  // Mode (development, production, none)
  mode: 'development',

  // Source maps for debugging
  devtool: 'inline-source-map',

  // Development server
  devServer: {
    static: './dist',
    hot: true,
    open: true,
  },
};