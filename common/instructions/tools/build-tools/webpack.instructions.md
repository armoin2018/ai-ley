# Webpack Build Tool Instructions

## Tool Overview
- **Tool Name**: webpack
- **Version**: 5.88+ (stable), 5.90+ (latest features)
- **Category**: Build Tools
- **Purpose**: Static module bundler for modern JavaScript applications
- **Prerequisites**: Node.js 16.13+, npm/yarn/pnpm

## Installation & Setup
### Package Manager Installation
```bash
# npm installation
npm install --save-dev webpack webpack-cli

# yarn installation
yarn add --dev webpack webpack-cli

# pnpm installation
pnpm add -D webpack webpack-cli

# Global installation (not recommended for projects)
npm install -g webpack webpack-cli

# Verify installation
npx webpack --version
```

### Project Integration
```bash
# Initialize new project with webpack
mkdir my-webpack-project
cd my-webpack-project
npm init -y
npm install --save-dev webpack webpack-cli

# Create basic project structure
mkdir src dist
touch src/index.js webpack.config.js

# Basic webpack configuration
echo 'const path = require("path");

module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
};' > webpack.config.js
```

## Configuration

### webpack.config.js (Basic)
```javascript
const path = require('path');

module.exports = {
  // Entry point
  entry: './src/index.js',

  // Output configuration
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
    clean: true, // Clean dist folder before each build
  },

  // Mode (development, production, none)
  mode: 'development',

  // Source maps for debugging
  devtool: 'inline-source-map',

  // Development server
  devServer: {
    static: './dist',
    hot: true,
    open: true,
  },
};
```

### Advanced Configuration
```javascript
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = (env, argv) => {
  const isProduction = argv.mode === 'production';

  return {
    entry: {
      main: './src/index.js',
      vendor: './src/vendor.js',
    },

    output: {
      filename: isProduction
        ? '[name].[contenthash].js'
        : '[name].js',
      path: path.resolve(__dirname, 'dist'),
      clean: true,
      assetModuleFilename: 'assets/[hash][ext][query]',
    },

    module: {
      rules: [
        // JavaScript/TypeScript
        {
          test: /\.(js|jsx|ts|tsx)$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: [
                ['@babel/preset-env', { targets: 'defaults' }],
                '@babel/preset-react',
                '@babel/preset-typescript',
              ],
            },
          },
        },

        // CSS/SCSS
        {
          test: /\.(css|scss|sass)$/i,
          use: [
            isProduction ? MiniCssExtractPlugin.loader : 'style-loader',
            'css-loader',
            'postcss-loader',
            'sass-loader',
          ],
        },

        // Images
        {
          test: /\.(png|jpe?g|gif|svg)$/i,
          type: 'asset/resource',
        },

        // Fonts
        {
          test: /\.(woff|woff2|eot|ttf|otf)$/i,
          type: 'asset/resource',
        },
      ],
    },

    plugins: [
      new HtmlWebpackPlugin({
        template: './src/index.html',
        title: 'My Webpack App',
        inject: true,
      }),

      ...(isProduction ? [
        new MiniCssExtractPlugin({
          filename: '[name].[contenthash].css',
        }),
      ] : []),
    ],

    optimization: {
      minimize: isProduction,
      minimizer: [
        new TerserPlugin({
          terserOptions: {
            compress: {
              drop_console: true,
            },
          },
        }),
        new CssMinimizerPlugin(),
      ],

      splitChunks: {
        chunks: 'all',
        cacheGroups: {
          vendor: {
            test: /[\\/]node_modules[\\/]/,
            name: 'vendors',
            chunks: 'all',
          },
        },
      },
    },

    resolve: {
      extensions: ['.js', '.jsx', '.ts', '.tsx'],
      alias: {
        '@': path.resolve(__dirname, 'src'),
        '@components': path.resolve(__dirname, 'src/components'),
        '@utils': path.resolve(__dirname, 'src/utils'),
      },
    },

    devServer: {
      static: {
        directory: path.join(__dirname, 'dist'),
      },
      compress: true,
      port: 3000,
      hot: true,
      open: true,
      historyApiFallback: true, // For SPA routing
    },

    devtool: isProduction ? 'source-map' : 'eval-source-map',
  };
};
```

