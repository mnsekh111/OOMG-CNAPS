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
  var ifshowhf = false;
  var hfdate;
  var buoy_date;
  var buoy;
  var s;
 
  $(document).ready(function () {
  		initialize();
});
  function initialize() { 
    $(function() {
    	$( "#variables" ).buttonset();
    	//$( "#animationbutton").buttonset();
		$( "#buoy" ).buttonset();
		//if it's not IE
		$( "#buoy-time-list" ).buttonset();
		//if ($.browser.msie==null)
			$( "#time-list" ).buttonset();
			
		//else{
		//	var version=$.browser.version;
		//	if (version!="8.0" && version!="9.0")
		//		alert("Detected your web browser is: IE "+version+".\nKnown compatibility issue is existed with this browser, please use another browser to gain better experience.");
		//}
	});

    //$('#time-list >  input').bind("click",
	//		function(){
	//			hfdate=this.id;
	//			$.get(	"servlet/ValServlet1?"+
	//					"day="+hfdate.substring(0, 8)+"&"+
	//					"hfdate="+hfdate, function(data){
	//					if (data=="fail"){
	//						alert("Sorry, this data is not available yet.");
	//						return;
	//					}});
				//window.open("servlet/ValServlet1?"+
				//		"day="+hfdate.substring(0, 8)+"&"+
				//		"hfdate="+hfdate, "Model Validation", 'height=700,width=1100' );
	//			window.open("hfimage.jsp","hfradarimage","width=665, height=500");
				//plotvalidation1();
	//					});
    jQuery(document).ready(function(){
    	$("#time-list > input").click(function(e){
    		hfdate=this.id;
    		$.get("servlet/ValServlet3?"+
    				"day="+hfdate.substring(0, 8)+"&"+
    				"date="+hfdate, function(data){
    							if (data=="fail"){
    								alert("Sorry, this data is not available yet.");
    								return;
    							}});
    		Change_hfradar_map();
    		window_handle = window.open("hfimage.jsp?day="+hfdate.substring(0,8)+"&hfdate="+hfdate+"&areanum=1","hfradar","top="+e.screenY + ",left=" + e.screenX +", height=470, width=800");
    });
  });

	jQuery(document).ready(function(){
    	$("#buoy > input").click(function(e){
			buoy=this.id;
			if(buoy_date!=null)
			{
				$.get(	"servlet/BuoyServlet?"+
						"day="+buoy_date.substring(0,8)+"&"+
						"date="+buoy_date+"&"+"buoy="+buoy, function(data){
						if (data=="fail"){
							alert("Sorry, this data is not available yet.");
							return;
						}});
					window_handle = window.open("buoyimage.jsp?day="+d1+"&"+"date="+buoy_date+"&"+"buoy="+buoy, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=800' );
			}
		});
    	});
	
	jQuery(document).ready(function(){
    	$("#buoy-time-list > input").click(function(e){
		buoy_date=this.id;
		if(buoy!==null)
		{
			$.get(	"servlet/BuoyServlet?"+
					"day="+buoy_date.substring(0,8)+"&"+
					"date="+buoy_date+"&"+"buoy="+buoy, function(data){
					if (data=="fail"){
						alert("Sorry, this data is not available yet.");
						return;
					}});
				window_handle = window.open("buoyimage.jsp?day="+buoy_date.substring(0,8)+"&"+"date="+buoy_date+"&"+"buoy="+buoy, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=800' );
		}
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
		  $("#hfbutton").click(function(){
			  $("#buoytime").hide();
			  $("#buoy").hide();
			  $("#hfradartime").show();
			  $("#archive_1").show();
			  $("#archive_3").hide();
			  $("#animationbutton").hide();
			  
			  if(ifshowhf == false)
			  {
				  Hide_buoymap();
				  Init_hfradar_map();
			  }
			  ifshowhf = true;
			  
		  });
		  $("#buoybutton").click(function(){
			  $("#buoytime").show();
			  $("#buoy").show();
			  $("#hfradartime").hide();
			  $("#archive_3").show();
			  $("#archive_1").hide();
			  $("#animationbutton").hide();
			  ifhf="false";
			  //google.maps.event.addDomListener(window,'load',Init_buoy_map);
			  
			  if(ifshowhf == true)
			  {
				  Hide_hfradar();
				  Init_buoy_map();
			  }
				
			  ifshowhf = false;
		  });
	  });

	  	
	  	$(document).ready(function(){
			//next line shows HR radar zones on map
	  		$("#hfbutton").trigger('click');
	  		//$("#description").hide();
	  		//$("#archive_2").hide();
	  	});  
				
	mapInit();
    //InitLatlng(map);
    //To display the default figure (current day, 0 meter, uv) on the map
    var d1=new Date();
    var d=new Date(new Date(d1.getFullYear(),d1.getMonth(),d1.getDate())-24);
    var month=d.getMonth()+1;
    //d.setDate(d.getDate()-1)
    var day_0=d.getDate();
    if (month<10)
    	month="0"+month.toString();
    else
    	month=month.toString();
    if (day_0 <10)
    	day_0="0"+day_0.toString();
    else
    	day_0=day_0.toString();
    s=(d.getYear()+1900).toString()+month+day_0+"_0000";
    
   // $('#'+s).click();
    setbackground();
}
	</script> 

<script type="text/javascript">
  // this section is about Google Analytics and page counter
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
	    <div id="logo" >
		    <img src="image/bannerCNAPS.png" width="1140" height = "120">
		</div> <!--end div id "logo" -->
		<div id="box">
            <div id="links" >
			    <jsp:include page="links.jsp"></jsp:include>
		    </div><!-- end div "links" -->
            <div id="title">Model Validation: Circulation
		    </div>  <!-- end div "title" -->
            <div id="map">
                <form>
                    <div id="variables">
			           <input type="radio" id="hfbutton" name="radio" checked="checked" /><label for="hfbutton">HF Radar</label>
				       <input type="radio" id="buoybutton" name="radio"  /><label for="buoybutton">Tide Gauge</label>
                    </div>  <!-- end div id "variables" -->
  		        </form>
                <div id="map_canvas" > 
                </div>
  		        
		        <div id="date">
                    <form>	
                        <div id="hfradartime">
			                
                            <div id="time-list">
                            <span class="text">Date and Time:</span>
			 <%
				TimePeriod tp=new TimePeriod();
				ArrayList<String> tmp=tp.getTimePeriod();
				
				//Only last 7 days is needed
				List<String> dates=tmp.subList(tmp.size()-7,tmp.size());
			
				%>
				<script type="text/javascript">
					hfdate=<%=dates.get(dates.size()-4) %>+"_0000";
				</script>
				<% 
				
				for (int i=0;i<dates.size()-2;i++)
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
						<input type="radio" id="<%=str_date%>" name="radio" /><label for="<%=str_date%>"><%=str_date_format%></label>
					<%
					}				
				}				
			 %>  
                                </div>  <!-- end div id "time-list"  -->
		                    </div>  <!-- end div id "hfradartime" -->
                        </form>
		
		               <form>
                           <div id="buoy">
            	<span class="text">Buoy Station</span><br/>
				<input type="radio" id="8410140" name="radio"   /><label for="8410140">Eastport, ME</label>
				<input type="radio" id="8413320" name="radio"   /><label for="8413320">Bar Harbor, ME</label>
				<input type="radio" id="8418150" name="radio"   /><label for="8418150">Portland, ME</label>
				<input type="radio" id="8443970" name="radio"   /><label for="8443970">Boston, MA</label>
				<input type="radio" id="8449130" name="radio"   /><label for="8449130">Nantucket Island, MA</label>
				<input type="radio" id="8447930" name="radio"   /><label for="8447930">Woods Hole, MA</label>
				<input type="radio" id="8452660" name="radio"   /><label for="8452660">Newport, RI</label>
				<input type="radio" id="8461490" name="radio"   /><label for="8461490">New London, CT</label>
				<input type="radio" id="8465705" name="radio"   /><label for="8465705">New Haven, CT</label>
				<input type="radio" id="8516945" name="radio"   /><label for="8516945">Kings Point, NY</label>
				<input type="radio" id="8510560" name="radio"   /><label for="8510560">Montauk, NY</label>
				<input type="radio" id="8531680" name="radio"   /><label for="8531680">Sandy Hook, NJ</label>
				<input type="radio" id="8534720" name="radio"   /><label for="8534720">Atlantic City, NJ</label>
				<input type="radio" id="8557380" name="radio"   /><label for="8557380">Lewes, DE</label>
				<input type="radio" id="8570283" name="radio"   /><label for="8570283">Ocean City, MD</label>
				<input type="radio" id="8632200" name="radio"   /><label for="8632200">Kiptopeke, VA</label>
				<input type="radio" id="8575512" name="radio"   /><label for="8575512">Annapolis, MD</label>
				<input type="radio" id="8636580" name="radio"   /><label for="8636580">Windmill Point, VA</label>
				<input type="radio" id="8651370" name="radio"   /><label for="8651370">Duck, NC</label>
				<input type="radio" id="8656483" name="radio"   /><label for="8656483">Beaufort, NC</label>
				<input type="radio" id="8658163" name="radio"   /><label for="8658163">Wrightsville Beach, NC</label>
				<input type="radio" id="8661070" name="radio"   /><label for="8661070">Springmaid Pier, NC</label>
				<input type="radio" id="8665530" name="radio"   /><label for="8665530">Charleston, SC</label>
				<input type="radio" id="8670870" name="radio"   /><label for="8670870">Fort Pulaski, GA</label>
				<input type="radio" id="8720218" name="radio"   /><label for="8720218">Mayport, FL</label>
				<input type="radio" id="8721604" name="radio"   /><label for="8721604">Trident Pier, FL</label>
				<input type="radio" id="8722670" name="radio"   /><label for="8722670">Lake Worth Pier, FL</label>
				<input type="radio" id="8723214" name="radio"   /><label for="8723214">Virginia Key, FL</label>
				<input type="radio" id="8724580" name="radio"   /><label for="8724580">Key West, FL</label>
				<input type="radio" id="8723970" name="radio"   /><label for="8723970">Vaca Key, FL</label>
				<input type="radio" id="8725110" name="radio"   /><label for="8725110">Naples, FL</label>
				<input type="radio" id="8726384" name="radio"   /><label for="8726384">Port Manatee, FL</label>
				<input type="radio" id="8726724" name="radio"   /><label for="8726724">Clearwater Beach, FL</label>
				<input type="radio" id="8727520" name="radio"   /><label for="8727520">Cedar Key, FL</label>
				<input type="radio" id="8728690" name="radio"   /><label for="8728690">Apalachicola, FL</label>
				<input type="radio" id="8729108" name="radio"   /><label for="8729108">Panama City, FL</label>
				<input type="radio" id="8735180" name="radio"   /><label for="8735180">Dauphin Island, AL</label>
				<input type="radio" id="8760922" name="radio"   /><label for="8760922">Pilots Station East, LA</label>
				<input type="radio" id="8764227" name="radio"   /><label for="8764227">Lawma, LA</label>
				<input type="radio" id="8770570" name="radio"   /><label for="8770570">Sabine Pass, TX</label>
				<input type="radio" id="8771341" name="radio"   /><label for="8771341">Galveston, TX</label>
				<input type="radio" id="8772447" name="radio"   /><label for="8772447">USCG Freeport, TX</label>
				<input type="radio" id="8775870" name="radio"   /><label for="8775870">Corpus Christi, TX</label>
				<input type="radio" id="2695540" name="radio"   /><label for="2695540">Bermuda</label>
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
				List<String> dates1=tmp1.subList(tmp1.size()-14,tmp1.size()-3);
				%>
				<script type="text/javascript">
					buoy_date=<%=dates1.get(dates1.size()-4) %>+"_0000";
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
		                </div>  <!-- end div id "buoy-time-list" -->
		            </div>  <!-- end div id "buoytime" -->
		        </form>
		              
		        <!-- <div id="archive_0" >
		            <a  onClick="showDatepicker();">Archive</a>	
                </div>  -->
		 
		        <dir id="archive_1" >
		   		     Choose a date to populate the Date and Time list: <input type="text" id="datepicker"> 
                </dir> 
		   
		        <!--  <div id="archive_2">
		         	   <a href="#" onClick="showDatepicker2();">Buoy Archive</a>	
		        </div>  --> 
		 
		        <dir id="archive_3">
		   		      Choose a date to populate the Date list: <input type="text" id="datepicker2"> 
		        </dir> 
		        <div id="animationbutton">
                <!-- if this section is commented out, radar zones don't show on map, so it is "hidden" for both "hfbutton" and "buoybutton" -->
 			        <form>
			            <input type="button" id="start" OnClick="foo();" value="Start animation"/>
			            <input type="button" OnClick="stopCount();" disabled="disabled" value="Stop"/>
			        </form>
       	        </div>  <!-- end div id "animationbutton" -->
                <div id="description">
                	<h1>Instructions</h1>
                     <span style="text">This page compares observational data to model predictions.<br>
                    First, choose HF Radar or Tide Gauge from the buttons above the map.<br>
                    Second, choose a date from the Date list. Dates before the present can be selected to populate the Date list.<br>
                    Third, choose a radar or buoy station from the map or list. A plot of observational data, when avaiable, and model output will appear in a new window.</span>
                </div>  <!-- end div id "description" -->
	        </div> <!-- end div id "date" -->
        </div>  <!-- end div id "map" -->
             <div id="footer">
        	    <jsp:include page="footer.jsp"></jsp:include>
            </div> <!-- end div id "footer" -->
       </div>  <!-- emd div id "box" -->
   </div> <!-- end div id "page" -->
</body>
</html>
