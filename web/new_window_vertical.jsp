<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <base href="<%=basePath%>">

        <title>Temperature and Salinity Profile</title>

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
            $(document).ready(function () {

                $.fn.image = function (src, f) {
                    return this.each(function () {
                        var i = new Image();
                        i.src = src;
                        i.onload = f;
                        this.appendChild(i);
                    });
                }

                var parameters = window.location.href.substring(window.location.href.indexOf('?') + 1);
                var pairs = parameters.split("&");
                var map = {};
                for (i = 0; i < pairs.length; i++) {
                    var pair = pairs[i].split("=");
                    map[pair[0]] = pair[1];
                }

                var locDiv = document.createElement("div");
                $(locDiv).css({"padding": "10px", "background-color": "#0A38B5", "color": "white"});
                $(locDiv).html("Location : " + map["lat"] + ", " + map["lon"]);
                $("body").append(locDiv);


                if (parameters != null) {
                    $("#image").image("servlet/Vertical?" + parameters, function () {
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
