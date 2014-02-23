jQuery(function($) {
  $(".clickable").click(function() {
        window.document.location = $(this).attr("href");
	});

  $('.navbar .dropdown').hover(function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
  }, function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
  });
});