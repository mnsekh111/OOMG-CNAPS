<%@page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@page import="util.Global" %>
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

        <script type="text/javascript" src="./lib/global.js"></script>
        <script type="text/javascript" src="./lib/wave.js"></script>
        <script type="text/javascript" src="./lib/animation.js"></script>


        <script type="text/javascript">
            var map;
            var root = "<%=Global.figures_location%>";
            var variable = "swd";
            var date;
            var start_date, end_date;
            var depth = "";
            var time;


            $(document).ready(function () {
                initialize();
                $("#id_list_nav > li:nth-child(2)").addClass("active");
                downloadFigure();
            });

            function disableUI() {
                $("#datepicker").prop("disabled", true);
                $("#btn_start_anim").prop("disabled", true);
                $("#btn_stop_anim").prop("disabled", false);
                $("#btn_download").prop("disabled", true);
                $("#datepicker-anim-end").prop("disabled", true);
                $("#datepicker-anim-start").prop("disabled", true);
                $("#datepicker-time").prop("disabled", true);
                $("#time_list").prop("disabled", true);
//                $("#variable_list").prop("disabled",true);
            }


            function enableUI() {
                $("#datepicker").prop("disabled", false);
                $("#btn_start_anim").prop("disabled", false);
                $("#btn_stop_anim").prop("disabled", true);
                $("#btn_download").prop("disabled", false);
                $("#datepicker-anim-end").prop("disabled", false);
                $("#datepicker-anim-start").prop("disabled", false);
                $("#datepicker-time").prop("disabled", false);
                $("#time_list").prop("disabled", false);
//                $("#variable_list").prop("disabled",false);
            }


            function initialize() {

                start_date = getYYYYMMYY(new Date);
                end_date = getYYYYMMYY(new Date);
                date = getYYYYMMYY(new Date);
                time = getTimeHHHH(getTime(new Date()));

                $('#btn_start_anim').prop('disabled', false);
                $('#btn_stop_anim').prop('disabled', true);
                $('#btn_download').prop('disabled', false);
                $("#time_list").val(getTime(new Date())).change();

                $("#datepicker").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function (dateText, inst) {
                        var temp = new Date(dateText);
                        date = getYYYYMMYY(temp);
                        downloadFigure();
                    }
                }).datepicker("setDate", new Date());

                var minDate = new Date
                $("#datepicker-anim-end").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    minDate: minDate,
                    maxDate: "+2D",
                    onSelect: function (dateText, inst) {
                        var date = new Date(dateText);
                        end_date = getYYYYMMYY(date);
                    }
                }).datepicker("setDate", new Date);


                $("#datepicker-anim-start").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    maxDate: new Date,
                    onSelect: function (dateText, inst) {
                        var endDate = new Date(dateText);
                        endDate.setDate(endDate.getDate() + 2);
                        $("#datepicker-anim-end").datepicker(
                                "change",
                                {
                                    minDate: new Date($('#datepicker-anim-start').val()),
                                    maxDate: endDate
                                }
                        );

                        var date = new Date(dateText);
                        start_date = getYYYYMMYY(date);
                        end_date = getYYYYMMYY(endDate);
                    }
                }).datepicker("setDate", new Date());


                $('#time_list').change(function () {
                    time = getTimeHHHH(this.value);
                    downloadFigure();
                });


                $("#btn_start_anim")
                        .click(function () {
                            disableUI();
                            startAnimation();
                        });

                $("#btn_stop_anim")
                        .click(function () {
                            enableUI();
                            stopAnimation();
                        });

                $(document).ready(function () {
                    $('.dropdown-toggle').dropdown();
                });

                $("#btn_download")
                        .click(function () {
                           downloadkmz();
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
    <body style="background-color:#3A5ECA">

        <jsp:include page="header.jsp"></jsp:include>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
                        <div class="main-content" id="map_canvas" style="float:left; width:100%;height:600px;"></div>

                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
                        <!--Nested rows within a column-->

                        <table class="table" style="table-layout: fixed; word-wrap: break-word;color: white">
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
                                    <td>Time</td>
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
                                        <button id="btn_download" class="btn btn-info">Download data</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="table" style="table-layout: fixed; word-wrap: break-word;color:white">
                            <thead>
                                <tr class="sec-header">
                                    <td colspan="3">Animation</td>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td>Start Date</td>
                                    <td colspan="2"><input class="form-control" style="width: 100%" type="text"
                                                           id="datepicker-anim-start"></td>
                                </tr>
                                <tr>
                                    <td>End Date</td>
                                    <td colspan="2"><input class="form-control" style="width: 100%" type="text"
                                                           id="datepicker-anim-end"></td>
                                </tr>

                                <tr>
                                    <td>
                                        <button id="btn_start_anim" class="btn btn-success">Start Animation</button>
                                    </td>
                                    <td>
                                        <button id="btn_stop_anim" class="btn btn-danger">Stop Animation</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <br>
                <br>
                <div class="panel panel-primary">
                    <div class="sec-header">Instructions</div>
                    <div class="panel-body">
                        <ul>
                            <li><strong>Date and Time:</strong> Click on the date and time from the list to be
                                shown on the map. Dates before the present can be selected to populate the Date
                                and Time list.
                            </li>
                            <li><strong>Animation:</strong> Click on &quot;Start animation&quot; to display the
                                72 hour forecast from today. Click on &quot;Stop&quot; to terminate the
                                animation. Please allow the animation to run through once before it becomes
                                smooth.
                            </li>
                            <li><strong>Download:</strong> Click Download to save a copy of the map (as a KMZ
                                file).
                            </li>
                        </ul>
                    </div>
                </div>
            </div>


            <br>
            <br>
            <a id="download" href="#" display="none">Download</a>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
