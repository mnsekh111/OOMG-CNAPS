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

        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbeiqBit7rIdLkW4n1wB7ESlVHAXE0g_Q"
        type="text/javascript"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


        <script type="text/javascript" src="./lib/loadImage.js"></script>
        <script type="text/javascript" src="./lib/animation.js"></script>
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
            var overlays;
            var date;
            var time = 0.0;
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
                    minDate: getTwoMonthWindow(new Date),
                    maxDate: new Date,
                    onSelect: function (dateText, inst) {
                        var mydate = new Date(dateText);
                        date = getYYYYMMYY(mydate);
                        //alert("Selected data " + date);
                    }
                }).datepicker("setDate", new Date());

                $('#time_list').change(function () {
                    time = this.value;
                    //alert("time list changed " + this.value);
                });

                $("#btn_plot").click(function () {
                    showVertical();
                });

                $("#btn_clear").click(function () {
                    window.location.href = window.location.href
                });

                date = getYYYYMMYY(new Date());
                time = getTime(new Date());

                $("#time_list").val(time).change();
                $("#id_list_nav > li:nth-child(4)").addClass("active");
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
                                            <option value="0.0">00:00</option>
                                            <option value="0.125">03:00</option>
                                            <option value="0.25">06:00</option>
                                            <option value="0.375">09:00</option>
                                            <option value="0.5">12:00</option>
                                            <option value="0.625">15:00</option>
                                            <option value="0.75">18:00</option>
                                            <option value="0.875">21:00</option>
                                        </select></td>


                                </tr>

                                <tr>
                                    <td>
                                        <button id="btn_plot" class="btn btn-success">Plot Profile</button>
                                    </td>
                                    <td>
                                        <button id="btn_clear"  class="btn btn-danger">Clear</button>
                                    </td>
                                </tr>
                                <tr style="height: 40px"></tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="panel panel-primary ">
                                            <div class="sec-header">Instructions</div>
                                            <div class="panel-body">
                                                <div style="color: black;padding-left: 10px">
                                                    Choose one location in the ocean within the red box on the map, date, and time, then choose "Plot Profile". 
                                                    <br><br>The resulting plot shows the temperature and salinity profiles from ocean surface to bottom at the chosen point.
                                                </div>
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
    </body>
</html>
