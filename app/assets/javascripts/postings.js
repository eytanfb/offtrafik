$(function() {
	$(".chosen-select").chosen({no_results_text: "Semt Bulunamadi"});
	$("#driving").chosen({no_results_text: "Semt Bulunamadi"});	
	$("#posting-search-results").tablesorter();
	
  $("#show-results .pagination a").bind("click", function(event) {
		$(".pagination").html("Yukleniyor...");
    $.getScript(this.href);
		return false;
  });
});