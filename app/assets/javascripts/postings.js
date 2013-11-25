jQuery(function($) {
				
	neighborhoods = $("#_find_posting_from_address_neighborhood").html();
	
	$("#from_address_district").change(function(){
		district = $("#from_address_district :selected").text();
		options = $(neighborhoods).filter("optgroup[label='" + district + "']");
		if(options){
			$("#_find_posting_from_address_neighborhood").html(options);		
		}
		
	});
	
	$("#to_address_district").change(function(){
		district = $("#to_address_district :selected").text();
		options = $(neighborhoods).filter("optgroup[label='" + district + "']");
		if(options){
			$("#_find_posting_to_address_neighborhood").html(options);		
		}
				
	});
	
	$("#posting_date").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0
		});
		
		makeTimepicker("#starting_time");
		makeTimepicker("#ending_time");
});

function makeTimepicker(divId){
	$(divId).timepicker({
		minuteStep: 5,
		showMeridian: false,
		defaultTime: 'value'
	});
}