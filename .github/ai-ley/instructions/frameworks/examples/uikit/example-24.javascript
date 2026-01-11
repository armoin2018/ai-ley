// Custom UIKit component initialization
import UIkit from 'uikit';
import Icons from 'uikit/dist/js/uikit-icons';

// Load UIKit icons
UIkit.use(Icons);

// Custom component creation
UIkit.component('custom-slider', {
  mixins: [UIkit.mixin.class],

  props: {
    autoplay: Boolean,
    interval: Number,
  },

  defaults: {
    autoplay: true,
    interval: 5000,
  },

  init() {
    this.startAutoplay();
  },

  methods: {
    startAutoplay() {
      if (this.autoplay) {
        this.timer = setInterval(() => {
          this.next();
        }, this.interval);
      }
    },

    next() {
      // Custom next logic
    },

    prev() {
      // Custom previous logic
    },
  },
});

// Event handling for dynamic content
UIkit.util.on(document, 'click', '.js-dynamic-modal', function (e) {
  e.preventDefault();

  const content = this.getAttribute('data-content');

  UIkit.modal.dialog(`
    <div class="uk-modal-header">
      <h2 class="uk-modal-title">Dynamic Content</h2>
    </div>
    <div class="uk-modal-body">
      <p>${content}</p>
    </div>
    <div class="uk-modal-footer uk-text-right">
      <button class="uk-button uk-button-default uk-modal-close" type="button">Close</button>
    </div>
  `);
});

// Notification system
function showNotification(message, type = 'primary') {
  UIkit.notification({
    message: message,
    status: type,
    pos: 'top-right',
    timeout: 5000,
  });
}

// Custom data loading with UIKit components
async function loadData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();

    // Update UIKit components with new data
    const container = document.querySelector('#data-container');
    container.innerHTML = data
      .map(
        (item) => `
      <div class="uk-card uk-card-default uk-margin-bottom">
        <div class="uk-card-body">
          <h3 class="uk-card-title">${item.title}</h3>
          <p>${item.description}</p>
        </div>
      </div>
    `,
      )
      .join('');

    showNotification('Data loaded successfully', 'success');
  } catch (error) {
    showNotification('Failed to load data', 'danger');
  }
}