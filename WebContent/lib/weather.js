function Init_map(){
	overlayvalidation=new google.maps.GroundOverlay(
			"servlet/ValServlet2",imageBounds);

	overlayvalidation.setMap(map);
}

function Init_slp_map() {
    
	function linkevent(m){	
    	buoymarker[m].setMap(map);
		google.maps.event.addListener(buoymarker[m],'click',function(e){
			window.open("weathervalimage.jsp?day="+buoy_date.substring(0,8)+"&date="+buoy_date+"&buoy="+buoyid[m]+"&variable="+variable,
					"Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=665' );
		});
	}
	
	for(var i=0;i<20;i++)
	{
		linkevent(i);
	}
}
function Hide_slpmap(){
	overlayvalidation.setMap(null);
	for(var i=0;i<20;i++)
		buoymarker[i].setMap(null);
}

function Change_slp_map() {
	
	overlayvalidation.setMap(null);
		
	overlayvalidation=new google.maps.GroundOverlay(
			"servlet/WeatherValServlet?"+
			"day="+buoy_date.substring(0,8)+"&"+
			"date="+buoy_date+"&buoy="+buoy+"&variable="+variable,imageBounds);

	overlayvalidation.setMap(map);
	
}

function Init_wsp_map() {
    
	function linkevent(m){	
    	buoymarker[m].setMap(map);
		google.maps.event.addListener(buoymarker[m],'click',function(e){
			window.open("weathervalimage.jsp?day="+s.substring(0,8)+"&"+"date="+s+"&"+"buoy="+buoyid[m],
					"Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=665' );
		});
	}
	
	for(var i=0;i<20;i++)
	{
		linkevent(i);
	}
}
function Hide_wspmap(){
	overlayvalidation.setMap(null);
	for(var i=0;i<20;i++)
		buoymarker[i].setMap(null);
}

function Change_wsp_map() {
	
	overlayvalidation.setMap(null);
		
	overlayvalidation=new google.maps.GroundOverlay(
			"servlet/WeatherValServlet?"+
			"day="+buoy_date.substring(0,8)+"&"+
			"date="+buoy_date+"&buoy="+buoy+"&variable="+variable,imageBounds);

	overlayvalidation.setMap(map);
	
}
function Init_2mtemp_map() {
    
	function linkevent(m){	
    	buoymarker[m].setMap(map);
		google.maps.event.addListener(buoymarker[m],'click',function(e){
			window.open("weathervalimage.jsp?day="+s.substring(0,8)+"&"+"date="+s+"&"+"buoy="+buoyid[m],
					"Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=665' );
		});
	}
	
	for(var i=0;i<20;i++)
	{
		linkevent(i);
	}
}
function Hide_2mtempmap(){
	overlayvalidation.setMap(null);
	for(var i=0;i<20;i++)
		buoymarker[i].setMap(null);
}

function Change_2mtemp_map() {
	
	overlayvalidation.setMap(null);
		
	overlayvalidation=new google.maps.GroundOverlay(
			"servlet/WeatherValServlet?"+
			"day="+buoy_date.substring(0,8)+"&"+
			"date="+buoy_date+"&buoy="+buoy+"&variable="+variable,imageBounds);

	overlayvalidation.setMap(map);
	
}
