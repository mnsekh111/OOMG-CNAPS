<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@ page import="method.TimePeriod" %>
<%@ page import="util.Global" %>
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
    <script type="text/javascript" src="./lib/animation_wa.js"></script>
    <script type="text/javascript" src="./lib/wave.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>


    <script type="text/javascript">
        var map;
        var overlaysArray = [];
        var root = "<%=Global.figures_location%>";
        var depth = "0";
        var variable1 = "uv";
        var variable = variable1 + "_" + depth;
        var date;

        $(document).ready(function () {
            mapInit();
            initialize();
            loadMoreDates($("#datepicker").datepicker({dateFormat: 'mm/dd/yyyy'}).val());
//                        alert($("#datepicker").datepicker({dateFormat: 'mm/dd/yyyy'}).val());
            <%
                TimePeriod tp = new TimePeriod();
                ArrayList<String> tmp = tp.getTimePeriod();
                //Only last 7 days is needed
                //List<String> dates = tmp.subList(tmp.size() - 7, tmp.size());
                List<String> dates = tmp;
                for (int i = 0; i < dates.size(); i++) {
            %>
            availableDates.push(<%=dates.get(i)%>);
            <%
                }
            %>

            $("#id_list_nav > li:nth-child(3)").css({"background-color": "#041648"})

        });

        function initialize() {

            $('#btn_start_anim').prop('disabled', false);
            $('#btn_stop_anim').prop('disabled', true);
            $('#btn_download').prop('disabled', false);

            start_date = getYYYYMMYY(new Date);
            end_date = getYYYYMMYY(new Date);

            $("#datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                onSelect: function (dateText, inst) {
                    //alert(dateText);
                    loadMoreDates(dateText);
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
                }
            }).datepicker("setDate", new Date());

            $('#time_list').change(function () {
                date = this.value;
                //alert("time list changed " + this.value);
                plotwa();
            });

            $('#variable_list').change(function () {
                variable1 = this.value;
                variable = variable1 + "_" + depth;
                //alert("variable list changed " + this.value);
                plotwa();
            });

            $('#depth_list').change(function () {
                depth = this.value;
                variable = variable1 + "_" + depth;
                //alert("depth list changed " + this.value);
                plotwa();
            });


            $("#btn_start_anim")
                    .click(function () {
                        $(this).prop("disabled", true);
                        $('#btn_stop_anim').prop("disabled", false);
                        foo();
                    });

            $("#btn_stop_anim")
                    .click(function () {
                        $(this).prop("disabled", true);
                        $('#btn_start_anim').prop("disabled", false);
                        stopCount();
                    });
            $(document).ready(function () {
                $('.dropdown-toggle').dropdown();
            });

            $("#btn_download")
                    .click(function () {
                        window.location = download();
                    });


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
                    <td class="sec-header">Variable</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="variable_list">
                        <option value="uv">Current</option>
                        <option value="t">Temperature</option>
                        <option value="s">Salinity</option>
                    </select></td>
                </tr>
                <tr>
                    <td>Start Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                </tr>
                <tr>
                    <td>Dates</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="time_list">
                    </select>
                    </td>
                </tr>
                <tr>
                    <td class="sec-header">Depth</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="depth_list">
                        <option value="0">0 m</option>
                        <option value="5">5 m</option>
                        <option value="10">10 m</option>
                        <option value="15">15 m</option>
                        <option value="20">20 m</option>
                        <option value="30">30 m</option>
                        <option value="40">40 m</option>
                        <option value="50">50 m</option>
                        <option value="75">75 m</option>
                        <option value="100">100 m</option>
                        <option value="125">125 m</option>
                        <option value="150">150 m</option>
                        <option value="200">200 m</option>
                        <option value="250">250 m</option>
                        <option value="300">300 m</option>
                        <option value="400">400 m</option>
                        <option value="500">500 m</option>
                        <option value="600">600 m</option>
                        <option value="800">800 m</option>
                        <option value="1000">1000 m</option>
                        <option value="1200">1200 m</option>
                        <option value="1500">1500 m</option>
                        <option value="2000">2000 m</option>
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
        <br>
        <br>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading sec-header">Instructions</div>
        <div class="panel-body">
            <ul>
                <li><strong>Date and Time:</strong> Click on the date and time from the list to be
                    shown on the map. Dates before the present can be selected to populate the Date
                    and Time list.
                </li>

                <li><strong>Depth:</strong> Click on the depth isosurface to display. Current at 0 m
                    shows currents, wind vectors (magenta arrows), and sea surface height (colors).
                </li>
                <li><strong>Variables:</strong> Click on the variable to be shown on the map.</li>
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
<jsp:include page="footer.jsp"/>
</body>
</html>