### Multi-Configuration Setup
```javascript
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
```

### Environment Variables
```bash
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
```

## Core Features

### Module Loading and Processing
- **Purpose**: Transform and bundle different file types
- **Usage**: Configure loaders for various file formats
- **Example**:
```javascript
module.exports = {
  module: {
    rules: [
      // Babel for JavaScript/TypeScript
      {
        test: /\.(js|jsx|ts|tsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react'],
            plugins: ['@babel/plugin-proposal-class-properties'],
          },
        },
      },

      // CSS with PostCSS
      {
        test: /\.css$/i,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              modules: true, // CSS Modules
              importLoaders: 1,
            },
          },
          'postcss-loader',
        ],
      },

      // SCSS/Sass
      {
        test: /\.(scss|sass)$/i,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader',
        ],
      },

      // Images and assets
      {
        test: /\.(png|jpe?g|gif|svg)$/i,
        type: 'asset/resource',
        generator: {
          filename: 'images/[hash][ext]',
        },
      },

      // Inline small assets
      {
        test: /\.(png|jpe?g|gif)$/i,
        type: 'asset',
        parser: {
          dataUrlCondition: {
            maxSize: 8 * 1024, // 8kb
          },
        },
      },
    ],
  },
};
```

### Code Splitting and Optimization
- **Purpose**: Split code into chunks for better loading performance
- **Usage**: Configure chunk splitting strategies
- **Example**:
```javascript
module.exports = {
  optimization: {
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        // Vendor libraries
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all',
          priority: 10,
        },

        // Common code
        common: {
          name: 'common',
          minChunks: 2,
          chunks: 'all',
          priority: 5,
          reuseExistingChunk: true,
        },

        // CSS extraction
        styles: {
          name: 'styles',
          test: /\.css$/,
          chunks: 'all',
          enforce: true,
        },
      },
    },

    // Runtime chunk
    runtimeChunk: {
      name: 'runtime',
    },

    // Tree shaking
    usedExports: true,
    sideEffects: false,
  },
};
```

### Development Server
- **Purpose**: Live development server with hot module replacement
- **Usage**: Configure development environment and features
- **Example**:
```javascript
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
```

## Common Commands
```bash
# Build commands
npx webpack                        # Build with default config
npx webpack --config webpack.config.js  # Specific config file
npx webpack --mode=production      # Production build
npx webpack --mode=development     # Development build

# Watch mode
npx webpack --watch               # Watch for changes
npx webpack -w                    # Short form

# Development server
npx webpack serve                 # Start dev server
npx webpack serve --mode=development  # Dev server in dev mode
npx webpack serve --open          # Open browser automatically

# Bundle analysis
npx webpack-bundle-analyzer dist/bundle.js  # Analyze bundle
npx webpack --profile --json > stats.json   # Generate stats

# Environment-specific builds
npx webpack --env production      # Pass environment variables
npx webpack --env development --env api=localhost

# Verbose output
npx webpack --progress            # Show build progress
npx webpack --verbose             # Detailed output

# Performance analysis
npx webpack --analyze             # Bundle analysis
ANALYZE=true npm run build        # With environment variable
```

## Advanced Features

### Plugin System
```javascript
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
```

### Custom Loaders
```javascript
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
```

### Custom Plugins
```javascript
// custom-plugin.js
class CustomPlugin {
  apply(compiler) {
    compiler.hooks.compilation.tap('CustomPlugin', (compilation) => {
      console.log('The compiler is starting a new compilation...');
    });

    compiler.hooks.emit.tapAsync('CustomPlugin', (compilation, callback) => {
      // Add custom asset
      compilation.assets['custom-file.txt'] = {
        source: () => 'Custom content',
        size: () => 14,
      };
      callback();
    });
  }
}

module.exports = CustomPlugin;

// Use in webpack config
const CustomPlugin = require('./plugins/custom-plugin');

module.exports = {
  plugins: [
    new CustomPlugin(),
  ],
};
```

