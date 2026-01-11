// custom-loader.js
module.exports = function(source) {
  // Transform source code
  const transformed = source.replace(/console\.log/g, '// console.log');
  return transformed;
};

// Use in webpack config
module.exports = {
  module: {
    rules: [
      {
        test: /\.js$/,
        use: [
          'babel-loader',
          path.resolve(__dirname, 'loaders/custom-loader.js'),
        ],
      },
    ],
  },
};