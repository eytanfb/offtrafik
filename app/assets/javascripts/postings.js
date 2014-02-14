$(function() {
	$(".chosen-select").chosen();
	$("#driving").chosen();	
	$("#posting-search-results").tablesorter();
	
  $("#show-results .pagination a").bind("click", function(event) {
		$(".pagination").html("Yukleniyor...");
    $.getScript(this.href);
		return false;
  });
});