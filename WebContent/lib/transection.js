 var transect_array=[];

function showTransecton(){
	if (transect_array.length<2)
		alert("Please select two locations");
	else if (vname==null){
		alert("Please select variables");

	}
	else if (date==null){
		alert("Please select dates");
	}
	else if (time==null){
		alert("Please select time");
	}	
	
	else
	{
		var lon1=transect_array[0].lng();
		var lat1=transect_array[0].lat();
		var lon2=transect_array[1].lng();
		var lat2=transect_array[1].lat();
		
		
		parameters="lon1="+lon1+"&lat1="+lat1+"&lon2="+lon2+"&lat2="+lat2
						+"&vname="+vname+"&date="+date+"&time="+time;
	
		/*
		$('#img_section').attr("src","servlet/transect?"+parameters);
		*/
		
		//Rather than display figure below the map, we pop up a new window instead
		newwindow=window.open("new_window.jsp?"+parameters,'transect','height=600,width=600');
		if (window.focus) {newwindow.focus()}
		
	}
}
