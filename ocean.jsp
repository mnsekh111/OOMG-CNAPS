<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="method.TimePeriod" %>
<%@ page import="util.Global" %>
<%@ page import="java.util.Arrays" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en-US">
<head>
<title>CNAPS Coupled Northwest Atlantic Prediction System</title>
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
  var variable="uv";
  var date;
 
  $(document).ready(function () {
  		initialize();
});
  
  function initialize() { 
    $(function() {
		$( "#variables" ).buttonset();
		$( "#depth" ).buttonset();
			$( "#time-list" ).buttonset();
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
  	
  	$(function() {
  	    $( "#download" )
  	      .button()
  	      .click(function() {
  	      	document.getElementById('download').href = circulation_figure_location+d1.substring(0,6)+"/"+d1+"/"+date+"_"+variable+"_"+depth+".kmz";
  	      });
  	  });
				
	mapInit();
    //InitLatlng(map);
    //To display the default figure (current day, 0 meter, uv) on the map
    var d=new Date();
    var month=d.getMonth()+1;
    var day_0=d.getDate();
    if (month<10)
    	month="0"+month.toString();
    else
    	month=month.toString();
    if (day_0 <10)
    	day_0="0"+day_0.toString();
    else
    	day_0=day_0.toString();
    var s=(d.getYear()+1900).toString()+month+day_0+"_0000";
    $('#'+s).click();
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
<body>
    <div id="page">
	    <div id="logo">
			<img src="image/bannerCNAPS.png" width="1140" height = "120">
		</div>
		<div id="box">
            <div id="links" >
			    <jsp:include page="links.jsp"></jsp:include>
		    </div><!-- end div "links" -->
            <div id="title">Ocean Circulation
		    </div>
            <div id="map">
                <form>
                    <div id="variables">
            	        <span class="text">Variables:</span>
            	        <input value="Temperature" type="radio" id="t" name="radio"  /><label for="t">Temperature</label>
				        <input type="radio" id="s" name="radio"   /><label for="s">Salinity</label>
				        <input type="radio" id="uv" name="radio"  checked="checked" /><label for="uv">Current</label>
                    </div>  <!--  end div id "variables"  -->
                </form>
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

		            </div> <!-- end div id "depth" -->
		        </form>
                <div id="date">
                    <form>
                        <div id="time-list">
		  	                <p style="text-align:left;">Date and Time:</p>
			 <%
				TimePeriod tp=new TimePeriod();
				ArrayList<String> tmp=tp.getTimePeriod();
				
				//Only last 7 days is needed
				List<String> dates=tmp.subList(tmp.size()-7,tmp.size());
			
				%>
				<script type="text/javascript">
					date=<%=dates.get(dates.size()-4) %>+"_0000";
				</script>
				<% 
				
				for (int i=0;i<dates.size();i++)
				{
				
					%>
					<script>
						availableDates.push(<%=dates.get(i)%>);
					</script>
					<%
				
					for (int j=0;j<=21;j+=3)
					{
						String str_date=dates.get(i)+"_";
						if (j<10)
							str_date+="0";
						str_date+=String.valueOf(j)+"00";		
						String str_date_format=dates.get(i).subSequence(4,6)+"/"+dates.get(i).substring(6,8)+"/"+dates.get(i).substring(0,4)
										+" "+str_date.substring(9,11)+":"+str_date.substring(11);
					
					%>
					 <!--  [if IE]>
						<br/><input type="radio" id="<%=str_date%>" name="radio" class="ui-helper-hidden-accessible"/>
						 <label for="<%=str_date%>" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
						 		<span class="ui-button-text"><%=str_date_format%></span>
						 </label>
		  			<![endif]-->
		  			
						<input type="radio" id="<%=str_date%>" name="radio" /><label for="<%=str_date%>"><%=str_date_format%></label>
					<%
					}				
				}				
			 %>  
			            </div>  <!-- end div id "time-list" -->
		            </form>
		            <div id="archive_0">
		 			    Choose a date to populate the Date and Time list: <input type="text" id="datepicker"> 
		 		    </div> <!-- end div id "archive_0" -->
                    <br><br>
                    <div id="animationbutton">
                        <form>
			                <input type="button" id="start" OnClick="foo();" value="Start animation"/>
			                <input type="button" OnClick="stopCount();" disabled="disabled" value="Stop"/>
			            </form>
                    </div>  <!-- end div id "animationbutton" -->
                    <a id="download" href="#" >Download</a>

                    <div id="description">
		       	        <h1>Instructions</h1>
                  	        <ul>
		            	        <li><strong>Date and Time:</strong> Click on the date and time from the list to be shown on the map. Dates before the present can be selected to populate the Date and Time list. </li>
      					        
                                <li><strong>Depth:</strong> Click on the depth isosurface to display. Current at 0 m shows currents, wind vectors (magenta arrows), and sea surface height (colors).</li>
                                <li><strong>Variables:</strong> Click on the variable to be shown on the map.</li> 
                                <li><strong>Animation:</strong> Click on &quot;Start animation&quot; to display the 72 hour forecast from today. Click on &quot;Stop&quot; to terminate the animation. Please allow the animation to run through once before it becomes smooth.</li>
                   		        <li><strong>Download:</strong> Click Download to save a copy of the map (as a KMZ file).</li>
     				        </ul>
	        	    </div><!-- end div "description"  -->
                 </div>  <!-- end div "date"  -->
            </div>  <!-- end div "map"  -->
	        <div id="footer">
	        	<jsp:include page="footer.jsp"></jsp:include>
	        </div>  <!-- end div "footer"  -->
	    </div>  <!-- end div "box"  -->
    </div>  <!-- end div "page"  -->
</body>
</html>
