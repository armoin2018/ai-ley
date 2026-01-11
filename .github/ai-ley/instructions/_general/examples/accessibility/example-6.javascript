//  Good: Proper focus management
class AccessibleModal {
  constructor(element) {
    this.modal = element;
    this.focusableElements = this.modal.querySelectorAll(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    );
    this.firstFocusable = this.focusableElements[0];
    this.lastFocusable = this.focusableElements[this.focusableElements.length - 1];
  }

  open() {
    this.modal.removeAttribute('hidden');
    this.modal.setAttribute('aria-hidden', 'false');
    this.firstFocusable.focus();
    document.addEventListener('keydown', this.handleKeyDown.bind(this));
  }

  close() {
    this.modal.setAttribute('hidden', '');
    this.modal.setAttribute('aria-hidden', 'true');
    document.removeEventListener('keydown', this.handleKeyDown.bind(this));
    this.returnFocus();
  }

  handleKeyDown(event) {
    if (event.key === 'Escape') {
      this.close();
    }
    
    if (event.key === 'Tab') {
      this.trapFocus(event);
    }
  }

  trapFocus(event) {
    if (event.shiftKey) {
      if (document.activeElement === this.firstFocusable) {
        event.preventDefault();
        this.lastFocusable.focus();
      }
    } else {
      if (document.activeElement === this.lastFocusable) {
        event.preventDefault();
        this.firstFocusable.focus();
      }
    }
  }
}