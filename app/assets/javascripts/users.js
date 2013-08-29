// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

var geocoder;
var map;

function initialize()
{
	geocoder = new google.maps.Geocoder();

	var latlng = new google.maps.LatLng(52.40, -3.61);
	var myOptions = {
	  zoom: 3,
	  center: latlng,
	  mapTypeId: 'roadmap'
	}
	map = new google.maps.Map(document.getElementById("map"), myOptions);
	setCenterToAddress('Istanbul');
	addHomeTownMarker(hometown, avatar);
}

function addHomeTownMarker(hometown)
{
  geocoder.geocode({'address': hometown}, function(results, status)
  {
      if (status == google.maps.GeocoderStatus.OK) {
          var marker = new google.maps.Marker({
              position: results[0].geometry.location,
              map: map,
							icon: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"
          });
      }
  });
}

function setCenterToAddress(address)
{
	geocoder.geocode({'address': address}, function(results, status)
	{
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
		}
	});
}
google.maps.event.addDomListener(window, 'load', initialize);