var geocoder;
var map;

function initialize(){
	
	var myOptions;
	
	var address = "Istanbul";
	geocoder = new google.maps.Geocoder();
	
	geocoder.geocode({'address': address}, function(results, status)
	{
    if (status == google.maps.GeocoderStatus.OK) {
				myOptions = {
				  zoom: 3,
				  center: results[0].geometry.location,
				  mapTypeId: 'roadmap'
				}
				map.setCenter(results[0].geometry.location);
				map.setZoom(9);
    }
	});
	map = new google.maps.Map(document.getElementById("map"), myOptions);
}
google.maps.event.addDomListener(window, 'load', initialize);

function dropFromMarker()
{
	var address = document.getElementById("from_address").value;
	
	geocoder.geocode({'address': address}, function(results, status)
	{
    if (status == google.maps.GeocoderStatus.OK) {
      var marker = new google.maps.Marker({
          position: results[0].geometry.location,
          map: map
      });
    }
	});
}

function dropToMarker()
{
	var address = document.getElementById("to_address").value;
	
	geocoder.geocode({'address': address}, function(results, status)
	{
    if (status == google.maps.GeocoderStatus.OK) {
      var marker = new google.maps.Marker({
          position: results[0].geometry.location,
          map: map
      });
    }
	});
}

jQuery(function($) {
	$("#posting_date").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0
		});
		$("#starting_time").timepicker({
			minuteStep: 5,
			showMeridian: false
		});
		$("#ending_time").timepicker({
			minuteStep: 5,
			showMeridian: false
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