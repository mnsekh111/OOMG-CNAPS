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

        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbeiqBit7rIdLkW4n1wB7ESlVHAXE0g_Q"
        type="text/javascript"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="./lib/loadImage.js"></script>
        <script type="text/javascript" src="./lib/animation_model.js"></script>
        <script type="text/javascript" src="./lib/val.js"></script>
        <script type="text/javascript" src="./lib/global.js"></script>
        <script type="text/javascript" src="./lib/weather.js"></script>


        <script type="text/javascript">
            var map;
            var overlaysArray = [];
            var root = "<%=Global.val_figures_location%>";
            var buoy_date;
            var buoy;

            $(document).ready(function () {
                initialize();
                $("#id_list_nav > li:nth-child(5)").addClass("active");
                Init_map();

            });

            function winOutputWaveEval(e) {

                window_handle = window.open("wavevalimage.jsp?day=" + buoy_date.substring(0, 8) + "&" + "date=" + buoy_date + "&" + "buoy=" + buoy,
                        "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=670, width=1000');

            }

            function initialize() {

                buoy = "41002";
                date = getYYYYMMYY(new Date());
                buoy_date = date;

                $("#datepicker").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function (dateText, inst) {
                        var date = new Date(dateText);
                        buoy_date = getYYYYMMYY(date);
                        if (buoy !== null)
                        {
                            //winOutputWaveEval(this);
                        } else {
                            alert("Please select a buoy station");
                        }
                    }
                }).datepicker("setDate", new Date());


                $('#buoy_list').change(function () {
                    buoy = this.value;
                });

                $('#btn_show_model').on("click", function () {
                    if (buoy !== null && buoy_date !== null) {
                        winOutputWaveEval(this);
                    }else{
                        alert("Please select a valid date and buoy station");
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

                Init_wsp_map();
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
    <body style="background-color:#3A5ECA" >
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
                                            <option value="41002">South Hatteras, NC</option>
                                            <option value="41008">Grays Reef, GA</option>
                                            <option value="41012">St. Augustine, FL</option>
                                            <option value="41013">Frying Pan Shoals, NC</option>
                                            <option value="41046">East Bahamas</option>
                                            <option value="41047">Northeast Bahamas</option>
                                            <option value="41048">West Bermuda</option>
                                            <option value="42001">Mid Gulf of Mexico</option>
                                            <option value="42003">East Gulf of Mexico</option>
                                            <option value="42012">Orange Beach, AL</option>
                                            <option value="42020">Corpus Christi, TX</option>
                                            <option value="42036">West Tampa, FL</option>
                                            <option value="42056">Yucatan Basin</option>
                                            <option value="42058">Central Caribbean</option>
                                            <option value="44014">Virginia Beach, VA</option>
                                            <option value="42055">Bay of Campeche, MX</option>
                                            <option value="44037">Jordan Basin, Gulf of Maine</option>
                                            <option value="44056">Duck FRF, NC</option>
                                            <option value="44065">New York Harbor</option>
                                            <option value="99999">Oil Platform, LA</option>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td>
                                        <button id="btn_show_model" class="btn btn-success">Show Validation Plots</button>
                                    </td>
                                </tr>

                                <tr style="height: 40px"></tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="panel panel-primary">
                                            <div class="sec-header">Instructions</div>
                                            <div class="panel-body">
                                                <div style="color: black;padding-left: 10px">
                                                    This page compares wave height observational data to model predictions. 
                                                    <br><br>Choose a date and variable to be displayed, then Show Validation Plot.
                                                </div>
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

