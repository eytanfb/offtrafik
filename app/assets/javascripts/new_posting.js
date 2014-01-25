jQuery(function($) {
				
	$(".standard-datepicker").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0
	});
		
	$(".frequent-datepicker").datepicker({ 
			dateFormat: 'dd-mm-yy', minDate: 0, maxDate: 150
	});
		
	var times = $("#posting").find(".timepicker");
	
	times.timepicker({
		minuteStep: 5,
		showMeridian: false,
		defaultTime: 'value'
	});	
		
	$("#standard-posting .posting-button").click(function(){
		event.preventDefault();
		$('#standard-posting .posting-button').addClass('hidden');
		$('#standard-posting .items').toggle(500).removeClass('hidden');
		if($("#frequent-posting .posting-button").hasClass('hidden')){
			$('#frequent-posting .items').hide(500).addClass('hidden');
			$('#frequent-posting .posting-button').show(500).removeClass('hidden');	
		}
	});
	
	$("#frequent-posting .posting-button").click(function(){
		event.preventDefault();
		$('#frequent-posting .posting-button').addClass('hidden');
		$('#frequent-posting .items').toggle(500).removeClass('hidden');
		if($("#standard-posting .posting-button").hasClass('hidden')){
			$('#standard-posting .items').hide(500).addClass('hidden');
			$('#standard-posting .posting-button').show(500).removeClass('hidden');	
		}
	});
});