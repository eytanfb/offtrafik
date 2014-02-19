var map;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var fromMarker;
var toMarker;

function initialize(){
	
	var myOptions;
	var address = "Istanbul";
	directionsDisplay = new google.maps.DirectionsRenderer();
	

	myOptions = {
	  zoom: 10,
	  center: new google.maps.LatLng(41.1136, 28.9750),
		bounds: new google.maps.LatLngBounds(new google.maps.LatLng(41.500, 28.400), new google.maps.LatLng(40.600, 29.400)),
	  mapTypeId: 'roadmap'
	}
		
	map = new google.maps.Map(document.getElementById("show-map"), myOptions);
	var traffic = new google.maps.TrafficLayer();
	traffic.setMap(map);
	directionsDisplay.setMap(map);
	
	calcRouteForShow();
}

google.maps.event.addDomListener(window, 'load', initialize);

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

