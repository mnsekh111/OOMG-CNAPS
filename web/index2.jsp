<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
<%@ page import="java.util.Arrays" %>
<%@page import="util.Log"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<link type="text/css" href="layout.css" rel="stylesheet">
<link type="text/css" href="reset.css" rel="stylesheet">
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
	<script src="./jquery/development-bundle/ui/jquery.ui.button.js"></script> 
	<script src="./jquery/development-bundle/external/jquery.bgiframe-2.1.2.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.mouse.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.draggable.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.position.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.resizable.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.dialog.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script> 

	
	
	<script type="text/javascript" src="./lib/loadImage.js"></script>
<script type="text/javascript" src="./lib/animation.js"></script>
<script type="text/javascript" src="./lib/z-level.js"></script>
<script type="text/javascript" src="./lib/global.js"></script>
<script type="text/javascript">
  var map;
  var overlaysArray=[];
  var root="<%=Global.figures_location %>"; 
  
  var depth="0";
  var variable="t";
  var date;
 
  $(document).ready(function () {
  		initialize();
});
  
  function initialize() { 
            InitLatlng(map);
       
    $(function() {
		$( "#variables" ).buttonset();
		$( "#depth" ).buttonset();
		$( "#time-list" ).buttonset();
		$("#archive").buttonset();
	});

	$('#variables > input').bind("click",
			function(){
				variable=this.id;
				plot();
						});
	$('#time-list > input').bind("click",
			function(){
				date=this.id;
				plot();
						});
 	$('#depth > input').bind("click",
			function(){
				depth=this.id;
				plot();
				});      					
	
	$(function() {
		$( "#datepicker" ).datepicker({
	             changeMonth: true,
				 changeYear: true,	
				 onSelect: function(dateText,inst){
			 		loadMoreDates(dateText);
			 	}
		});
	});
	
  	$(document).ready(function(){
  		$("#showtext").click(function(){
  			$("#description").toggle();
  		});
  	});
	
  	$(function(){
  		$("#showtext").button({
  			icons: {
  				primary: "ui-icon-plusthick"
  			},
  			text: false
  		});
  	});
  	
  	$(document).ready(function(){
  		$("#description").hide();
  	});
				
				
	map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);  
          
    map.setMapTypeId(google.maps.MapTypeId.ROADMAP);   
}
  
	
	</script> 

</head>
<body>

<div id="page">
		<div id="logo" align="center" >
			<img src="image/banner_new.png" width="1140" height = "120">
		</div>
		<div id="box">
<div id="links" >
	<jsp:include page="home_left_column.jsp"></jsp:include>
</div>

<div id="map">
      <div id="map_canvas"  > </div>

		<form>
		<div id="depth">
            <span class="text">Depth:</span>
          <br/><input type="radio" id="0" name="radio" checked="checked"/><label for="0">0m</label> 
			<br/><input type="radio" id="5" name="radio"  /><label for="5">5m</label> 
			<br/><input type="radio" id="10" name="radio" /><label for="10">10m</label> 
			<br/><input type="radio" id="15" name="radio" /><label for="15">15m</label> 
			<br/><input type="radio" id="20" name="radio"  /><label for="20">20m</label> 
			<br/><input type="radio" id="30" name="radio" /><label for="30">30m</label> 
			<br/><input type="radio" id="40" name="radio"  /><label for="40">40m</label> 
			<br/><input type="radio" id="50" name="radio"  /><label for="50">50m</label> 
			<br/><input type="radio" id="75" name="radio"  /><label for="75">75m</label> 
			<br/><input type="radio" id="100" name="radio"  /><label for="100">100m</label> 
			<br/><input type="radio" id="125" name="radio"  /><label for="125">125m</label> 
			<br/><input type="radio" id="150" name="radio"  /><label for="150">150m</label> 
			<br/><input type="radio" id="200" name="radio"  /><label for="200">200m</label> 
			<br/><input type="radio" id="250" name="radio"  /><label for="250">250m</label> 
			<br/><input type="radio" id="300" name="radio"  /><label for="300">300m</label> 
			<br/><input type="radio" id="400" name="radio"  /><label for="400">400m</label> 
			<br/><input type="radio" id="500" name="radio"  /><label for="500">500m</label> 
			<br/><input type="radio" id="600" name="radio"  /><label for="600">600m</label> 
			<br/><input type="radio" id="800" name="radio"  /><label for="800">800m</label> 
			<br/><input type="radio" id="1000" name="radio"  /><label for="1000">1000m</label> 
			<br/><input type="radio" id="1200" name="radio"  /><label for="1200">1200m</label> 
			<br/><input type="radio" id="1500" name="radio"  /><label for="1500">1500m</label> 
			<br/><input type="radio" id="2000" name="radio"  /><label for="2000">2000m</label> 

		  </div>
		  </form>

      	<div  id="para">

	
		  <form>
            <div id="variables">
            	<span class="text">Variables:</span>
            	<select name="variable">
            	<input type="radio" id="t" name="radio"  /><label for="t"><big>Temperature</big></label>
				<input type="radio" id="s" name="radio"   /><label for="s"><big>Salinity</big></label >
				<input type="radio" id="uv" name="radio"  checked="checked" /><label for="uv"><big>Current</big></label>
				</select>
           </div>
          </form>
           
           <form>
          <span class="text">Date:</span>
		  <div id="time-list" style="overflow:scroll; width: 150px; height: 450px;">
			 			 <% 			 			 
			 			 for(int i=0;i<56;i++){
			 %>
			 	<br/><input type="radio" id="aa" name="radio" /><label for="aa">aaa</label>
			 	<%
			 }
			  %>
			 
		  </div>
		  </form>
		  <form >
		  <div id="archive_0">
		  	<input type="radio" id="archive" name="radio" onclick="showDatepicker();"><label for="archive">Historical Archive</label>
		  	 <a  href="#" onClick="showDatepicker();">Historical Archive</a>	
		  </div>
		  </form>
		  <dir id="archive_1" style="visibility: hidden;">
		  		   <p>Date: <input type="text" id="datepicker"></p> 
		  </dir>
		  
                  	      <div style="position: absolute; left: -924px; top: 615px;">

  <form>
			<input type="button" id="start" OnClick="foo();" value="Start animation"/>
			<input type="button" OnClick="stopCount();" disabled="disabled" value="Stop"/>
			<input type="button" onclick="test2();" value="test"/>
			
			</form>
            </div>
            
            <p>Instruction &nbsp;&nbsp;<button id="showtext">Show Instruction</button></p>
	      	<div id="description">
	          <li>Depth: Clicking on one of these will update the layer and display the selected depth</li>
	          <li>Variables: Selecting different one can control the model variable shown</li>
	          <li>Date: Selecting one of these will update the model so that the time selected is display</li>
	          <li>Animation: Click on &quot;Start animation&quot; button will display the 72 hours forecast from today, given the selected depth and variable; Click on &quot;Stop&quot; to terminate the animation</li>
	          <li>Archive: Click and select the date of archive you want to inspect</li>
			  <p><font color="#ff0000">DISCLAIMER:
			    This nowcast/forecast system is a research product and under
			    construction.
			    No warranty is made, expressed or implied at this stage, regarding
			    the accuracy or validity of model results, or regarding the
			    suitability of the model output for any particular application. </font></p>
	        </div>
</div>
      	    
        </div>
        </div>
	        <div id="footer">
	        	<jsp:include page="footer.jsp"></jsp:include>
	        </div>
        </div>
</body>
</html>