### Micro-frontend Configuration
```javascript
const ModuleFederationPlugin = require('@module-federation/webpack');

module.exports = {
  plugins: [
    new ModuleFederationPlugin({
      name: 'shell',
      remotes: {
        mfe1: 'mfe1@http://localhost:3001/remoteEntry.js',
        mfe2: 'mfe2@http://localhost:3002/remoteEntry.js',
      },
    }),
  ],
};

// For micro-frontend module
module.exports = {
  plugins: [
    new ModuleFederationPlugin({
      name: 'mfe1',
      filename: 'remoteEntry.js',
      exposes: {
        './Component': './src/Component',
      },
      shared: {
        react: { singleton: true },
        'react-dom': { singleton: true },
      },
    }),
  ],
};
```

## Common Patterns

### React Application Setup
```javascript
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/index.jsx',

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              '@babel/preset-env',
              '@babel/preset-react',
            ],
            plugins: [
              '@babel/plugin-proposal-class-properties',
              'react-hot-loader/babel',
            ],
          },
        },
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader'],
      },
    ],
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),
  ],

  devServer: {
    hot: true,
    historyApiFallback: true,
  },

  resolve: {
    extensions: ['.js', '.jsx'],
  },
};
```

### TypeScript Setup
```javascript
module.exports = {
  entry: './src/index.ts',

  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },

  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },

  // Alternative: Use babel-loader with TypeScript preset
  module: {
    rules: [
      {
        test: /\.(ts|tsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              '@babel/preset-env',
              '@babel/preset-typescript',
            ],
          },
        },
      },
    ],
  },
};
```

### PWA Configuration
```javascript
const WorkboxPlugin = require('workbox-webpack-plugin');
const WebpackPwaManifest = require('webpack-pwa-manifest');

module.exports = {
  plugins: [
    new WorkboxPlugin.GenerateSW({
      clientsClaim: true,
      skipWaiting: true,
      runtimeCaching: [
        {
          urlPattern: /^https:\/\/api\.example\.com/,
          handler: 'NetworkFirst',
          options: {
            cacheName: 'api-cache',
          },
        },
      ],
    }),

    new WebpackPwaManifest({
      name: 'My Progressive Web App',
      short_name: 'MyPWA',
      description: 'My awesome Progressive Web App!',
      background_color: '#ffffff',
      crossorigin: 'use-credentials',
      icons: [
        {
          src: path.resolve('src/assets/icon.png'),
          sizes: [96, 128, 192, 256, 384, 512],
        },
      ],
    }),
  ],
};
```

## Performance Optimization

### Bundle Optimization
```javascript
const TerserPlugin = require('terser-webpack-plugin');
const CompressionPlugin = require('compression-webpack-plugin');

module.exports = {
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        terserOptions: {
          compress: {
            drop_console: true,
            drop_debugger: true,
          },
        },
      }),
    ],

    splitChunks: {
      chunks: 'all',
      maxInitialRequests: 10,
      maxAsyncRequests: 10,
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all',
        },
        common: {
          name: 'common',
          minChunks: 2,
          priority: 5,
          reuseExistingChunk: true,
        },
      },
    },
  },

  plugins: [
    new CompressionPlugin({
      algorithm: 'gzip',
      test: /\.(js|css|html|svg)$/,
      threshold: 8192,
      minRatio: 0.8,
    }),
  ],
};
```

### Caching Strategy
```javascript
module.exports = {
  output: {
    filename: '[name].[contenthash].js',
    chunkFilename: '[name].[contenthash].chunk.js',
  },

  optimization: {
    runtimeChunk: 'single',
    splitChunks: {
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all',
        },
      },
    },
  },

  // Cache configuration
  cache: {
    type: 'filesystem',
    buildDependencies: {
      config: [__filename],
    },
  },
};
```

### Tree Shaking
```javascript
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
```

## Common Issues & Solutions

### Build Performance Issues
**Problem**: Slow build times
**Solution**: Optimize configuration and use caching
```javascript
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
```

### Memory Issues
**Problem**: Out of memory errors during build
**Solution**: Increase memory and optimize configuration
```bash
# Increase Node.js memory
export NODE_OPTIONS="--max_old_space_size=4096"
node --max_old_space_size=4096 node_modules/.bin/webpack

# Or in package.json scripts
{
  "scripts": {
    "build": "node --max_old_space_size=4096 node_modules/.bin/webpack"
  }
}
```

