var markersArray=[];
var lonlatArray=[];
var colorIndex=0;

function addMarker(location){
	marker=new google.maps.Marker({
		position:location,
		icon:"image/"+colors[colorIndex][0]+".png",
		map:map
	});
	markersArray.push(marker);
	lonlatArray.push({
			location:location,
			col:colors[colorIndex][1]
	});
	colorIndex=(colorIndex+1)%colors.length;
	//plotDrifter(location);
}

function showTrajectory(){
/*	lon1=lonlatArray[0].lng();
	lat1=lonlatArray[0].lat();
	$.get("servlet/Trajectory",
			{
				lon1:lon1,
				lat1:lat1
			},
		function(data){
				plotDrifter(data);
			});*/
	
	if (lonlatArray.length==0){
		alert("Please select at least 1 location");
		return;
	}
	
	var parameters="n="+lonlatArray.length;
	for (var i=0;i<lonlatArray.length;i++){
		parameters+="&";
		parameters+="lon"+i+"="+lonlatArray[i].location.lng();
		parameters+="&";
		parameters+="lat"+i+"="+lonlatArray[i].location.lat();
	}
	$.get("servlet/Trajectory?"+parameters,
			function(data)
			{
				plotDrifter(data);
			}
	);
	
/*	$('#map_canvas').after(
			"<img class=\"loading\" src=\"./image/loading.gif\" /> "
			);*/
	
	
	var d=new Date();
	
	$('#map_canvas').after(
		      "<div id=\"loading\" style=\"position:absolute; left: 400px; top: 100px; background-color: #FFF;\">"+
		        "<p><img src=\"image/loading2.gif\" width=\"200\" height=\"200\" /> </p>"+
		        "<p>72 hours trajectory prediction <br/>starting from 0:00 "+(d.getMonth()+1).toString()+"/"
		        +d.getDate().toString()+"/"+(d.getYear()+1900).toString()+
		        "</p><br/></div>"
			);
	
	//Solve the compatibility issue of IE 7.0
	if ($.browser.version!="7.0")
		$('#map_canvas').fadeTo('slow',0.8);
	
	//Solve the compatibility issue of IE
	if ($.browser.msie==true)
	{
		document.getElementById("start").disabled="disabled";
		document.getElementById("adddrift").disabled="disabled";
		$('#loading').fadeTo('slow',0.7);
	}
	else{
		$('input:button')[0].disabled="disabled";
		$('input:button')[1].disabled="disabled";
	}

}

function plotDrifter(data){
	
	$('#loading').remove();
	
	if ($.browser.version!="7.0")
		$('#map_canvas').fadeTo('slow',1);
	
	if ($.browser.msie==true)
	{
		document.getElementById("start").disabled="";
		document.getElementById("adddrift").disabled="";
	}else{
		$('input:button')[0].disabled="";
		$('input:button')[1].disabled="";
	}
	

	
	//path.push(location);
	
	var locations=data.split("\n");
	for (i=0;i<locations.length-1;i++){
		
	    //For the drifter
	    var polyOptions = {
	    strokeColor: lonlatArray[i].col,
	    strokeOpacity: 1.0,
	    strokeWeight: 3
	   }
		
		poly = new google.maps.Polyline(polyOptions);
	 	poly.setMap(map);
		
		var path=poly.getPath();
		
		
		var lonlats=locations[i].split(";");
		for(j=0;j<lonlats.length-1;j++)
		{
			var lonlat=lonlats[j].split(",");
			path.push(new google.maps.LatLng(lonlat[1],lonlat[0]));		//first lat, second lon
		}
	}
/*	
	lat=location.lat();
	lng=location.lng();
	for(i=0;i<7;i++){
		lat+=Math.random();
		lng+=Math.random();
		path.push(new google.maps.LatLng(lat,lng));
	}*/
}


function addDrifter(){
	var lon=$('#txt_lon').val();
	var lat=$('#txt_lat').val();
	if (lat==null || lon==null){
		alert("Input is invalid");
		return;
	}
	else{
		google.maps.event.trigger(map,'click',{latLng:new google.maps.LatLng(lat,lon) });
	}
}

function test(){
	$('#map_canvas').after(
		      "<div id=\"loading\" style=\"position:absolute; left: 400px; top: 100px; background-color: #FFF;\">"+
		        "<p><img src=\"image/loading2.gif\" width=\"200\" height=\"200\" /> </p>"+
		        "<p>72 hours trajectory prediction <br/>starting from 0:00 today</p><br/></div>"
			);
	
	//$('#map_canvas').css('filter',"progid:DXImageTransform.Microsoft.Alpha(Opacity=60)");
	$('#loading').fadeTo('slow',0.8);
	
//    var polyOptions = {
//    	    strokeColor: '#FF0000',
//    	    strokeOpacity: 1.0,
//    	    strokeWeight: 3
//    	   }
//	poly = new google.maps.Polyline(polyOptions);
// 	poly.setMap(map);
//	
//	var path=poly.getPath();
//	for(i=0;i<5;i++){
//		path.push(new google.maps.LatLng(26+i,-91+i));		
//	}
}