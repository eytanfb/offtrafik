var ajax_form = true;

$(document).ready(function() {

	$(document).ready(function(){	
		$('#header').parallax("center", 0.5, false);
	});

	$('form').submit(function() {
		
		var form_data = $(this).serialize();

		if ($.trim($("#input_email").val()).length <= 0){
			$('p.spam').text('Javascript: Please enter an e-mail address').effect("pulsate", { times:4 }, 700);
			return false;
		}
		else{
			if (typeof ajax_form !== "undefined" && ajax_form === true)
			{
				$.post($(this).attr('action'), form_data, function(data) {
					$('form').show('slow', function() { $(this).after('<div class="clear"></div> <p class="msg-ok">'+ data + '</p>'); });
					$('.spam').hide();
					$('.msg-ok').delay(300).effect("pulsate", { times:1 }, 1000);
				});
				
				return false;
			}
		}
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

	$('.button').click(function(e){
		$('html,body').scrollTo(this.hash,this.hash);
		e.preventDefault();
	});
	
});
