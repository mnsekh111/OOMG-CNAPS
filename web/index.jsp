<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />    
	<link type="text/css" href="layout.css" rel="stylesheet" />   
	<script type="text/javascript" src="./lib/loadImage.js"></script>
	<script type="text/javascript" src="./lib/global.js"></script>
	<link rel="stylesheet" href="/css/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.js"></script>
	<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.min.js"></script>

	
	<script> 
	$(function() {
 		$('#datepicker').datepicker({
             inline: true,
             changeMonth: true,
			 changeYear: true,
			 onSelect: function(dateText,inst){
			 				loadImage(dateText);
			 				loadTable(dateText);
			 				}
         });
         
         $( "#radio" ).buttonset();
		 $('#radio').find('input').bind("click",function (){loadImage("01/0"+this.id[5]+"/2011");});
	});
	</script> 
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312"><style type="text/css">
<!--
body,td,th {
}
-->
  </style></head>
  
  <body>
    <div id="box">
    			<div id="logo">
				</div>
      <div align="center"></div>
      <div id="downbox">
	<div id="navigation">
    <div id="datepicker">
      <div align="left"></div>
    </div>
    
    
	<div id="radio"> 
    <form>
    	<table width="127" border="1">
  <tr>
    <td width="117"><input type="radio" id="radio1" name="radio" />
      <label for="radio1">Attribute 1</label></td>
  </tr>
  <tr>
    <td><input type="radio" id="radio2" name="radio" />
      <label for="radio2">Attribute 2</label></td>
  </tr>
  <tr>
    <td><input type="radio" id="radio3" name="radio" />
      <label for="radio3">Attribute 3</label></td>
  </tr>
  <tr>
    <td><input type="radio" id="radio4" name="radio" />
      <label for="radio4">Attribute 4</label></td>
  </tr>
  <tr>
    <td><input type="radio" id="radio5" name="radio" />
      <label for="radio5">Attribute 5</label></td>
  </tr>
  <tr>
    <td><input type="radio" id="radio6" name="radio" />
      <label for="radio6">Attribute 6</label></td>
  </tr>
</table>
		</form>
		<a href="index2.jsp">Trajectory</a>
	</div> 
	</div>

    <div id="content" >
    	<div id="grid">
    	  <table id="tdata" width="440" border="1">
    	    <tr>
    	      <th width="144" bgcolor="#CC33CC" scope="col">File Name</th>
    	      <th width="134" bgcolor="#CC33CC" scope="col">Download</th>
    	      <th width="140" bgcolor="#CC33CC" scope="col">View</th>
  	        </tr>
  	    </table>
    	</div>
    	<div id="image"><img src="./image/20110111_0000.png" onerror="loadImageFail()" width="517" height="473"></div>   	
    </div>
    </div>
    <div id="footer">
	</div>
    </div>
  </body>
</html>
