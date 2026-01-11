# Ensure correct UIKit path in Less imports
# Check node_modules path
ls node_modules/uikit/src/less/

# Verify import syntax
@import "~uikit/src/less/uikit.less"; // Webpack
@import "node_modules/uikit/src/less/uikit.less"; // Direct path

# Check Less loader configuration
# webpack.config.js
{
  test: /\.less$/,
  use: [
    'style-loader',
    'css-loader',
    {
      loader: 'less-loader',
      options: {
        lessOptions: {
          math: 'always' // Required for UIKit
        }
      }
    }
  ]
}