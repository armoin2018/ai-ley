module.exports = {
  devServer: {
    static: {
      directory: path.join(__dirname, 'public'),
      publicPath: '/static',
    },
    compress: true,
    port: 3000,
    host: 'localhost',
    hot: true, // Hot Module Replacement
    liveReload: true,
    open: true,

    // API proxy
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        pathRewrite: {
          '^/api': '',
        },
      },
    },

    // History API fallback for SPA
    historyApiFallback: {
      rewrites: [
        { from: /^\/$/, to: '/views/landing.html' },
        { from: /^\/subpage/, to: '/views/subpage.html' },
        { from: /./, to: '/views/404.html' },
      ],
    },

    // HTTPS setup
    https: {
      key: fs.readFileSync('/path/to/server.key'),
      cert: fs.readFileSync('/path/to/server.crt'),
      ca: fs.readFileSync('/path/to/ca.pem'),
    },

    // Headers
    headers: {
      'X-Custom-Header': 'yes',
    },
  },
};