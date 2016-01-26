<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
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
<script type="text/javascript" src="./lib/animation_model.js"></script>
<script type="text/javascript" src="./lib/val.js"></script>
<script type="text/javascript" src="./lib/global.js"></script>
<script type="text/javascript">
  var map;
  var overlaysArray=[];
  var root="<%=Global.val_figures_location %>"; 
  var hfdate;
  var buoy_date;
  var buoy=null;
 
  $(document).ready(function () {
	  	getTodayStr();
  		initialize();
    });
  
  function initialize() { 
    $(function() {
    	$( "#variables" ).buttonset();
		$( "#buoy" ).buttonset();
		$( "#buoy-time-list" ).buttonset();
	});

	jQuery(document).ready(function(){
    	// this opens new window wavevalimage.jsp when a buoy is clicked in list --or on map?? If no buoy_date has been chosen, todya's date is default
		$("#buoy > input").click(function(e){
			buoy=this.id;
			if(buoy_date!=null)
			{
					window.open("wavevalimage.jsp?day="+buoy_date.substring(0,8)+"&date="+buoy_date+"&buoy="+buoy, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=800' );
			}
		});
    	});
	
	jQuery(document).ready(function(){
		//this opens a new window only if a buoy site is already chosen
    	$("#buoy-time-list > input").click(function(e){
		buoy_date=this.id;
		if(buoy!==null)
		{
			$.get(	"servlet/WaveValServlet?"+
					"day="+buoy_date.substring(0,8)+"&"+
					"date="+buoy_date+"&"+"buoy="+buoy, function(data){
					if (data=="fail"){
						alert("Sorry, this data is not available yet.");
						return;
					}});
				window_handle = window.open("wavevalimage.jsp?day="+buoy_date.substring(0,8)+"&"+"date="+buoy_date+"&"+"buoy="+buoy, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=800' );
		}
		/* else
			alert("Sorry, please select a buoy site first.");  */
		});
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
	
	$(document).ready(function(){
		//currenntly, buoybutton is set to "wave height" and is not available to be changed by user
		  $("#buoybutton").click(function(){
			  $("#buoytime").show();
			  $("#buoy").show();
			 // $("#archive_2").show();
			  Init_waveval_map();
		  });
	});
		
	/*this section shows instructions if user clicks on "+". Want instructions to show always.
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
	  	});  */
	  	
	$(document).ready(function(){
		// this shows buoy sites on map and allows them to be clicked !
		$("#buoybutton").trigger('click');
			//$("#description").hide();
	  		//$("#archive_2").hide();
	});
				
	mapInit();
    //InitLatlng(map);
    //To display the default figure (current day, 0 meter, uv) on the map
}  //end of function.initialize()
</script> 

<script type="text/javascript">
// this deals with Google Analytics page counter
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
		</div> <!--end div id "logo" -->
		<div id="box">
            <div id="links" >  <!-- this is horizontal menu at top of each page -->
			    <jsp:include page="links.jsp"></jsp:include>
		    </div><!-- end div "links" -->
            <div id="title">Model Validation: Wave Height
		    </div>  <!-- end div "title" -->
            <div id="map">
                <div id="map_canvas" > 
                </div>
  		            <form>  
                        <div id="variables" style="visibility:hidden;">
                        <!-- if Wave Height button is removed, then markers on map disappear, but since Wave Height is only variable, don't need a visible button for it -->
				            <input type="radio" id="buoybutton" name="radio" checked="checked" /><label for="buoybutton">Wave Height</label>
				            <!-- <input type="radio" id="buoybutton" name="radio"  /><label for="buoybutton">Tide Gauge</label> -->
                        </div> 
                    </form>
              
                <div id="date">
                    <form>
                        <div id="buoy">
                            <p>Buoy Stations</p>
				                <input type="radio" id="44037" name="radio"   /><label for="44037">Jordan Basin, Gulf of Maine</label>
                                <input type="radio" id="44065" name="radio"   /><label for="44065">New York Harbor</label>
                                <input type="radio" id="44014" name="radio"   /><label for="44014">Virginia Beach, VA</label>
                                <input type="radio" id="44056" name="radio"   /><label for="44056">Duck FRF, NC</label>
                                <input type="radio" id="41013" name="radio"   /><label for="41013">Frying Pan Shoals, NC</label>
                                <input type="radio" id="41002" name="radio"   /><label for="41002">South Hatteras, NC</label> 
                                <input type="radio" id="41008" name="radio"   /><label for="41008">Grays Reef, GA</label> 
				                <input type="radio" id="41012" name="radio"   /><label for="41012">St. Augustine, FL</label> 
				                <input type="radio" id="41048" name="radio"   /><label for="41048">West Bermuda</label>
				                <input type="radio" id="41047" name="radio"   /><label for="41047">Northeast Bahamas</label>
                                <input type="radio" id="41046" name="radio"   /><label for="41046">East Bahamas</label> 
				                <input type="radio" id="42036" name="radio"   /><label for="42036">West Tampa, FL</label>
                                <input type="radio" id="42012" name="radio"   /><label for="42012">Orange Beach, AL</label>
                                <input type="radio" id="LOPL1" name="radio"   /><label for="LOPL1">Oil Platform, LA</label>
                                <input type="radio" id="42003" name="radio"   /><label for="42003">East Gulf of Mexico</label>
                                <input type="radio" id="42001" name="radio"   /><label for="42001">Mid Gulf of Mexico</label>
				                <input type="radio" id="42020" name="radio"   /><label for="42020">Corpus Christi, TX</label> 
				                <input type="radio" id="42055" name="radio"   /><label for="42055">Bay of Campeche, MX</label>
				                <input type="radio" id="42056" name="radio"   /><label for="42056">Yucatan Basin</label> 
				                <input type="radio" id="42058" name="radio"   /><label for="42058">Central Caribbean</label> 
                        </div>  <!-- end div id "buoy" -->
                    </form>
                    <form>
                    <div id="buoytime">
                        <span class="text">Date:</span>
		                <div id="buoy-time-list">
			 <%
				TimePeriod tp1=new TimePeriod();
				ArrayList<String> tmp1=tp1.getTimePeriod();
				
				//Only last 30 days is needed
				List<String> dates1=tmp1.subList(tmp1.size()-15,tmp1.size());
				%>
				<script type="text/javascript">
					buoy_date=<%=dates1.get(dates1.size()-4) %>+"_0000";
				</script>
				<% 
				for (int i=0;i<dates1.size()-2;i++)
				{
					%>
					<script>
						availableDates1.push(<%=dates1.get(i)%>);
					</script>
					<%
						String str_date1=dates1.get(i)+"_";
						String str_date_format1=dates1.get(i).subSequence(4,6)+"/"+dates1.get(i).substring(6,8)+"/"+dates1.get(i).substring(0,4);
					%>
						<input type="radio" id="<%=str_date1%>" name="radio" /><label for="<%=str_date1%>"><%=str_date_format1%></label>
					<%
					}				
			 %>  
		                </div> <!-- div id="buoy-time-list" -->
		            </div> <!-- div id="buoytime"  -->
		        </form>
		        <!-- <div id="archive_2">
		  	 	     <a href="#" onClick="showDatepicker2();">Buoy Archive</a>	
		        </div>  -->
		 
		        <dir id="archive_1">
		   		    Click to choose a date to populate the Date list: <input type="text" id="datepicker2"> 
                </dir> 
	            <div id="description">
                    <h1>Instructions</h1>
                        <span class="text">This page compares observational data to model predictions.<br>
                        First, choose a date from the Date list. Dates before the present can be selected to populate the Date list.<br>
                        Then choose a buoy station from the list or the map. A plot of observational data, when available, and model output will appear in a new window. </span>
                </div>  <!-- end div id "description" -->
            </div> <!-- end date -->
        </div> <!-- end map -->
            <div id="footer">
        	    <jsp:include page="footer.jsp"></jsp:include>
            </div>  <!-- div id="footer"  -->
        </div> <!-- div id="box"  -->
    </div>  <!-- div id="page"  -->
</body>
</html>
