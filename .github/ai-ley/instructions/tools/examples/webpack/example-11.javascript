const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const webpack = require('webpack');

module.exports = {
  plugins: [
    // Clean dist folder
    new CleanWebpackPlugin(),

    // Generate HTML file
    new HtmlWebpackPlugin({
      template: './src/index.html',
      title: 'My App',
      minify: {
        removeComments: true,
        collapseWhitespace: true,
      },
    }),

    // Extract CSS
    new MiniCssExtractPlugin({
      filename: '[name].[contenthash].css',
      chunkFilename: '[id].[contenthash].css',
    }),

    // Define environment variables
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
      'process.env.API_URL': JSON.stringify(process.env.API_URL),
    }),

    // Copy static files
    new CopyWebpackPlugin({
      patterns: [
        { from: 'public', to: 'public' },
        { from: 'src/assets', to: 'assets' },
      ],
    }),

    // Bundle analyzer (conditional)
    ...(process.env.ANALYZE ? [new BundleAnalyzerPlugin()] : []),
  ],
};