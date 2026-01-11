// webpack.config.js - Multiple configurations
const path = require('path');
const { merge } = require('webpack-merge');

const common = {
  entry: './src/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    clean: true,
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader',
      },
    ],
  },
};

const development = merge(common, {
  mode: 'development',
  devtool: 'inline-source-map',
  devServer: {
    static: './dist',
    hot: true,
  },
});

const production = merge(common, {
  mode: 'production',
  output: {
    filename: '[name].[contenthash].js',
  },
  optimization: {
    minimize: true,
  },
});

module.exports = (env, argv) => {
  if (argv.mode === 'development') {
    return development;
  }
  return production;
};