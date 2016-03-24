/**
* Created by mns on 3/23/16.
*/
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@page import="method.TimePeriod" %>
<%@page import="util.TimeFormat" %>
<%@page import="util.Global" %>
<%@ page import="java.util.Arrays" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="./mns-css/bootstrap.css">
    <link rel="stylesheet" href="./mns-css/bootstrap-theme.css">

    <!-- Script region -->

    <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?sensor=false">
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


    <script type="text/javascript" src="./lib/loadImage.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script>
    <script type="text/javascript" src="./lib/animation.js"></script>
    <script type="text/javascript" src="./lib/trajectory.js"></script>
    <script type="text/javascript" src="./lib/listener.js"></script>
    <script type="text/javascript" src="./lib/showLatLng.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>
    <script type="text/javascript" src="./lib/transection.js"></script>
    <script type="text/javascript" src="./lib/maps.google.polygon.containsLatLng.js"></script>


    <script type="text/javascript">
        <
        script
        type = "text/javascript" >
        var map;
        var overlaysArray = [];
        var vname = "temp";
        var date;
        var time;

        function initialize() {

            mapInit();

            InitLatlng(map);

            google.maps.event.addListener(map, 'click', function (event) {
                if (limitArea_polygon.containsLatLng(event.latLng)) {
                    if (transection_array.length < 2) {
                        marker = new google.maps.Marker({
                            position: event.latLng,
                            map: map
                        });
                        transection_array.push(event.latLng);
                    }
                }
                else {
                    alert("Sorry, this is outside our support domain.");

                }
            });

            $(function () {
                $("#variables").buttonset();
                $("#time-list").buttonset();
                $("#time").buttonset();
                //$( "#variables" ).buttonset();
            });

            $('#variables > input').bind("click",
                    function () {
                        vname = this.id;
                    });
            $('#time-list > input').bind("click",
                    function () {
                        date = this.id;
                    });
            $('#time > input').bind("click",
                    function () {
                        time = this.id;
                    });
            $(function () {
                $("#datepicker").datepicker({
                    changeMonth: true,
                    changeYear: true,

                    //Date range from Feb to Aug of current year
                    maxDate: max_date,
                    minDate: min_date,

                    onSelect: function (dateText, inst) {
                        changeDate(dateText, null);
                    }
                });
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


    <style>
        .main-content {
            background: #dbdfe5;
        }

    </style>


</head>
<body style="background-color:#3A5ECA">
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
                <tr style="background: #0A38B5; color: white">
                    <td colspan="3">Options</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Variable</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="variable_list">
                        <option value="temp">Temperature</option>
                        <option value="salt">Salinity</option>
                        <option value="u">u</option>
                        <option value="v">v</option>
                    </select></td>

                </tr>
                <tr>
                    <td>Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                </tr>
                <tr>
                    <td>Time</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="time">
                        <option value="0.0">0:00</option>
                        <option value="0.125">3:00</option>
                        <option value="0.25">6:00</option>
                        <option value="0.375">9:00</option>
                        <option value="0.5">12:00</option>
                        <option value="0.625">15:00</option>
                        <option value="0.75">18:00</option>
                        <option value="0.875">21:00</option>
                    </select></td>


                </tr>

                <tr>
                    <td>
                        <button id="btn_show_transect" class="btn btn-success">Show Transect</button>
                    </td>
                    <td>
                        <button id="btn_clear" class="btn btn-danger">Clear</button>
                    </td>
                </tr>
                <tr style="height: 40px">
                </tr>
                </tbody>
            </table>


        </div>
    </div>

    <br><br>
    <div class="panel panel-primary" style="background-color:#3A5ECA;color:white">
        <div style="background: #0A38B5; color: white">Instructions</div>
        <div class="panel-body">
            <ul>
                <li>Click on two locations in the ocean within the red box,<br>
                    which will be the beginning and end points of your transect.<br>
                    Select the variable, date, and time, then click on "Show Transect"
                </li>
                <li><strong>Variables:</strong> Click on the variable to be shown on the transect. "u" is water movement<br>
                    in the east (positive)-- west (negative) direction. "v" is water movement in the north
                    (positive)<br>
                    -- south (negative) direction.
                </li>
                <li>Click your browser's refresh button to reset all criteria.
                </li>
            </ul>
        </div>
    </div>
</div>


<br>
<br>

<jsp:include page="footer.jsp"/>

<script>
    var btn = document.querySelector("#btn");
    btn.addEventListener("click", function () {
        var element = document.getElementById("dropDown");
        var newItem = element.getElementsByTagName("li")[0].cloneNode(true);
        var childCount = document.querySelectorAll("ul li").length;
        var newItemChild = document.createElement("a");
        newItemChild.href = "#";
        newItemChild.innerHTML = "Element " + (childCount + 1);
        newItem.innerHTML = '';
        newItem.appendChild(newItemChild);
        element.appendChild(newItem);
    });
</script>
</body>
</html>

