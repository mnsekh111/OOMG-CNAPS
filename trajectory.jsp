<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>CNAPS Coupled Northwest Atlantic Prediction System</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?sensor=false">
    </script>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="./mns-css/bootstrap.css">
    <link rel="stylesheet" href="./mns-css/bootstrap-theme.css">

    <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?sensor=false">
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


    <script type="text/javascript" src="./lib/loadImage.js"></script>
    <script type="text/javascript" src="./lib/animation.js"></script>
    <script type="text/javascript" src="./lib/trajectory.js"></script>
    <script type="text/javascript" src="./lib/listener.js"></script>
    <script type="text/javascript" src="./lib/showLatLng.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>
    <script type="text/javascript" src="./lib/vertical.js"></script>
    <script type="text/javascript" src="./lib/maps.google.polygon.containsLatLng.js"></script>

    <link type="text/css" href="layout.css" rel="stylesheet">
    <link type="text/css" href="reset.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script type="text/javascript">
        var map;
        var overlaysArray = [];

        function initialize() {
            mapInit();
            InitLatlng(map);
            google.maps.event.addListener(map, 'click', function (event) {
                if (!limitArea_polygon.containsLatLng(event.latLng)) {
                    alert("Sorry, this is outside our support domain.");
                }
                else {
                    addMarker(event.latLng);
                }
            });


            $("#btn_traj").click(function () {
                showTrajectory();
            });

            $("btn_clear").click(function () {
                window.location.href = window.location.href
            });

            $("btn_drift").click(function () {
                addDrifter();
            });

        }
    </script>

    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-12288686-5']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();

    </script>

</head>
<body style="background-color:#3A5ECA" onLoad="initialize()">
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
            <div class="main-content" id="map_canvas" style="float:left; width:100%;height:600px;"></div>
            <br><br>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
            <!--Nested rows within a column-->

            <table class="table" style="table-layout: fixed; word-wrap: break-word;color:white">
                <thead>
                <tr class="sec-header">
                    <td colspan="3">Options</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="sec-header">Latitude</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="txt_lat" size="7">
                    </td>
                </tr>
                <tr>
                    <td class="sec-header">Longitude</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="txt_lon" size="7">
                    </td>
                </tr>
                <tr>
                    <button id="btn_drift" class="btn btn-success">Add Drifter</button>
                </tr>
                <tr style="height: 40px"></tr>
                <tr>
                    <td>
                        <button id="btn_traj" class="btn btn-success">Show Trajectory</button>
                    </td>
                    <td>
                        <button id="btn_clear" class="btn btn-danger">Clear</button>
                    </td>
                </tr>
                <tr style="height: 40px"></tr>
                <tr>
                    <td colspan="3">
                        <div class="panel panel-primary ">
                            <div class="sec-header">Instructions</div>
                            <div class="panel-body">
                                <ul style="color: black">
                                    <li>Click in the ocean within the red box to "place" passive drifters at one or more
                                        locations.
                                    </li>
                                    <li>You can also add drifters by entering latitude and longitude in the boxes.
                                        Latitude and longitude are displayed when the cursor hovers over the map.
                                        <br>(In the model domain, latitude is positive and longitude is negative.)
                                    </li>
                                    <li>Click "Show Trajectory" to show the drifters' paths over 72 hours. <br/>Click
                                        "Clear" to refresh the map.
                                    </li>
                                    <li>Depending on the number of drifters you place, this may take several minutes.
                                        Please be patient.
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <br><br>

</div>


<jsp:include page="footer.jsp"/>
</body>
</html>
