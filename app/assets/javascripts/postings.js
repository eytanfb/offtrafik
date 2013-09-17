jQuery(function($) {
				
	neighborhoods = $("#_find_posting_from_address_neighborhood").html();
	
	$("#from_address_district").change(function(){
		district = $("#from_address_district :selected").text();
		options = $(neighborhoods).filter("optgroup[label='" + district + "']");
		if(options){
			$("#_find_posting_from_address_neighborhood").html(options);		
		}
		
	});
	
	$("#to_address_district").change(function(){
		district = $("#to_address_district :selected").text();
		options = $(neighborhoods).filter("optgroup[label='" + district + "']");
		if(options){
			$("#_find_posting_to_address_neighborhood").html(options);		
		}
				
	});
	
	$("#posting_date").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0
		});
		
		makeTimepicker("#starting_time");
		makeTimepicker("#ending_time");
});

function makeTimepicker(divId){
	$(divId).timepicker({
		minuteStep: 5,
		showMeridian: false,
		defaultTime: 'value'
	});
}

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