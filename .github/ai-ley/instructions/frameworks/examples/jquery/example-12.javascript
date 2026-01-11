// Enable debug logging
jQuery.fn.debug = function () {
  console.log(this);
  return this;
};

// Usage
$('.element').debug().addClass('active');