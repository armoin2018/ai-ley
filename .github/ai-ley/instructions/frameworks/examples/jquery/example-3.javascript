// Selection
const $header = $('#header');
const $buttons = $('.btn');
const $inputs = $('input[type="text"]');

// Manipulation
$header.text('New Header Text');
$buttons.addClass('active').attr('disabled', false);
$('#content').html('<p>New content</p>');

// Chaining
$('.card').addClass('highlighted').fadeIn(300).find('.title').text('Updated Title');