<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
<%@ page import="java.util.Arrays" %>



<!DOCTYPE html>
<html lang="en-US "style="width:655px; height:575px;">
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

        <script type="text/javascript" src="./lib/val.js"></script>
        <script type="text/javascript" src="./lib/global.js"></script>

        <script type="text/javascript">
                    var buoy_date = "<%=request.getParameter("date")%>";
                    var buoy = "<%=request.getParameter("buoy")%>";
                    var root = "<%=Global.val_figures_location%>";
                    var day = "<%=request.getParameter("day")%>";

                    $(document).ready(function () {
                        initialize();
                    });

                    function initialize() {

                        $(function () {
                            document.getElementById("buoyimage").src = "servlet/WaveValServlet?" + "day=" + day + "&" + "date=" + buoy_date + "&" + "buoy=" + buoy;
                        });

                    }
        </script> 
    </head>

    <body style="width:665px;height:575px">

        <img id="buoyimage" src="" alt="Sorry, the image is not available yet" height="329" width="642"  >

    </body>
</html>
