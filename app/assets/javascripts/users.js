// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

var geocoder;
var map;
var infowindow = new google.maps.InfoWindow();

function initialize()
{
	var hometown = document.getElementById("neighborhood").innerHTML;
	var name = document.getElementById("user-name-heading").innerHTML;
	var pastFromAddressElements = document.getElementsByClassName("past-from-address");
	var pastFromAddress = [];
	var pastToAddressElements = document.getElementsByClassName("past-to-address");
	var pastToAddress = [];
	geocoder = new google.maps.Geocoder();
	
	for(var i = 0; i < pastFromAddressElements.length; i++)
	{
		pastFromAddress[i] = pastFromAddressElements[i].innerHTML;
	}
	
	for(var i = 0; i < pastToAddressElements.length; i++)
	{
		pastToAddress[i] = pastToAddressElements[i].innerHTML;
	}

	var latlng = new google.maps.LatLng(41.1136, 28.9750);
	var myOptions = {
	  zoom: 9,
	  center: latlng,
	  mapTypeId: 'roadmap'
	}
	map = new google.maps.Map(document.getElementById("map"), myOptions);
	// setCenterToAddress('Istanbul');
	addHomeTownMarker(hometown, name);
	addMarkers(pastFromAddress, "http://maps.google.com/mapfiles/ms/icons/red-dot.png");
	addMarkers(pastToAddress, "http://maps.google.com/mapfiles/ms/icons/green-dot.png");
}

function addMarkers(addresses, icon) {
	for(var i = 0; i < addresses.length; i++)
	{
		addAddressMarker(addresses[i], icon);
	}
}

function addHomeTownMarker(hometown, name)
{
  geocoder.geocode({'address': hometown}, function(results, status)
  {
      if (status == google.maps.GeocoderStatus.OK) {
          var marker = new google.maps.Marker({
              position: results[0].geometry.location,
              map: map,
							icon: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"
          });
          google.maps.event.addListener(marker, 'click', function() {
              if (!infowindow) {
                  infowindow = new google.maps.InfoWindow();
              }
              infowindow.setContent(name);
              infowindow.open(map, marker);
          });					
      }
  });
}

function addAddressMarker(address, icon)
{
  geocoder.geocode({'address': address}, function(results, status)
  {
      if (status == google.maps.GeocoderStatus.OK) {
          var marker = new google.maps.Marker({
              position: results[0].geometry.location,
              map: map,
							icon: icon
          });
          google.maps.event.addListener(marker, 'click', function() {
              if (!infowindow) {
                  infowindow = new google.maps.InfoWindow();
              }
              infowindow.setContent(address);
              infowindow.open(map, marker);
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
			map.setZoom(9);
		}
	});
}
google.maps.event.addDomListener(window, 'load', initialize);

$(function(){
  $("#user-comments .pagination a").bind("click", function(event) {
		$(".pagination").html("Yukleniyor...");
    $.getScript(this.href);
		return false;
  });
	$("#user-neighborhood").chosen({no_result_text: "Ilce bulunamadi"});
});