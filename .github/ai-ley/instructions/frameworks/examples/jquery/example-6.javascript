// Basic animations
$('.modal').fadeIn(300);
$('.alert').slideUp(500);

// Custom animations
$('.sidebar').animate(
  {
    width: '300px',
    opacity: 1,
  },
  {
    duration: 400,
    easing: 'easeInOutQuad',
    complete: function () {
      $(this).addClass('expanded');
    },
  },
);

// Chained animations
$('.notification').fadeIn(200).delay(3000).fadeOut(500);