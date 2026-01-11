module.exports = {
  mode: 'production',
  optimization: {
    usedExports: true,
    sideEffects: false, // Or array of files with side effects
  },

  // In package.json
  {
    "sideEffects": [
      "*.css",
      "*.scss",
      "./src/polyfills.js"
    ]
  }
};