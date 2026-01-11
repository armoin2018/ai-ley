// Enable UIKit debugging
UIkit.debug = true;

// Check component status
console.log(UIkit.components);

// Monitor events
UIkit.util.on(document, 'show.uk.modal', function (e) {
  console.log('Modal showing:', e.target);
});

// Check for initialization issues
document.addEventListener('DOMContentLoaded', function () {
  console.log('UIKit loaded:', typeof UIkit !== 'undefined');
  console.log('Available components:', Object.keys(UIkit.components));
});