### Module Resolution Issues
**Problem**: Cannot resolve modules
**Solution**: Configure resolve aliases and extensions
```javascript
module.exports = {
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx', '.json'],
    alias: {
      '@': path.resolve(__dirname, 'src'),
      '@components': path.resolve(__dirname, 'src/components'),
    },
    fallback: {
      "crypto": require.resolve("crypto-browserify"),
      "stream": require.resolve("stream-browserify"),
    },
  },
};
```

### Hot Module Replacement Issues
**Problem**: HMR not working properly
**Solution**: Configure HMR correctly
```javascript
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
```

## Integration with Development Tools

### Package.json Scripts
```json
{
  "scripts": {
    "dev": "webpack serve --mode=development",
    "build": "webpack --mode=production",
    "build:analyze": "ANALYZE=true webpack --mode=production",
    "build:stats": "webpack --mode=production --json > stats.json",
    "clean": "rimraf dist",
    "lint": "eslint src --ext .js,.jsx,.ts,.tsx",
    "type-check": "tsc --noEmit"
  },
  "devDependencies": {
    "webpack": "^5.88.0",
    "webpack-cli": "^5.1.0",
    "webpack-dev-server": "^4.15.0",
    "html-webpack-plugin": "^5.5.0",
    "mini-css-extract-plugin": "^2.7.0",
    "babel-loader": "^9.1.0",
    "css-loader": "^6.8.0",
    "style-loader": "^3.3.0"
  }
}
```

### CI/CD Integration
```yaml
# GitHub Actions
name: Build and Deploy
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Run tests
      run: npm test

    - name: Build production bundle
      run: npm run build
      env:
        NODE_ENV: production

    - name: Upload artifacts
      uses: actions/upload-artifact@v3
      with:
        name: webpack-bundle
        path: dist/
```

### Docker Integration
```dockerfile
# Multi-stage Dockerfile
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build application
RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built files
COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

## Useful Resources
- **Official Documentation**: https://webpack.js.org/
- **Webpack CLI**: https://webpack.js.org/api/cli/
- **Loaders Directory**: https://webpack.js.org/loaders/
- **Plugins Directory**: https://webpack.js.org/plugins/
- **Bundle Analyzer**: https://github.com/webpack-contrib/webpack-bundle-analyzer
- **Webpack Examples**: https://github.com/webpack/webpack/tree/main/examples

## Tool-Specific Guidelines

### Configuration Best Practices
- Use separate config files for different environments
- Keep configurations DRY with webpack-merge
- Use meaningful chunk names for better debugging
- Configure proper source maps for development and production
- Implement progressive web app features when applicable

### Performance Guidelines
- Enable tree shaking in production
- Use code splitting for better caching
- Optimize images and assets
- Implement proper caching headers
- Monitor bundle size with webpack-bundle-analyzer

### Security Considerations
- Validate and sanitize environment variables
- Use Content Security Policy headers
- Implement subresource integrity for external resources
- Avoid exposing sensitive information in bundles
- Keep dependencies updated for security patches

## Version Compatibility
- **webpack**: 5.x (current), 4.x (legacy support)
- **Node.js**: 16.13+ (webpack 5.x), 14.15+ (webpack 4.x)
- **npm**: 7.0+ (recommended), 6.14+ (supported)
- **Browser Support**: ES2015+ by default, configurable with Babel

## Troubleshooting

### Debug Mode
```bash
# Enable verbose logging
npx webpack --stats=verbose

# Debug specific loaders
DEBUG=webpack:* npx webpack

# Generate detailed stats
npx webpack --profile --json > stats.json

# Analyze bundle composition
npx webpack-bundle-analyzer stats.json
```

### Common Error Messages
- **Error**: `Module not found`
  **Cause**: Incorrect file paths or missing dependencies
  **Solution**: Check import paths and install missing packages

- **Error**: `Cannot resolve loader`
  **Cause**: Loader not installed or misconfigured
  **Solution**: Install loader package and verify configuration

- **Error**: `ReferenceError: process is not defined`
  **Cause**: Node.js globals not available in browser
  **Solution**: Use DefinePlugin or configure fallbacks
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions

```

```
