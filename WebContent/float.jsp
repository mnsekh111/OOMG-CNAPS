<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
<%@ page import="java.util.Arrays" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<title>USeast Nowcast/Forecast System</title>
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
<script type="text/javascript" src="./lib/float.js"></script>
<script type="text/javascript" src="./lib/global.js"></script>
<script type="text/javascript">
  var map;
  var overlaysArray=[];
  var root="<%=Global.yizhen_figures_location %>"; 
  
  //var depth="0";
  //var variable="swd";
  var date;
 
  $(document).ready(function () {
  		initialize();
});
  
  function initialize() { 
  
       
    $(function() {
		//$( "#variables" ).buttonset();
		//$( "#depth" ).buttonset();
		
		//if it's not IE
		//if ($.browser.msie==null)
			$( "#time-list" ).buttonset();
			
		//else{
		//	var version=$.browser.version;
		//	if (version!="8.0" && version!="9.0")
		//		alert("Detected your web browser is: IE "+version+".\nKnown compatibility issue is existed with this browser, please use another browser to gain better experience.")
		//}
	});

	
	$('#time-list > input').bind("click",
			function(){
				date=this.id;
				plotfloat();
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
  	
  	//$(document).ready(function(){
  	//	$("#description").hide();
  	//});
				
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
		</div>
		  </form>
		  <div  id="para">

	
		  <form>
            <div id="variables">
            </div>
          </form>
          </div>  
          
          <div id="date">
          <form>
          	<span class="text">Date:</span>
		  	<div id="time-list">
		  	
			 <%
				TimePeriod tp=new TimePeriod();
				ArrayList<String> tmp=tp.getTimePeriod();
				
				//Only last 30 days is needed
				List<String> dates=tmp.subList(tmp.size()-30,tmp.size());
			
				%>
				<script type="text/javascript">
					date=<%=dates.get(dates.size()-4) %>+"_0000";
				</script>
				<% 
				
				for (int i=0;i<dates.size()-1;i++)
				{
				
					%>
					<script>
						availableDates.push(<%=dates.get(i)%>);
					</script>
					<%
				
						String str_date=dates.get(i)+"_";
						
								
						String str_date_format=dates.get(i).subSequence(4,6)+"/"+dates.get(i).substring(6,8)+"/"+dates.get(i).substring(0,4);
					
					%>
					 <!--[if IE]>
						<br/><input type="radio" id="<%=str_date%>" name="radio" class="ui-helper-hidden-accessible"/>
						 <label for="<%=str_date%>" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
						 		<span class="ui-button-text"><%=str_date_format%></span>
						 </label>
		  			<![endif]-->
		  			
		  			
						<input type="radio" id="<%=str_date%>" name="radio" /><label for="<%=str_date%>"><%=str_date_format%></label>
		  		    			

					<%
				
				}				
			 %>  
		  </div>
		  </form>
		  
		  
		  <div id="archive_0">
		  	 <a  href="#" onClick="showDatepicker();">Archive</a>	
		  </div>
		  
		  <dir id="archive_1">
		  Please select the date below: <input type="text" id="datepicker"> 
		  </dir>

            <div id="animationbutton">
  			<form>
			<input type="button" id="start" OnClick="foo();" value="Start animation"/>
			<input type="button" OnClick="stopCount();" disabled="disabled" value="Stop"/>
			</form>
            </div>
            
            <p>Instruction &nbsp;&nbsp;<button id="showtext">Show Instruction</button></p>
	      	<div id="description">
	        	<jsp:include page="introduction.jsp"></jsp:include>
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
