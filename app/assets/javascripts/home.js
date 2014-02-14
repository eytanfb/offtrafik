$(function(){
	$("#find_from_home_from_address").chosen({no_results_text: "Semt Bulunamadi"});
});

var map;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var fromMarker;
var toMarker;

function initialize()
{
	directionsDisplay = new google.maps.DirectionsRenderer();
	var myOptions = {
	  zoom: 10,
	  center: new google.maps.LatLng(41.1136, 28.9750),
		bounds: new google.maps.LatLngBounds(new google.maps.LatLng(41.500, 28.400), new google.maps.LatLng(40.600, 29.400)),
	  mapTypeId: 'roadmap'
	}
	
	map = new google.maps.Map(document.getElementById("map"), myOptions);
	
	directionsDisplay.setMap(map);
	
	fromAddress = document.getElementById("find_from_home_from_address_chosen");
	toAddress = document.getElementById("find_from_home_to_address");
	
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(fromAddress);
	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(toAddress);
}

google.maps.event.addDomListener(window, 'load', initialize);

function calcRoute() 
{	
	alert($('#find_from_home_from_address').chosen().val());
  var start = $('#find_from_home_from_address').chosen().val();
  var	end = document.getElementById('find_from_home_to_address').value;
		
  var request = {
      origin:start,
      destination:end,
			region: "tr",
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