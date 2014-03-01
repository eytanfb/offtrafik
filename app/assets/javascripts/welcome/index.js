var ajax_form = true;

$(document).ready(function() {

	$(document).ready(function(){	
		$('#header').parallax("center", 0.5, false);
	});

	var cbpAnimatedHeader = (function() {

		var docElem = document.documentElement,
		header = document.querySelector( '.cbp-af-header' ),
		didScroll = false,
		changeHeaderOn = 200;

		function init() {
			window.addEventListener( 'scroll', function( event ) {
				if( !didScroll ) {
					didScroll = true;
					setTimeout( scrollPage, 0 );
				}
			}, false );
		}

		function scrollPage() {
			var sy = scrollY();
			if ( sy >= changeHeaderOn ) {
				classie.add( header, 'cbp-af-header-shrink' );
			}
			else {
				classie.remove( header, 'cbp-af-header-shrink' );
			}
			didScroll = false;
		}

		function scrollY() {
			return window.pageYOffset || docElem.scrollTop;
		}

		init();

	})();
	
	$('.fade1').delay(400).fadeIn(2000);
	
	$('.fade2').delay(700).fadeIn(1500);
	
	$('.fade3').delay(1000).fadeIn(1500, function(){
		$('.fade3').effect("pulsate", {times: 2}, 1250);
	});
	
	new cbpScroller( document.getElementById( 'cbp-so-scroller' ) );

	$('.scroll-button').click(function(e){
		$('html,body').scrollTo(this.hash,this.hash);
		e.preventDefault();
	});
	
	$("#login-submit").click(function(e){
		$("#header-login").submit();
	});
	
});
