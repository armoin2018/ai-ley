module.exports = {
  // Enable caching
  cache: {
    type: 'filesystem',
  },

  // Reduce bundle analysis
  stats: 'errors-warnings',

  // Optimize module resolution
  resolve: {
    symlinks: false,
    modules: [path.resolve(__dirname, 'src'), 'node_modules'],
  },

  // Use faster loaders
  module: {
    rules: [
      {
        test: /\.js$/,
        use: 'esbuild-loader', // Faster than babel-loader
        exclude: /node_modules/,
      },
    ],
  },
};