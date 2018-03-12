<cfoutput>
<script type="text/javascript">
	
$( document ).ready(function() {

	$(".showHideButton").click(function() {
		var id = $(this).attr('id');
		var icon_id = "##icon-" + id;
		console.log( icon_id );
		$( icon_id ).toggleClass("fa-plus");
		$( icon_id ).toggleClass("fa-minus");
		$( this ).toggleClass("btn-success");
		$( this ).toggleClass("btn-light");
	});

	$("##showHideAll").click(function() {
		
		$(".collapse").each(function() {
			$( this ).toggleClass("show");
		});
		$(".showHideButton").each(function(){
			$( this ).toggleClass("btn-success");
			$( this ).toggleClass("btn-light");
		}); 
		$(".showHideIcon").each(function(){
			$( this ).toggleClass("fa-plus");
			$( this ).toggleClass("fa-minus");
		});		
		$( this ).text(function(i, text){
			return text === "Collapse All" ? "Expand All" : "Collapse All";
		});
	});


});
	

</script>
</cfoutput>