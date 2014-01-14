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
	
	if(document.getElementById("from_address") && document.getElementById("from_address").innerHTML != null)
	{
		calcRouteForShow();
	}
}

google.maps.event.addDomListener(window, 'load', initialize);

function calcRoute() {
		
  var start = document.getElementById('from_address_district').value + ", Istanbul";
  var end = document.getElementById('to_address_district').value + ", Istanbul";
	
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
	
  var start = document.getElementById('from_address').innerHTML + ", Istanbul";
  var end = document.getElementById('to_address').innerHTML + ", Istanbul";
	
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

