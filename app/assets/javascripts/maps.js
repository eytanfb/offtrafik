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
				map.setZoom(10);
    }
	});
	
	var from_address = document.getElementById("posting_from_address");
	var to_address = document.getElementById("posting_to_address");
	
	map = new google.maps.Map(document.getElementById("map"), myOptions);
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(from_address);
	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(to_address);
	
	var autocomplete = new google.maps.places.Autocomplete(from_address);
	autocomplete.bindTo('bounds', map);
	autocomplete.setComponentRestrictions({'country': 'tr'});
	autocomplete = new google.maps.places.Autocomplete(to_address);
	autocomplete.bindTo('bounds', map);
	autocomplete.setComponentRestrictions({'country': 'tr'});
	
	directionsDisplay.setMap(map);
	calcRoute();
	
	var inputs = $(':input').keypress(function(e){ 
	    if (e.which == 13) {
	       e.preventDefault();
	       var nextInput = inputs.get(inputs.index(this) + 1);
	       if (nextInput) {
	          nextInput.focus();
	       }
	    }
	});
}

google.maps.event.addDomListener(window, 'load', initialize);

function calcRoute() {
		
  var start = document.getElementById('posting_from_address').value;
  var end = document.getElementById('posting_to_address').value;
	
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

