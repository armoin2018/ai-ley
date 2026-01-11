// parcel-config.js - Advanced Parcel configuration
const { defineConfig } = require('@parcel/config-default');

module.exports = defineConfig({
  // Entry points
  entries: [
    'src/index.html',
    'src/service-worker.js'
  ],
  
  // Development server configuration
  devServer: {
    port: 3000,
    host: 'localhost',
    https: false,
    open: true,
    hmr: true
  },
  
  // Build optimization
  optimization: {
    minimize: true,
    scopeHoisting: true,
    publicUrl: './'
  },
  
  // Environment variables
  env: {
    NODE_ENV: 'production',
    API_URL: 'https://api.example.com',
    VERSION: require('./package.json').version
  },
  
  // Advanced features
  features: {
    // Enable experimental features
    experimentalScope: true,
    experimentalBundleAnalysis: true
  }
});