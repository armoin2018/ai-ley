// jQuery modal with accessibility
class AccessibleModal {
  constructor(selector, options = {}) {
    this.$modal = $(selector);
    this.$trigger = $(`[data-target="${selector}"]`);
    this.$closeBtn = this.$modal.find('.modal-close');
    this.$overlay = this.$modal.find('.modal-overlay');
    
    this.options = {
      closeOnOverlayClick: true,
      closeOnEscKey: true,
      ...options
    };
    
    this.init();
  }
  
  init() {
    this.$trigger.on('click', (e) => {
      e.preventDefault();
      this.open();
    });
    
    this.$closeBtn.on('click', (e) => {
      e.preventDefault();
      this.close();
    });
    
    if (this.options.closeOnOverlayClick) {
      this.$overlay.on('click', (e) => {
        if (e.target === e.currentTarget) {
          this.close();
        }
      });
    }
    
    if (this.options.closeOnEscKey) {
      $(document).on('keydown.modal', (e) => {
        if (e.key === 'Escape' && this.$modal.is(':visible')) {
          this.close();
        }
      });
    }
  }
  
  open() {
    // Store previously focused element
    this.previouslyFocused = document.activeElement;
    
    this.$modal
      .removeClass('d-none')
      .attr('aria-hidden', 'false')
      .find('[autofocus], input, select, textarea, button')
      .first()
      .focus();
    
    $('body').addClass('modal-open');
  }
  
  close() {
    this.$modal
      .addClass('d-none')
      .attr('aria-hidden', 'true');
    
    $('body').removeClass('modal-open');
    
    // Return focus to previously focused element
    if (this.previouslyFocused) {
      this.previouslyFocused.focus();
    }
  }
}

// Usage
const modal = new AccessibleModal('#myModal');