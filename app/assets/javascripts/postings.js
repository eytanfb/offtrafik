var geocoder;
var map;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();

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
	directionsDisplay.setMap(map);
}
google.maps.event.addDomListener(window, 'load', initialize);

function dropFromMarker()
{
	var address = document.getElementById("posting_from_address").value;
	
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
	var address = document.getElementById("posting_to_address").value;
	
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

function calculateRoute()
{
	var start = document.getElementById('from_address').value;
  var end = document.getElementById('to_address').value;
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

jQuery(function($) {
	$("#posting_date").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0
		});
		$("#starting_time").timepicker({
			minuteStep: 5
		});
		$("#ending_time").timepicker({
			minuteStep: 5
		});
});