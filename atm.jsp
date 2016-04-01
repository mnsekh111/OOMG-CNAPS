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
    <script type="text/javascript" src="./lib/animation_wa.js"></script>
    <script type="text/javascript" src="./lib/wave.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>


    <script type="text/javascript">
        var map;
        var overlaysArray = [];
        var root = "<%=Global.figures_location%>";
        var variable = "slp";
        var date;


        $(document).ready(function () {
            initialize();
            // alert($("#datepicker").datepicker({dateFormat: 'mm/dd/yyyy'}).val());

            <%
                TimePeriod tp = new TimePeriod();
                ArrayList<String> tmp = tp.getTimePeriod();

                for (int i = 0; i < tmp.size(); i++) {
            %>
            availableDates.push(<%=tmp.get(i)%>);

            <%
                }
            %>

            loadMoreDates($("#datepicker").datepicker({dateFormat: 'mm/dd/yyyy'}).val());

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
                variable = this.value;
                //alert("variable list changed " + this.value);
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
        }

    </script>


    <style>
        .main-content {
            background: #dbdfe5;
        }

        .sec-header {
            background-color:#3A5ECA;
            color:white;
            font-size: larger;
            font-weight: bold;
            padding:2px;
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
                        <option value="slp">Sea level Pressure</option>
                        <option value="w">10 m Wind</option>
                        <option value="at">2 m Temperature</option>
                    </select></td>
                </tr>
                <tr>
                    <td>Start Date</td>
                    <td colspan="2"><input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                </tr>
                <tr>
                    <td>Date and Time</td>
                    <td colspan="2"><select class="form-control" style="width: 100%" id="time_list">
                    </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <button id="btn_download" class="btn btn-info">Download data</button>
                    </td>
                </tr>
                <tr style="height: 40px">
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

    <br><br>
    <div class="panel panel-primary ">
        <div class="sec-header">Instructions</div>
        <div class="panel-body">
            <ul>
                <li><strong>Date and Time:</strong> Click on the date and time from the list to be
                    shown on the map. Dates
                    before the present can be selected to populate the Date and Time list.
                </li>
                <li><strong>Variables:</strong> Click on the variable to be shown on the map.</li>
                <li><strong>Animation:</strong> Click on "Start animation" to display the 72 hour
                    forecast from today. Click on
                    "Stop" to terminate the animation. Please allow the animation to run through
                    once before it becomes smooth.
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

