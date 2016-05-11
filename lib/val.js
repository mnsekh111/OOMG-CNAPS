
var overlayvalidation;
var window_handle;
var window_handle2;

function setDate(t1,t2){
	d1=new Number(t1).toString();
	d2=new Number(t2).toString();

	if (d2.length==1)
		d2='0'+d2;
	date=d1+"_"+d2+"00";
}

function setbackground(){
	
	
	//Clear the previous overlay
	if (overlayvalidation!=null)
		overlayvalidation.setMap(null);
	//if animation is running, return
	//if($('input:button')[0].disabled==true)
	//	return;
	
	d1=hfdate.substring(0, 8);
	overlayvalidation=null;
	
	//if(ifhf)
	//	overlayvalidation=new google.maps.GroundOverlay(
	//			"servlet/ValServlet2",imageBounds);
	
	//overlayvalidation.setMap(map);

	//google.maps.event.addDomListener(window,'load',Init_hfradar_map);
	//google.maps.event.addDomListener(window,'load',Init_buoy_map);
	//else
	//	overlayvalidation=new google.maps.GroundOverlay(
	//			"servlet/ValServlet2",imageBounds);
	
	
	
	$.get(	"servlet/ValServlet1?"+
			"day="+d1+"&"+
			"date="+hfdate, function(data){
			if (data=="fail"){
				alert("Sorry1, this data is not available yet.");
				return;
			}});

}



function plotvalidation1(){
	//Clear the previous overlay
	if (overlayvalidation!=null)
		overlayvalidation.setMap(null);
	
	//if animation is running, return
	//if($('input:button')[0].disabled==true)
	//	return;

	d1=hfdate.substring(0, 8);
	
	$.get(	"servlet/ValServlet1?"+
			"day="+hfdate.substring(0, 8)+"&"+
			"hfdate="+hfdate, function(data){
			if (data=="fail"){
				alert("Sorry, this data is not available yet.");
				return;
			}});
	
		window_handle1 = window.open("servlet/ValServlet1?"+
					"day="+hfdate.substring(0, 8)+"&"+
					"hfdate="+hfdate, "Model Validation", 'height=700,width=1100' );
	
	if (window.focus) {window_handle.focus();}
	overlayvalidation=null;
	
	overlayvalidation=new google.maps.GroundOverlay(
			"servlet/ValServlet2",imageBounds);
	
	overlayvalidation.setMap(map);
	
	

}

function plotbuoy(){
	
	
	//Clear the previous overlay
	if (overlayvalidation!=null)
		overlayvalidation.setMap(null);
	
	//if animation is running, return
	if($('input:button')[0].disabled==true)
		return;

	d1=buoy_date.substring(0, 8);
	
	overlayvalidation=null;
	
	overlayvalidation=new google.maps.GroundOverlay(
			"servlet/ValServlet2",imageBounds);
	
	overlayvalidation.setMap(map);
	
	$.get(	"servlet/BuoyServlet?"+
			"day="+d1+"&"+
			"date="+buoy_date+"&"+"buoy="+buoy, function(data){
			if (data=="fail"){
				alert("Sorry, this data is not available yet.");
				return;
			}});
	
		window_handle = window.open("servlet/BuoyServlet?"+
					"day="+d1+"&"+
					"date="+buoy_date+"&"+"buoy="+buoy, "Model Validation", 'height=700,width=1100' );
	
	if (window.focus) {window_handle.focus();}

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
	$("#archive_3").css('visibility','hidden');
	$("#archive_1").css('visibility','visible');
}
function showDatepicker2()
{
	$("#archive_1").css('visibility','hidden');
	$("#archive_3").css('visibility','visible');
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
					
					//$('#time-list br').remove();
					$('#time-list input').remove();
					$('#time-list label').remove();
					
					$('#time-list').append(data);
					
				
					$( "#time-list" ).buttonset();
							
					$('#time-list > input').bind("click",
						function(){
							date=this.id;
							$.get("servlet/ValServlet3?"+
				    				"day="+hfdate.substring(0, 8)+"&"+
				    				"date="+hfdate, function(data){
				    							if (data=="fail"){
				    								alert("Sorry, this data is not available yet.");
				    								return;
				    							}});
				    		Change_hfradar_map();
					});
					
					//$("#archive_1").css('visibility','hidden');
				}
				else{
					//else  no
					alert("This date is not available");
				}
			});	
}

function loadMoreDates2(dateText)
{
	//first to see if this date is available
	$.get("servlet/TimeInquiry2",
			{
				date:dateText
			},
			function(data){
				if (data!="no"){
					//if yes
					
					//$('#buoy-time-list br').remove();
					$('#buoy-time-list input').remove();
					$('#buoy-time-list label').remove();
					
					$('#buoy-time-list').append(data);
					
				
					$( "#buoy-time-list" ).buttonset();
							
					$('#buoy-time-list > input').bind("click",
						function(){
							buoy_date=this.id;
							if(buoy!==null)
							{
								$.get(	"servlet/BuoyServlet?"+
										"day="+buoy_date.substring(0,8)+"&"+
										"date="+buoy_date+"&"+"buoy="+buoy, function(data){
										if (data=="fail"){
											alert("Sorry, this data is not available yet.");
											return;
										}});
								Change_buoy_map();
							}
					});
					
					//$("#archive_3").css('visibility','hidden');
				}
				else{
					//else  no
					alert("This date is not available");
				}
			});	
}
