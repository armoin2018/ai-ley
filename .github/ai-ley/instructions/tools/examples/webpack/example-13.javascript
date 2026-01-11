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