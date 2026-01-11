// Advanced JavaScript integration
document.addEventListener('DOMContentLoaded', function () {
  // Initialize tooltips
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const tooltipList = [...tooltipTriggerList].map(
    (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl),
  );

  // Form validation
  const forms = document.querySelectorAll('.needs-validation');
  Array.from(forms).forEach((form) => {
    form.addEventListener(
      'submit',
      (event) => {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      },
      false,
    );
  });

  // Modal events
  const modal = document.getElementById('exampleModal');
  if (modal) {
    modal.addEventListener('show.bs.modal', function (event) {
      // Reset form when modal opens
      const form = modal.querySelector('form');
      if (form) {
        form.reset();
        form.classList.remove('was-validated');
      }
    });
  }
});