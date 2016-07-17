<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>CNAPS Coupled Northwest Atlantic Prediction System</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

<script type="text/javascript"
    src="http://maps.google.com/maps/api/js?sensor=false">
</script>
	<link type="text/css" href="layout.css" rel="stylesheet">
	<link type="text/css" href="reset.css" rel="stylesheet">
	<link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />   
	<link rel="stylesheet" href="/css/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.js"></script>
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.min.js"></script>
	<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.button.js"></script> 
	<script src="./jquery/development-bundle/external/jquery.bgiframe-2.1.2.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script> 
	<script type="text/javascript" src="./lib/loadImage.js"></script>
   	<script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script>
    <script type="text/javascript" src="./lib/animation.js"></script>
    <script type="text/javascript" src="./lib/trajectory.js"></script>
    <script type="text/javascript" src="./lib/listener.js"></script>
    <script type="text/javascript" src="./lib/showLatLng.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>
    <script type="text/javascript" src="./lib/transection.js"></script>
    <script type="text/javascript" src="./lib/maps.google.polygon.containsLatLng.js"></script>

<script type="text/javascript">
  var map;
  var overlaysArray=[];
  var vname="temp";
  var date;
  var time;

  function initialize() {
     
	 mapInit();
     
     InitLatlng(map);
         	
  	google.maps.event.addListener(map, 'click', function(event) {
  	 if(limitArea_polygon.containsLatLng(event.latLng)){
		if (transection_array.length<2){
    	marker=new google.maps.Marker({
			position:event.latLng,
			map:map
		});
    	transection_array.push(event.latLng);
	 }
	 }
	else{
		alert("Sorry, this is outside our support domain.");
	
		}
  	}); 
  	
  	$(function() {
		$( "#variables" ).buttonset();
		$( "#time-list" ).buttonset();
		$( "#time" ).buttonset();
		//$( "#variables" ).buttonset();
	});
	
	$('#variables > input').bind("click",
			function(){
				vname=this.id;
						});
	$('#time-list > input').bind("click",
			function(){
				date=this.id;
						});
 	$('#time > input').bind("click",
			function(){
				time=this.id;
						});  
 	$(function() {
		$( "#datepicker" ).datepicker({
	             changeMonth: true,
				 changeYear: true,	
				 
				 //Date range from Feb to Aug of current year
				 maxDate: max_date,
				 minDate: min_date,
				 
				 onSelect: function(dateText,inst){
			 		changeDate(dateText,null);
			 	}
		});
	});
}

</script>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-12288686-5']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</head>
<body onLoad="initialize()">

<div id="page">
		<div id="logo" >
			<img src="image/bannerCNAPS.png" width="1140" height = "120">
		</div>
		
	<div id="box">
		<div id="links" >
			<jsp:include page="links.jsp"></jsp:include>
		</div>

		<div id="map">
		  <div id="map_canvas"></div>
					<form>
						<div id="variables">
							<span class="text">Variables:</span>
					      	<input type="radio" id="temp" name="radio"  checked="checked"/><label for="temp">temperature</label> 
					        <input type="radio" id="salt" name="radio"   /><label for="salt">salinity</label> 
					      	<input type="radio" id="u" name="radio"  /><label for="u">u</label> 
					      	<input type="radio" id="v" name="radio"  /><label for="v">v</label>
		            	</div>
					</form>
					
					
					<div id="date">
						<div id="description">
					      <p>Instruction:</p>
					      <p>Select two locations on the map and the criteria below, click on &quot;Show transect&quot;</p>
						</div>
						<form>
							<div id="time-list"  style= "margin-top:10px;" >
							<span class="text">Dates:</span>
								<%
									TimePeriod tp=new TimePeriod();
									ArrayList<String> dates=tp.getTimePeriod();
									for(int i=dates.size()-4;i<dates.size();i++)
									{
										String str_date_format=dates.get(i).subSequence(4,6)+"/"+dates.get(i).substring(6,8)+"/"+dates.get(i).substring(0,4);
										%>
											<input type="radio" id="<%=dates.get(i)%>" name="radio" /><label for="<%=dates.get(i)%>"><%=str_date_format%></label>							
										<%
									}
								%>	
					  		</div>
					  	</form>
					  
					  <form>
							<div id="time">
								<span class="text">Time:</span>
							  <% for (int i=0;i<=21;i+=3)
							  {
							  		double value=i;
							   %>
							  	<input type="radio" id="<%=value/24.0  %>" name="radio"/><label for="<%=value/24.0%>"> <%=i %>:00</label>
							  <%
							  } 
							  %>
							</div>
					 </form>
					 
					 <div id="archive_0">
		  	                Choose a date to populate the Date and Time box: <input type="text" id="datepicker"> 	
		                </div>  <!-- end div id "archive_0" -->
					 
					 <form>
			            <div id="animationbutton" style="top:100px;">
							<input type="button" onClick="showTransecton();" value="Show Transect"/>
			        		<input type="button" onClick="window.location.href=window.location.href" value="Clear"/>
						</div>
					 </form>
				 
				 
				 </div>
		
			</div>

		</div>
		
		<div id="footer">
	        	<jsp:include page="footer.jsp"></jsp:include>
	    </div>
	</div>
</body>
</html>
