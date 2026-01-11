// lint-staged.config.js - Environment-aware configuration
const isProduction = process.env.NODE_ENV === 'production';
const isCi = process.env.CI === 'true';

module.exports = {
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
    // Only run tests in non-CI environments
    ...(isCi ? [] : ['jest --bail --findRelatedTests --passWithNoTests']),
    // Only run type checking in production builds
    ...(isProduction ? ['tsc --noEmit'] : []),
  ],

  '*.{css,scss}': [
    'stylelint --fix',
    'prettier --write',
    // Only optimize CSS in production
    ...(isProduction ? ['postcss --use autoprefixer --replace'] : []),
  ],

  // Only run expensive operations in CI
  '*.{png,jpg,jpeg}': isCi
    ? ['imagemin-cli --plugin=imagemin-mozjpeg --plugin=imagemin-pngquant']
    : [],
};