<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'new_window.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="./js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript">
		$.fn.image=function(src,f){
			return this.each(function(){
				var i=new Image();
				i.src=src;
				i.onload=f;
				this.appendChild(i);
			});
		}
		$(document).ready(function(){
			parameters=window.location.href.substring(window.location.href.indexOf('?')+1);
			if (parameters!=null){
				$("#image").image("servlet/Vertical?"+parameters,function(){
					$('.loading').remove();
				});
			}
		});
		
	</script>

  </head>
  
  <body>
  	<img class="loading" alt="" src="image/loading2.gif">
  	<div id="image"></div>
  </body>
</html>
