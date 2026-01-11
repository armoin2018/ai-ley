// Click events
$('.btn-submit').on('click', function (e) {
  e.preventDefault();
  const formData = $('#myForm').serialize();
  submitForm(formData);
});

// Event delegation for dynamic content
$(document).on('click', '.dynamic-btn', function () {
  const itemId = $(this).data('id');
  handleDynamicClick(itemId);
});

// Multiple events
$('.input-field').on('focus blur', function (e) {
  $(this).toggleClass('focused', e.type === 'focus');
});