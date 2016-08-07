<%@page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@page import="method.TimePeriod" %>
<%@page import="util.TimeFormat" %>
<%@page import="util.Global" %>
<%@page import="java.util.Arrays" %>
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
        <script type="text/javascript" src="./lib/weather.js"></script>
        <script type="text/javascript" src="./lib/global.js"></script>


        <script type="text/javascript">
            var map;
            var overlaysArray = [];
            var root = "<%=Global.val_figures_location%>";
            var variable = "Pair";
            var buoy = "41002";
            var buoy_date;
            var date;


            $(document).ready(function () {
                initialize();
                $("#id_list_nav > li:nth-child(5)").addClass("active");
                Init_map();
            });

            function winOutputWeather(e) {

                window.open("weathervalimage.jsp?day=" + buoy_date.substring(0, 8) + "&date=" + buoy_date + "&buoy=" + buoy + "&variable=" + variable,
                        "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=470, width=665');

            }

            function initialize() {

                $("#datepicker").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    maxDate: new Date(),
                    onSelect: function (dateText, inst) {
                        var tmpDate = new Date(dateText);
                        buoy_date = getYYYYMMYY(tmpDate)
                        //alert(dateText);
                    }
                }).datepicker("setDate", new Date());

                $('#variable_list').change(function (e) {
                    variable = this.value;
                });

                $('#buoy_list').change(function (e) {
                    buoy = this.value;
                });


                $(document).ready(function () {
                    $('.dropdown-toggle').dropdown();
                });

                var date = getYYYYMMYY(new Date());
                buoy_date = date;

                $('#btn_show_model').on("click", function () {
                    winOutputWeather(this);
                });

                mapInit();
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

                Init_slp_map();
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
                                    <td>Variable</td>
                                    <td colspan="2"><select class="form-control" style="width: 100%" id="variable_list">
                                            <option value="Pair">Sea Level Air Pressure</option>
                                            <option value="Wind">Wind</option>
                                            <option value="Tair">Air Temperature</option>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td>Buoy Date</td>
                                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                                </tr>

                                <tr class="buoy">
                                    <td>Buoy Station</td>
                                    <td colspan="2"><select class="form-control" style="width: 100%" id="buoy_list">
                                            <option value="41002"> Cape Hatteras, NC</option>
                                            <option value="41008"> Savannah, GA</option>
                                            <option value="41012"> St. Augustine, FL</option>
                                            <option value="41013"> Frying Pan Shoals, NC</option>
                                            <option value="41046"> San Salvador, Bahamas</option>
                                            <option value="41047"> Nassau, Bahamas</option>
                                            <option value="41048"> Bermuda</option>
                                            <option value="42001"> Southwest Pass, LA</option>
                                            <option value="42003"> Naples, FL</option>
                                            <option value="42012"> Mobile, AL</option>
                                            <option value="42020"> Corpus Christi, TX</option>
                                            <option value="42036"> Tampa, FL</option>
                                            <option value="42056"> Cozumel, Mexico</option>
                                            <option value="42058"> Kingston, Jamaica</option>
                                            <option value="44014"> Virginia Beach, VA</option>
                                            <option value="44025"> Islip, NY</option>
                                            <option value="44037"> Jordan Basin, Gulf of ME</option>
                                            <option value="44056"> Duck, NC</option>
                                            <option value="44065"> New York Harbor, NY</option>
                                            <option value="99999"> Offshore Oil Port, LA</option>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td>
                                        <button id="btn_show_model" class="btn btn-success">Show Validation Plots</button>
                                    </td>
                                </tr>
                                <tr style="height: 40px">
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="panel panel-primary ">
                                            <div class="sec-header">Instructions</div>
                                            <div class="panel-body">
                                                <div style="color: black;padding-left: 10px">
                                                    This page compares weather observational data to model predictions. 
                                                    <br><br>Choose a variable, date, and buoy, then Show Validation Plots. 
                                                    <br><br>Winds: "u" wind is east (positive) - west (negative) and "v" wind is north (positive)-south (negative).
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

