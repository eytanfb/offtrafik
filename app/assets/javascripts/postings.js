jQuery(function($) {
		
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