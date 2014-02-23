var from_autocomplete, to_autocomplete;
function initialize() {
  // Create the autocomplete object, restricting the search
  // to geographical location types.
  from_autocomplete = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('from_address')),
      { types: ['geocode'] });
  to_autocomplete = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('to_address')),
      { types: ['geocode'] });

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

function geolocate(autocomplete) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}

$(function() {
	$("#driving").chosen({no_results_text: "Bulunamadi"});
	
  $("#show-results .pagination a").bind("click", function(event) {
		$(".pagination").html("Yukleniyor...");
    $.getScript(this.href);
		return false;
  });
	
	$("#from_address").keyup(function() {
	    $.get($("#filter-posting-search").attr("action"), $("#filter-posting-search").serialize(), null, "script");
	    return false;
  });
	
	$("#to_address").keyup(function() {
    $.get($("#filter-posting-search").attr("action"), $("#filter-posting-search").serialize(), null, "script");
    return false;
  });
	
	$("#driving").change(function() {
    $.get($("#filter-posting-search").attr("action"), $("#filter-posting-search").serialize(), null, "script");
    return false;
  });
	
	$("#date").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0, maxDate: 150
	});
	
	$("#date").change(function() {
    $.get($("#filter-posting-search").attr("action"), $("#filter-posting-search").serialize(), null, "script");
    return false;
  });
	
	initialize();
	
	$("#from_address").on('focus', function(){
		geolocate(from_autocomplete);
	});
	
	$("#to_address").on('focus', function(){
		geolocate(to_autocomplete);
	});
});