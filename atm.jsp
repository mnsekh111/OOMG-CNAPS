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

        function getYYYYMMYY(date) {
            return "" + date.getFullYear() + "" + ((date.getMonth() + 1) < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1))
                    + "" + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate());
        }

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
                        document.getElementById('download').href = download();
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

    </style>


</head>
<body>

<div class="jumbotron" style="background: -webkit-linear-gradient(left,#0A38B5,
        #33ccff);color:white;margin-bottom: 2px">

    <div class="container">
        <h1>CNAPS</h1>
        <p>Coupled Northwest Atlantic Prediction System</p>
    </div>

</div>
<div>
    <nav role="navigation" class="navbar navbar-default">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="#" style="background-color: #0A38B5;color: white" class="navbar-brand">CNAPS</a>
        </div>
        <!-- Collection of nav links, forms, and other content for toggling -->
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="atm.jsp" title="Marine Weather">Marine Weather</a></li>
                <li><a href="wave.jsp" title="waves">Ocean Waves</a></li>
                <li><a href="ocean.jsp" title="Circulation">Ocean Circulation</a></li>
                <li class="dropdown"><a href="#" title="Transect" data-toggle="dropdown" class="dropdown-toggle">Virtual
                    Oceanographer<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="transect.jsp" title="Transect">Virtual Transect</a></li>
                        <li><a href="vertical.jsp" title="Profile">Temp & Salinity Profile</a></li>
                        <li><a href="trajectory.jsp" title="Drifter Trajectory">Drifter Trajectory</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a href="#" title="Model Validation" data-toggle="dropdown"
                                        class="dropdown-toggle">Model Validation<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="val.jsp" title="MV - Circulation">Circulation</a></li>
                        <li><a href="weather.jsp" title="MV - Weather">Weather</a></li>
                        <li><a href="waveval.jsp" title="MV - Wave height">Wave Height</a></li>
                        <li><a href="ensemble.jsp" title="MV - Ensemble">Ensemble</a></li>
                    </ul>
                </li>
                <li><a href="methods.jsp" title="Methods">Methods</a></li>
            </ul>


        </div>
    </nav>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
            <div class="main-content" id="map_canvas" style="float:left; width:100%;height:600px;"></div>
            <br><br>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
            <!--Nested rows within a column-->

            <table class="table" style="table-layout: fixed; word-wrap: break-word">
                <thead>
                <tr style="background: #0A38B5; color: white">
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
                    <td>Download</td>
                    <td>
                        <button id="btn_download" class="btn btn-info">Download data</button>
                    </td>
                </tr>
                <tr style="height: 40px">
                </tr>
                </tbody>
            </table>

            <table class="table" style="table-layout: fixed; word-wrap: break-word">
                <thead>
                <tr style="background: #0A38B5; color: white">
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
    <div class="panel panel-primary">
        <div class="panel-heading">Instructions</div>
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
<a id="download" href="#" display="none">Download</a>
<footer id="footer" class="jumbotron" style="background-color:rgba(0, 0, 0, 0.73);color:white;margin-bottom:
        2px">
    <div class="container-fluid">
        <p style="font-size: 15px"><span style="color: red">DISCLAIMER:</span> This nowcast/forecast system is a
            research product developed and maintained by the <a href="http://www.go.ncsu.edu/oomg">Ocean Observing and
                Modeling Group</a> at North Carolina State University. No warranty is made, expressed, or implied
            regarding the accuracy or validity of model results, nor regarding the suitability of the model output for
            any particular application. </p>
    </div>
    <hr/>
    <div class="container" align="center">
        <div class="container-fluid" style="display:inline-block" align="center">
            <p style="padding-left:10px;">Thanks to our sponsors:</p>
            <div class="row">
                <div class="col-lg-2 col-md-4"><img style="display:inline-block" width="200px" height="200px"
                                                    src="mns-images/omg_logo2.png"
                                                    class="img-thumbnail img-responsive" alt="Placeholder image"></div>
                <div class="col-lg-2 col-md-4"><img style="display:inline-block" width="200px" height="200px"
                                                    src="mns-images/ncsu_logo.jpg"
                                                    class="img-thumbnail img-responsive" alt="Placeholder image"/></div>
                <div class="col-lg-2 col-md-4"><img style="display:inline-block" width="200px" height="200px"
                                                    src="mns-images/secoora.jpg" class="img-thumbnail img-responsive"
                                                    alt="Placeholder image"/></div>
                <div class="col-lg-2 col-md-4"><img style="display:inline-block" width="200px" height="200px"
                                                    src="mns-images/noaa-logo.jpg"
                                                    class="img-thumbnail img-responsive" alt="Placeholder image"/></div>
                <div class="col-lg-2 col-md-4"><img style="display:inline-block" width="200px" height="200px"
                                                    src="mns-images/renci.jpg" class="img-thumbnail img-responsive"
                                                    alt="Placeholder image"/></div>
            </div>
        </div>
    </div>
    <hr/>
    <div class="container">

        <p style="font-size:15px; text-align:center">Questions or comments? Contact the <a
                href="http://www.go.ncsu.edu/oomg">Ocean Observing and Modeling Group</a> (OOMG) at
            OceanObservingAndModeling&nbsp;[at]&nbsp;ncsu&nbsp;[dot]&nbsp;edu</p>
        <p style="font-size:15px; text-align:center">&copy;Copyright 2015 Ocean Observing and Modeling Group, North
            Carolina State University</p>
    </div>

        <span style="text-align:center;"><a href="http://extremetracking.com/open?login=omgncsu"><img
                src="http://t1.extreme-dm.com/i.gif" style="border: 0; float:left;" height="100" width="100" id="EXim"
                alt="eXTReMe Tracker"/></a></span><br/>
    <br/>


    <script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <script type="text/javascript"><!--
    EXref = "";
    top.document.referrer ? EXref = top.document.referrer : EXref = document.referrer; //-->

    </script>
    <script type="text/javascript"><!--
    var EXlogin = 'omgncsu' // Login
    var EXvsrv = 's9' // VServer
    EXs = screen;
    EXw = EXs.width;
    navigator.appName != "Netscape" ?
            EXb = EXs.colorDepth : EXb = EXs.pixelDepth;
    EXsrc = "src";
    navigator.javaEnabled() == 1 ? EXjv = "y" : EXjv = "n";
    EXd = document;
    EXw ? "" : EXw = "na";
    EXb ? "" : EXb = "na";
    EXref ? EXref = EXref : EXref = EXd.referrer;
    EXd.write("<img " + EXsrc + "=http://e0.extreme-dm.com",
            "/" + EXvsrv + ".g?login=" + EXlogin + "&amp;",
            "jv=" + EXjv + "&amp;j=y&amp;srw=" + EXw + "&amp;srb=" + EXb + "&amp;",
            "l=" + escape(EXref) + " height=1 width=1>"); //-->
    </script>
    <noscript>
        <div id="neXTReMe"><img height="1" width="1" alt=""
                                src="http://e0.extreme-dm.com/s9.g?login=omgncsu&amp;j=n&amp;jv=n"/></div>
    </noscript>
</footer>
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

