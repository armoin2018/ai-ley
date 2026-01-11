module.exports = {
  devServer: {
    hot: true,
    liveReload: false, // Disable to prevent conflicts
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
  ],
};

// In your app entry point
if (module.hot) {
  module.hot.accept('./App', () => {
    // Re-render the app
  });
}