
var overlayfloat;

function setDate(t1,t2){
	d1=new Number(t1).toString();
	d2=new Number(t2).toString();

	if (d2.length==1)
		d2='0'+d2;
	date=d1+"_"+d2+"00";
}

function plotfloat(){
	
	//Clear the previous overlay
	if (overlayfloat!=null)
		overlayfloat.setMap(null);
	
	//if animation is running, return
	if($('input:button')[0].disabled==true)
		return;

	d1=date.substring(0, 8);

	overlayfloat=null;
	
	
	$.get(	"servlet/GetImage3?"+
			"day="+d1, function(data){
			if (data=="fail"){
				alert("Sorry, this data is not available yet.");
				return;
			}});
	
	overlayfloat=new google.maps.GroundOverlay(
			"servlet/GetImage3?"+
			"day="+d1,imageBounds);
	
	overlayfloat.setMap(map);	
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
	$.get("servlet/TimeInquiry2",
			{
				date:dateText
			},
			function(data){
				if (data!="no"){
					//if yes
					
					$('#time-list br').remove();
					$('#time-list input').remove();
					$('#time-list label').remove();
					
					$('#time-list > div').append(data);
					
				
					$( "#time-list" ).buttonset();
							
					$('#time-list > div > input').bind("click",
						function(){
							date=this.id;
							plotfloat();
								});
					
					$("#archive_1").css('visibility','hidden');
				}
				else{
					//else  no
					alert("This date is not available");
				}
			});	
}
