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
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
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
<script type="text/javascript" src="./lib/ensemble.js"></script>
<script type="text/javascript" src="./lib/global.js"></script>
<script type="text/javascript">
	
	var overlaysArray=[];
	var root="<%=Global.val_figures_location %>"; 
	var day;
	var variable="t";

  $(document).ready(function () {
  		initialize();
  		document.getElementById("ensembleimage").src="servlet/Ensemble?"+"day="+day+"&variable="+variable;
});
  
  
  function initialize() {
	  
  $( "#time-list" ).buttonset();  
  $( "#variables" ).buttonset();
  //$( "#animationbutton").buttonset();
  
  $('#variables > input').on("click",
			function(){
				variable=this.id;
				$.get(	"servlet/Ensemble?"+
						"day="+day.substring(0,8)+"&variable="+variable, function(data){
						if (data=="fail"){
							alert("Sorry, this data is not available yet."+data);
							return;
						}});
				document.getElementById("ensembleimage").src="servlet/Ensemble?day="+day.substring(0,8)+"&variable="+variable;
						});
  
  jQuery(document).ready(function(){
  	$("#time-list > input").click(function(e){
		day=this.id;
			$.get(	"servlet/Ensemble?"+
					"day="+day.substring(0,8)+"&variable="+variable, function(data){
					if (data=="fail"){
						alert("Sorry, this data is not available yet.");
						return;
					}});
			document.getElementById("ensembleimage").src="servlet/Ensemble?"+"day="+day.substring(0,8)+"&variable="+variable;
		});
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
  
  //don't need following section to toggle instructions with click on "+"
  /* $(document).ready(function(){
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
	}); */
	  
  
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
  day=(d.getYear()+1900).toString()+month+day_0;
  //var s=(d.getYear()+1900).toString()+month+day_0+"_0000";
  
 // $('#'+s).click();
  //setbackground();

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
        </div> <!--end div id "logo" -->
        <div id="box">
            <div id="links" >
                <jsp:include page="links.jsp"></jsp:include>
            </div><!-- end div "links" -->
            <div id="title">Model Ensemble
            </div>  <!-- end div "title" -->
            <div id="map">
	            <form>
                    <div id="variables">
				        <span class="text">Variables:</span>
            	        <input value="Temperature" type="radio" id="t" name="radio"  /><label for="t">Temperature</label>
				        <input type="radio" id="s" name="radio"   /><label for="s">Salinity</label>
				        <input type="radio" id="uv" name="radio"  checked="checked" /><label for="uv">Current</label>
                    </div> <!-- end div id "variables" -->
  		        </form>
                    <div id="map_canvas" style="height:782;"> 
	  	                <img id="ensembleimage" src='' width="800" height = "782">
	                </div>  <!-- end div id "map_canvas" -->
	            
                <div id="date">
                    <form>
		                <div id="time-list" style="height:450px;">
                        <span class="text">Date:</span>
                        <br>
			 <%
				TimePeriod tp1=new TimePeriod();
				ArrayList<String> tmp1=tp1.getTimePeriod();
				
				//Only last 30 days is needed
				List<String> dates1=tmp1.subList(tmp1.size()-14,tmp1.size());
			
				%>
				<script type="text/javascript">
					day=<%=dates1.get(dates1.size()-4) %>+"_0000";
				</script>
				<% 
				
				for (int i=0;i<dates1.size()-1;i++)
				{
					%>
					<script>
						availableDates1.push(<%=dates1.get(i)%>);
					</script>
					<%
						String str_date1=dates1.get(i)+"_";
						String str_date_format1=dates1.get(i).subSequence(4,6)+"/"+dates1.get(i).substring(6,8)+"/"+dates1.get(i).substring(0,4);
					%>
				 <!--  [if IE]>
						<input type="radio" id="<%=str_date1%>" name="radio" class="ui-helper-hidden-accessible"/>
						 <label for="<%=str_date1%>" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
						 		<span class="ui-button-text"><%=str_date_format1%></span>
						 </label>
		  			<![endif]>
		  			
		  			<![if !IE]>-->
						<input type="radio" id="<%=str_date1%>" name="radio" /><label for="<%=str_date1%>"><%=str_date_format1%></label>
		  		    <!--  [endif]>-->  			
					<%
					}							
			 %>  
		                </div> <!-- end div id "time-list"-->
                    </form>
		  <!--  <div id="archive_0" >
		  	        <a  onClick="showDatepicker();">Archive</a>	
		        </div> -->
		 
                <dir id="archive_1" >
		            Choose a date to populate the Date list: 
                    <input type="text" id="datepicker"> 
		        </dir> 

       	        <h1>Model Ensemble</h1>
	      	    <p>Because there are a number of operational ocean models providing predictions of the marine environment for the northwest Atlantic Ocean, a multi-model ensemble is used routinely to generate a representative ocean state estimation and to facilitate inter-model comparison. This Ensemble page shows the CNAPS model (top left), the U.S. Navy's HYCOM model, the National Centers for Environmental Prediction (NCEP)'s HYCOM model, and an ensemble of the three models.</p>
            
                <h1>Instructions</h1>
                <p><b>Date:</b> Click on the date from the list to be shown on the maps. Dates before the present can be selected to populate the Date list. <br>
                <b>Variables:</b> Click on the variable to be shown on the map.</p>
                </div>  <!-- end div id "date" -->
            </div> <!-- end div id "map" -->
        </div> <!-- end div id "box" -->
        <div id="footer">
        	<jsp:include page="footer.jsp"></jsp:include>
        </div> <!-- end div id "footer" -->
    </div> <!-- end div id "page" -->
</body>
</html>