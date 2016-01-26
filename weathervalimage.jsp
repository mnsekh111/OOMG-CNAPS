<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
<%@ page import="java.util.Arrays" %>



<!DOCTYPE html>
<html lang="en-US" style="width:655px; height:475px;">
<head>
<title>CNAPS Coupled Northwest Atlantic Prediction System</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<link type="text/css" href="layout.css" rel="stylesheet">
<script type="text/javascript"
    src="http://maps.google.com/maps/api/js?sensor=false">
</script>

	<link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />   
	<link rel="stylesheet" href="/css/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.js"></script>
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.min.js"></script>
	<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script> 
	<script src="./development-bundle/ui/jquery.ui.button.js"></script> 
	<script src="./jquery/development-bundle/external/jquery.bgiframe-2.1.2.js"></script> 
	<script src="./development-bundle/ui/jquery.ui.core.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.mouse.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.draggable.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.position.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.resizable.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.dialog.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script> 
	

	<script type="text/javascript" src="./lib/loadImage.js"></script>
<script type="text/javascript" src="./lib/animation.js"></script>
<script type="text/javascript" src="./lib/val.js"></script>
<script type="text/javascript" src="./lib/global.js"></script>
<script type="text/javascript" src="./lib/weather.js"></script>

<script type="text/javascript">
  var buoy_date="<%=request.getParameter("date") %>";
  var buoy= "<%=request.getParameter("buoy")%>";
  var root="<%=Global.val_figures_location %>"; 
  var day="<%=request.getParameter("day") %>";
  var variable="<%=request.getParameter("variable") %>";
 
  $(document).ready(function () {
  		initialize();
});

  function initialize() {  
       
    $(function(){
		
		//$( "#buoy" ).buttonset();
		$( "#buoy-time-list" ).buttonset();
    });

    

	$('#buoy-time-list > input').bind("click",
			function(){
				buoy_date=this.id;
				$.get(	"servlet/WeatherValServlet?"+
						"day="+buoy_date.substring(0,8)+"&"+
						"date="+buoy_date+"&"+"buoy="+buoy, function(data){
						if (data=="fail"){
							alert("Sorry, this data is not available yet.");
							return;
						}});
				
				document.getElementById("weathervalimage").src="servlet/WeatherValServlet?"+"day="+buoy_date.substring(0,8)+"&"+"date="+buoy_date+"&buoy="+buoy+"&variable="+variable;
				//document.getElementById("hfimage").src="http://omgsrv1.meas.ncsu.edu:8080/ocean-circulation/servlet/ValServlet1?day=20121110&hfdate=20121110_0000";
				setTimeout("reload",5000);
	});
	
	$(function() {
		$( "#datepicker2" ).datepicker({
	             changeMonth: true,
				 changeYear: true,	
				 onSelect: function(dateText,inst){
			 		loadMoreDates2(dateText);
			 	}
		});
	});

    //InitLatlng(map);
    
   
    $(function() {
 	   document.getElementById("weathervalimage").src="servlet/WeatherValServlet?"+"day="+day+"&"+"date="+buoy_date+"&buoy="+buoy+"&variable="+variable;
 	});

}
  
  	
	</script> 
</head>


<body style="width=665px, height=475px">

		<img id="weathervalimage" src="" alt="Sorry, the image is not available yet", height="329" width="642" />
		
	
</body>
</html>
