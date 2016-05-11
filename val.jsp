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
    <script type="text/javascript" src="./lib/animation_model.js"></script>
    <script type="text/javascript" src="./lib/val.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>
    <script type="text/javascript" src="./lib/maps.google.polygon.containsLatLng.js"></script>

    <link type="text/css" href="layout.css" rel="stylesheet">
    <link type="text/css" href="reset.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

    <script type="text/javascript">
        var map;
        var overlaysArray = [];
        var root = "<%=Global.val_figures_location %>";
        var ifshowhf = false;
        var hfdate;
        var buoy_date;
        var buoy;
        var s;

        $(document).ready(function () {
            initialize();
            $("#id_list_nav > li:nth-child(5)").css({"background-color": "#041648"})
            alert("going to be called.......")
            $('#variable_list')
                    .val('hf')
                    .trigger('change');
            alert("It has been called.......")
        });

        function initialize() {

            $("#time_list").change(function () {
                time = $("#time_list").val();
                ;
                alert("" + time);
            });
            $("#variable_list").change(function () {
                vname = $("#variable_list").val();
                ;
                alert("" + vname);
                var rows = $("table tr")
                if (vname == "hf") {
                    alert("hf inside");
                    if (ifshowhf == false) {
                        rows.filter(".hf").show();
                        rows.filter(".buoy").hide();
                        Hide_buoymap();
                        Init_hfradar_map();
                    }
                    ifshowhf = true;

                } else if (vname == "buoy") {
                    rows.filter(".hf").hide();
                    rows.filter(".buoy").show();
                    alert("buoy inside");
                    ifhf = "false";
                    //google.maps.event.addDomListener(window,'load',Init_buoy_map);

                    if (ifshowhf == true) {
                        Hide_hfradar();
                        Init_buoy_map();
                    }

                    ifshowhf = false;
                }
            });

            $("#datepicker2").datepicker({
                changeMonth: true,
                changeYear: true,
                minDate: '-10D',
                maxDate: new Date,
                onSelect: function (dateText, inst) {
                    var mydate = new Date(dateText);
                    date = getYYYYMMYY(mydate);
                    alert("Selected data " + date);
                }
            }).datepicker("setDate", new Date());

            $("#datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                minDate: '-4D',
                maxDate: new Date,
                onSelect: function (dateText, inst) {
                    var mydate = new Date(dateText);
                    date = getYYYYMMYY(mydate);
                    alert("Selected data " + date);
                }
            }).datepicker("setDate", new Date());


            date = getYYYYMMYY(new Date());
            time = getTime(new Date());

            mapInit();
            s = date + "_0000";
            setbackground();

        }


    </script>

    <script type="text/javascript">
        // this section is about Google Analytics and page counter
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
                <tr class="sec-header">
                    <td colspan="3">Options</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Variables</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="variable_list">
                        <option value="hf">HF-Radar</option>
                        <option value="buoy">Tide Guage</option>
                    </select></td>

                </tr>
                <tr class="hf">
                    <td>HF Radar Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                </tr>
                <tr class="hf">
                    <td>Time</td>
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
                <tr class="buoy">
                    <td>Buoy Stations</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="buoy_list">
                        <option value="44037">Jordan Basin, Gulf of Maine</option>
                        <option value="44065">New York Harbor</option>
                        <option value="44014">Virginia Beach, VA</option>
                        <option value="44056">Duck FRF, NC</option>
                        <option value="41013">Frying Pan Shoals, NC</option>
                        <option value="41002">South Hatteras, NC</option>
                        <option value="41008">Grays Reef, GA</option>
                        <option value="41012">St. Augustine, FL</option>
                        <option value="41048">West Bermuda</option>
                        <option value="41047">Northeast Bahamas</option>
                        <option value="41046">East Bahamas</option>
                        <option value="42036">West Tampa, FL</option>
                        <option value="42012">Orange Beach, AL</option>
                        <option value="LOPL1">Oil Platform, LA</option>
                        <option value="42003">East Gulf of Mexico</option>
                        <option value="42001">Mid Gulf of Mexico</option>
                        <option value="42020">Corpus Christi, TX</option>
                        <option value="42055">Bay of Campeche, MX</option>
                        <option value="42056">Yucatan Basin</option>
                        <option value="42058">Central Caribbean</option>
                    </select></td>
                </tr>
                <tr class="buoy">
                    <td>Buoy Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker2"></td>
                </tr>

                <tr style="height: 40px">
                </tr>
                <tr>
                    <td colspan="3">
                        <div class="panel panel-primary">
                            <div class="sec-header">Instructions</div>
                            <div class="panel-body">
                                <ul style="color: black">
                                    <li>This page compares observational data to model predictions.<br>
                                    </li>
                                    <li>First, choose HF Radar or Tide Gauge from the buttons above the map.
                                    </li>
                                    <li>Second, choose a date from the Date list. Dates before the present can be
                                        selected to populate <br>
                                        the Date list.
                                    </li>
                                    <li>Third, choose a radar or buoy station from the map or list. A plot of
                                        observational data,<br>
                                        when available, and model output will appear in a new window.
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






