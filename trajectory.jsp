<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
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
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.js"></script>
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.min.js"></script>
	<script type="text/javascript" src="./lib/loadImage.js"></script>
    <script type="text/javascript" src="./lib/animation.js"></script>
    <script type="text/javascript" src="./lib/trajectory.js"></script>
    <script type="text/javascript" src="./lib/listener.js"></script>
    <script type="text/javascript" src="./lib/showLatLng.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>
    <script type="text/javascript" src="./lib/maps.google.polygon.containsLatLng.js"></script>

<script type="text/javascript">
  var map;
  var overlaysArray=[];

  function initialize() {
    mapInit();
    InitLatlng(map);
  	google.maps.event.addListener(map, 'click', function(event) {
  	    if(!limitArea_polygon.containsLatLng(event.latLng)){
    		alert("Sorry, this is outside our support domain.");
    	}
    	else{
   		    addMarker(event.latLng);
    	}
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
	    <div id="logo" align="center" >
		    <img src="image/bannerCNAPS.png" width="1140" height = "120">
		</div> <!--end div id "logo" -->
		<div id="box">
            <div id="links" >
			    <jsp:include page="links.jsp"></jsp:include>
		    </div><!-- end div "links" -->
            <div id="title">Virtual Drifter Trajectory
		    </div>  <!-- end div "title" -->
		    <div id="map">
	  		    <form>		
					<input type="button" id="start" onClick="showTrajectory();" value="Show Trajectory"/>
			        <input type="button" id="clear" onClick="window.location.href=window.location.href" value="Clear"/>
				</form>
                <div id="map_canvas" >
                </div>
	  			<div id="date">
				    <div id="description">
				  	    <h1>Instructions</h1>
		        	        <p>Click in the ocean within the red box to "place" passive drifters at one or more locations.</p>
			                <p>You can also add drifters by entering latitude and longitude in the boxes. Latitude and longitude are displayed when the cursor hovers over the map. (In the model domain, latitude is positive and longitude is negative.)</p>
		        	        <form>
                                <p>Lat: <input type="text" id="txt_lat" size="7" width=> &nbsp;&nbsp;Lon: <input type="text" id="txt_lon" size="7" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="adddrift" onClick="addDrifter();" value="Add Drifter"> </p>
		                    </form>
			                <p>Click "Show Trajectory" to show the drifters' paths over 72 hours. <br/>Click "Clear" to refresh the map.</p>
	        
			                
			                <p>Depending on the number of drifters you place, this may take several minutes. Please be patient.</p>
				    </div><!-- end div "description" -->
				</div>  <!-- end div id "date" -->
		    </div>  <!-- end div id "map" -->
 	        <div id="footer">
        	    <jsp:include page="footer.jsp"></jsp:include>
            </div>
        </div>  <!--  end div id "box" -->
    </div>  <!-- end div id "page" -->
</body>
</html>
