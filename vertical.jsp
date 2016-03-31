<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@page import="method.TimePeriod" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>CNAPS Coupled Northwest Atlantic Prediction System</title>
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
    <link rel="stylesheet" href="/css/jquery-ui.css"/>
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

    <script type="text/javascript">
        var map;
        var overlays;
        var date;
        var time;
        function initialize() {
            mapInit();
            InitLatlng(map);
            google.maps.event.addListener(map, 'click', function (event) {
                if (limitArea_polygon.containsLatLng(event.latLng)) {
                    if (overlays == null) {
                        marker = new google.maps.Marker({
                            position: event.latLng,
                            map: map
                        });
                        overlays = event.latLng;
                    } else {
                        alert("overlay is not null")
                    }
                } else {
                    alert("Sorry, this is outside our support domain.");
                }
            });

            $("#datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                minDate: new Date,
                maxDate: '+4D',
                onSelect: function (dateText, inst) {
                    var mydate = new Date(dateText);
                    date = getYYYYMMYY(mydate);
                    alert("Selected data " + date);
                }
            }).datepicker("setDate", new Date());

            $('#time_list').change(function () {
                time = this.value;
                alert("time list changed " + this.value);
            });

            $("#btn_plot").click(function () {
                showVertical();
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

        .sec-header {
            background-color: #3A5ECA;
            color: white;
            font-size: larger;
            font-weight: bold;
            padding: 2px;
        }
    </style>

</head>
<body style="background-color:#3A5ECA" onload="initialize()">
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
                    <td class="sec-header">Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                </tr>
                <tr>
                    <td class="sec-header">Time</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="time_list">
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
                        <button id="btn_plot" class="btn btn-success">Plot</button>
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
                            <ul>
                                <li>
                                    Select one location on the map and the criteria below, click on "Plot"
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
