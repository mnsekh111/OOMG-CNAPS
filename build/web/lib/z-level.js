
var overlay;
var overlaykml;


function setDate(t1,t2){
	d1=new Number(t1).toString();
	d2=new Number(t2).toString();

	if (d2.length==1)
		d2='0'+d2;
	date=d1+"_"+d2+"00";
}

function plot(){

	//Clear the previous overlay
	if (overlay!=null)
		overlay.setMap(null);
	
	//if animation is running, return
	if($('input:button')[0].disabled==true)
		return;

	d1=date.substring(0, 8);

	overlay=null;
	
	
	$.get(	circulation_figure_location+d1.substring(0,6)+"/"+d1+"/"+date+"_"+variable+"_"+depth+".kmz"
			, function(data){
			if (data==""){
				alert("Sorry, this data is not available yet.");
				return;
			}});
	
	overlay=new google.maps.KmlLayer(
			circulation_figure_location+d1.substring(0,6)+"/"+d1+"/"+date+"_"+variable+"_"+depth+".kmz"
			,imageBounds);
	
	overlay.setMap(map);
	
	/*overlaykml = new google.maps.KmlLayer("http://www.vta.org/bike_information/scc_bikeways.kmz");
	overlaykml.setMap(map);*/
}

function test2(){
	t=new google.maps.GroundOverlay(
			"image/sample.png"
			,imageBounds);

	t.setMap(map);	
}

function test()
{
		var $dialog = $('<div></div>')
			.html('<div id=\"datepicker\"></div>')
			.dialog({
				title:"Select Date:",
				autoOpen: false,
				modal:true,
				height:200,
				open: function() { 
			     $("#ui-datepicker-div").css("z-index", 
			$(".ui-dialog").css("z-index")+1); 
			} 
			});
		$( "#datepicker" ).datepicker({
	             changeMonth: true,
				 changeYear: true	
		});
		$dialog.dialog('open');
}

function showDatepicker()
{
	$("#archive_1").css('visibility','visible');
}

function loadMoreDates(dateText)
{
	//first to see if this date is available
	$.get("servlet/TimeInquiry",
			{
				date:dateText
			},
			function(data){
				if (data!="no"){
					//if yes
					
					$('#time-list br').remove();
					$('#time-list input').remove();
					$('#time-list label').remove();
					
					$('#time-list').append(data);
					
				
					$( "#time-list" ).buttonset();
							
					$('#time-list > input').bind("click",
						function(){
							date=this.id;
							plot();
								});
					
					$("#archive_1").css('visibility','hidden');
				}
				else{
					//else  no
					alert("This date is not available");
				}
			});	
}
