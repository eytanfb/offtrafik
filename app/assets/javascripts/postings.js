var geocoder;
var map;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var fromMarker;
var toMarker;

function initialize(){
	
	var myOptions;
	var address = "Istanbul";
	geocoder = new google.maps.Geocoder();
	directionsDisplay = new google.maps.DirectionsRenderer();
	
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
	directionsDisplay.setMap(map);
	
	if(document.getElementById("from_address").innerHTML != null)
	{
		calcRouteForShow();
	}
}

google.maps.event.addDomListener(window, 'load', initialize);

function calcRoute() {
		
  var start = document.getElementById('from_address').value + ", Istanbul";
  var end = document.getElementById('to_address').value + ", Istanbul";
	
  var request = {
      origin:start,
      destination:end,
      travelMode: google.maps.DirectionsTravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

function calcRouteForShow() {
	
  var start = document.getElementById('from_address').innerHTML;
  var end = document.getElementById('to_address').innerHTML;
	
  var request = {
      origin:start,
      destination:end,
      travelMode: google.maps.DirectionsTravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

function setMarkerOptions(marker, map, position, icon)
{
	marker.setMap(map);
	marker.setPosition(position);
	marker.setAnimation(google.maps.Animation.DROP);
	marker.setIcon(icon);
}

jQuery(function($) {
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