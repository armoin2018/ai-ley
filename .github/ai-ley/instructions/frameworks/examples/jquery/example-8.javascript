(function ($) {
  'use strict';

  $.fn.customModal = function (options) {
    const settings = $.extend(
      {
        animation: 'fade',
        duration: 300,
        backdrop: true,
        keyboard: true,
      },
      options,
    );

    return this.each(function () {
      const $modal = $(this);
      const $backdrop = $('<div class="modal-backdrop"></div>');

      function show() {
        $backdrop.appendTo('body');
        $modal.addClass('active');

        if (settings.animation === 'fade') {
          $modal.fadeIn(settings.duration);
        }
      }

      function hide() {
        $modal.fadeOut(settings.duration, function () {
          $backdrop.remove();
          $modal.removeClass('active');
        });
      }

      // Bind events
      $modal.find('[data-dismiss="modal"]').on('click', hide);

      if (settings.backdrop) {
        $backdrop.on('click', hide);
      }

      if (settings.keyboard) {
        $(document).on('keyup.modal', function (e) {
          if (e.keyCode === 27) hide();
        });
      }

      // Expose methods
      $modal.data('modal', {
        show: show,
        hide: hide,
      });
    });
  };
})(jQuery);

// Usage
$('.modal').customModal({
  animation: 'slide',
  duration: 500,
});