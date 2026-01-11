// No conflict mode
jQuery.noConflict();
// Use jQuery instead of $

// Custom AJAX settings
$.ajaxSetup({
  timeout: 10000,
  cache: false,
  beforeSend: function (xhr) {
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
  },
});

// Custom animation settings
$.fx.speeds.slow = 1000;
$.fx.speeds.fast = 100;