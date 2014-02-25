var geocoder;
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
	
	fromAddress = document.getElementById("posting_from_address");
	toAddress = document.getElementById("posting_to_address");
	
	var fromAutocomplete = new google.maps.places.Autocomplete(fromAddress);
	fromAutocomplete.bindTo('bounds', map);
	fromAutocomplete.setComponentRestrictions({'country': 'tr'});
	var toAutocomplete = new google.maps.places.Autocomplete(toAddress);
	toAutocomplete.bindTo('bounds', map);
	toAutocomplete.setComponentRestrictions({'country': 'tr'});
	
	fromAddress = document.getElementById("frequent_posting_from_address");
	toAddress = document.getElementById("frequent_posting_to_address");
	
	fromAutocomplete = new google.maps.places.Autocomplete(fromAddress);
	fromAutocomplete.bindTo('bounds', map);
	fromAutocomplete.setComponentRestrictions({'country': 'tr'});
	toAutocomplete = new google.maps.places.Autocomplete(toAddress);
	toAutocomplete.bindTo('bounds', map);
	toAutocomplete.setComponentRestrictions({'country': 'tr'});
	
	// These lines will put the text_fields into the map but will not post the data
	// map.controls[google.maps.ControlPosition.TOP_LEFT].push(fromAddress);
// 	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(toAddress);
}

google.maps.event.addDomListener(window, 'load', initialize);

function calcRoute() 
{	
  var start = document.getElementById('posting_from_address').value;
  var	end = document.getElementById('posting_to_address').value;
		
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

function calcRouteForFrequent() 
{	
  var start = document.getElementById('frequent_posting_from_address').value;
  var	end = document.getElementById('frequent_posting_to_address').value;
		
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