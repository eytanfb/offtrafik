jQuery(function($) {

	$("#from_address_district").change(function(){
		// fill from_address_neighborhood
	});
	
	$("#to_address_district").change(function(){
		// fill from_address_neighborhood
	});
	
	$("#posting_date").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0
		});
		$("#starting_time").timepicker({
			minuteStep: 5,
			showMeridian: false,
			defaultTime: 'value'
		});
		$("#ending_time").timepicker({
			minuteStep: 5,
			showMeridian: false,
			defaultTime: 'value'
		});
});

// script take from twitter for the share button
!function(d,s,id){
	var js,fjs = d.getElementsByTagName(s)[0];
	if(!d.getElementById(id))
	{
		js=d.createElement(s);
		js.id=id;
		js.src="https://platform.twitter.com/widgets.js";
		fjs.parentNode.insertBefore(js,fjs);
	}
}(document,"script","twitter-wjs");

function facebookShare(uri){
  window.open(
    'https://www.facebook.com/sharer/sharer.php?u='+uri, 
    'facebook-share-dialog', 
    'width=626,height=436'); 
  return false;
};