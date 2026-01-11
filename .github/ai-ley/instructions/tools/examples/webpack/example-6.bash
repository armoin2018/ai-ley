# .env file
NODE_ENV=development
API_URL=https://api.example.com
APP_VERSION=1.0.0

# Use in webpack config
const webpack = require('webpack');
const dotenv = require('dotenv');

module.exports = {
  plugins: [
    new webpack.DefinePlugin({
      'process.env': JSON.stringify(dotenv.config().parsed)
    }),
  ],
};