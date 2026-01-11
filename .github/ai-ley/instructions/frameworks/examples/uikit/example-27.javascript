// Ensure UIKit is properly loaded
import UIkit from 'uikit';
import Icons from 'uikit/dist/js/uikit-icons';
UIkit.use(Icons);

// Check for proper DOM ready initialization
document.addEventListener('DOMContentLoaded', function () {
  // UIKit components should initialize automatically
  // For manual initialization:
  UIkit.modal('#my-modal');
});

// For dynamically added content
function initDynamicContent() {
  UIkit.update(); // Re-scan for new components
}

// Debug component initialization
console.log(UIkit.components); // List available components