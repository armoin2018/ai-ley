// Import only needed components
import { modal, dropdown, navbar } from 'uikit/dist/js/uikit.min.js';

// Or import specific components
import Modal from 'uikit/src/js/components/modal';
import Dropdown from 'uikit/src/js/components/dropdown';

// Use UIKit's tree shaking
// webpack.config.js optimization
module.exports = {
  optimization: {
    usedExports: true,
    sideEffects: false,
  },
};