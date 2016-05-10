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


    <link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/jquery-ui.css"/>
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css"/>
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
        var overlaysArray = [];
        var root = "<%=Global.val_figures_location %>";
        var hfdate;
        var buoy_date;
        var buoy = null;


        function initialize() {

            getTodayStr();
            $("#datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                onSelect: function (dateText, inst) {
                    var date = new Date(dateText);
                    buoy_date = getYYYYMMYY(date);
                    if (buoy !== null) {
                        alert(buoy_date);
                        $.get("servlet/WaveValServlet?" +
                                "day=" + buoy_date.substring(0, 8) + "&" +
                                "date=" + buoy_date + "&" + "buoy=" + buoy, function (data) {
                            if (data == "fail") {
                                alert("Sorry, this data is not available yet.");
                                return;
                            }
                        });
                        window_handle = window.open("wavevalimage.jsp?day=" + buoy_date.substring(0, 8) + "&" + "date=" + buoy_date + "&" + "buoy=" + buoy, "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=470, width=800');
                    } else {
                        alert("Please select a buoy station");
                    }
                }
            }).datepicker("setDate", new Date());


            $('#buoy_list').change(function () {
                buoy = this.id;
                if (buoy_date != null) {
                    window.open("wavevalimage.jsp?day=" + buoy_date.substring(0, 8) + "&date=" + buoy_date + "&buoy=" + buoy, "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=470, width=800');
                }
            });

            mapInit();
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-12288686-5']);
            _gaq.push(['_trackPageview']);
            (function () {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') +
                        '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();

            $("#id_list_nav > li:nth-child(5)").css({ "background-color": "#0A38B5"})
        }

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
                    <td>Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                </tr>
                <tr>
                    <td>Buoy Stations</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="buoy_list">
                        <option value="t">Temperature</option>
                        <option value="s">Salinity</option>
                        <option value="uv">Current</option>
                    </select></td>
                </tr>

                <tr style="height: 40px"></tr>
                <tr>
                    <td colspan="3">
                        <div class="panel panel-primary">
                            <div class="sec-header">Model Ensemble</div>
                            <div class="panel-body">
                                <ul style="color: black">
                                    <li>Because there are a number of operational ocean models providing predictions of
                                        the marine environment for <br>
                                        the northwest Atlantic Ocean, a multi-model ensemble is used routinely to
                                        generate a representative ocean state <br>
                                        estimation and to facilitate inter-model comparison. This Ensemble page shows
                                        the CNAPS model (top left), the U.S. Navy's HYCOM model, <br>
                                        the National Centers for Environmental Prediction (NCEP)'s HYCOM model, and an
                                        ensemble of the three models.
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr style="height: 40px"></tr>
                <tr>
                    <td colspan="3">
                        <div class="panel panel-primary">
                            <div class="sec-header">Instructions</div>
                            <div class="panel-body">
                                <ul style="color: black">
                                    <li><strong>Date:</strong> Click on the date from the list to be shown on the maps.
                                        <br>
                                        Dates before the present can be selected to populate the Date list.
                                    </li>
                                    <li><strong>Variables:</strong> Click on the variable to be shown on the map.</li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<br>
<br>

<jsp:include page="footer.jsp"/>


</body>
</html>

