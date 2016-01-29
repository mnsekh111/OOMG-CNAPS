<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@page import="method.TimePeriod" %>
<%@page import="util.Global" %>
<%@ page import="java.util.Arrays" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%--<!DOCTYPE html>--%>
<%--<html lang="en-US">--%>
<%--<head>--%>
<%--<title>CNAPS Coupled Northwest Atlantic Prediction System</title>--%>

<%--<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>--%>
<%--<link type="text/css" href="layout.css" rel="stylesheet">--%>
<%--<link type="text/css" href="reset.css" rel="stylesheet">--%>
<%--<script type="text/javascript"--%>
<%--src="http://maps.google.com/maps/api/js?sensor=false">--%>
<%--</script>--%>

<%--<link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet"/>--%>
<%--<link rel="stylesheet" href="/css/jquery-ui.css"/>--%>
<%--<script src="http://code.jquery.com/jquery-1.8.2.js"></script>--%>
<%--<script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>--%>
<%--<link rel="stylesheet" href="/resources/demos/style.css"/>--%>
<%--<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.js"></script>--%>
<%--<script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.min.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.button.js"></script>--%>
<%--<script src="./jquery/development-bundle/external/jquery.bgiframe-2.1.2.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.mouse.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.draggable.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.position.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.resizable.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.dialog.js"></script>--%>
<%--<script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script>--%>
<%--<script type="text/javascript" src="./lib/loadImage.js"></script>--%>
<%--<script type="text/javascript" src="./lib/animation_wa.js"></script>--%>
<%--<script type="text/javascript" src="./lib/wave.js"></script>--%>
<%--<script type="text/javascript" src="./lib/global.js"></script>--%>
<%--<script type="text/javascript">--%>
<%--var map;--%>
<%--var overlaysArray = [];--%>
<%--var root = "<%=Global.figures_location %>";--%>
<%--var variable = "slp";--%>
<%--var date;--%>

<%--$(document).ready(function () {--%>
<%--initialize();--%>
<%--});--%>

<%--function initialize() {--%>

<%--$(function () {--%>
<%--$("#variables").buttonset();--%>
<%--$("#time-list").buttonset();--%>
<%--});--%>

<%--$('#variables > input').on("click",--%>
<%--function () {--%>
<%--variable = this.id;--%>
<%--plotwa();--%>
<%--});--%>
<%--$('#time-list > input').on("click",--%>
<%--function () {--%>
<%--date = this.id;--%>
<%--plotwa();--%>
<%--});--%>

<%--$(function () {--%>
<%--$("#datepicker").datepicker({--%>
<%--changeMonth: true,--%>
<%--changeYear: true,--%>
<%--onSelect: function (dateText, inst) {--%>
<%--loadMoreDates(dateText);--%>
<%--}--%>
<%--});--%>
<%--});--%>

<%--$(document).ready(function () {--%>
<%--$("#showtext").click(function () {--%>
<%--$("#description").toggle();--%>
<%--});--%>
<%--});--%>

<%--$(function () {--%>
<%--$("#showtext").button({--%>
<%--icons: {--%>
<%--primary: "ui-icon-plusthick"--%>
<%--},--%>
<%--text: false--%>
<%--});--%>
<%--});--%>
<%--$(function () {--%>
<%--$("#download")--%>
<%--.button()--%>
<%--.click(function () {--%>
<%--document.getElementById('download').href = download();--%>
<%--});--%>
<%--});--%>


<%--//$(document).ready(function(){--%>
<%--//	$("#description").hide();--%>
<%--//});--%>

<%--mapInit();--%>

<%--//InitLatlng(map);--%>

<%--//To display the default figure (current day, 0 meter, uv) on the map--%>
<%--var d = new Date();--%>
<%--var month = d.getMonth() + 1;--%>
<%--//d.setDate(d.getDate()-1)--%>
<%--var day_0 = d.getDate();--%>
<%--//d.setDate(day_0+1);--%>
<%--//var day_0=d.getDate()-1;--%>
<%--if (month < 10)--%>
<%--month = "0" + month.toString();--%>
<%--else--%>
<%--month = month.toString();--%>
<%--if (day_0 < 10)--%>
<%--day_0 = "0" + day_0.toString();--%>
<%--else--%>
<%--day_0 = day_0.toString();--%>
<%--var s = (d.getYear() + 1900).toString() + month + day_0 + "_0000";--%>

<%--//ie doesn't work using $().click();--%>
<%--$('#' + s).trigger('click');--%>
<%--}--%>

<%--</script>--%>

<%--<script type="text/javascript">--%>

<%--var _gaq = _gaq || [];--%>
<%--_gaq.push(['_setAccount', 'UA-12288686-5']);--%>
<%--_gaq.push(['_trackPageview']);--%>

<%--(function () {--%>
<%--var ga = document.createElement('script');--%>
<%--ga.type = 'text/javascript';--%>
<%--ga.async = true;--%>
<%--ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';--%>
<%--var s = document.getElementsByTagName('script')[0];--%>
<%--s.parentNode.insertBefore(ga, s);--%>
<%--})();--%>

<%--</script>--%>

<%--</head>--%>
<%--<body>--%>
<%--<div id="page">--%>
<%--<div id="logo">--%>
<%--<img src="image/bannerCNAPS.png" width="1140" height="120">--%>
<%--</div> <!--end div id "logo" -->--%>
<%--<div id="box">--%>
<%--<div id="links">--%>
<%--<jsp:include page="links.jsp"></jsp:include>--%>
<%--</div><!-- end div "links" -->--%>
<%--<div id="title">Marine Weather--%>
<%--</div>  <!-- end div "title" -->--%>

<%--<div id="map">--%>
<%--<form>--%>
<%--<div id="variables">--%>
<%--<span class="text">Variables:</span>--%>
<%--<input type="radio" id="w" name="radio"/><label for="w">10m Wind</label>--%>
<%--<input type="radio" id="at" name="radio"/><label for="at">2m Temperature</label>--%>
<%--<input type="radio" id="slp" name="radio" checked="checked"/><label for="slp">Sea Level--%>
<%--Pressure</label>--%>
<%--</div>  <!--end div id "variables" -->--%>
<%--</form>--%>
<%--<div id="map_canvas"></div>--%>

<%--<div id="date">--%>

<%--<form>--%>

<%--<div id="time-list">--%>
<%--<span class="text">Date and Time:</span>--%>
<%--<br>--%>
<%--<%--%>
<%--TimePeriod tp = new TimePeriod();--%>
<%--ArrayList<String> tmp = tp.getTimePeriod();--%>
<%--//Only last 7 days is needed--%>
<%--List<String> dates = tmp.subList(tmp.size() - 7, tmp.size());--%>
<%--%>--%>
<%--<script type="text/javascript">--%>
<%--date = <%=dates.get(dates.size()-4) %>+"_0000";--%>
<%--</script>--%>
<%--<%--%>
<%--for (int i = 0; i < dates.size(); i++) {--%>
<%--%>--%>
<%--<script>--%>
<%--availableDates.push(<%=dates.get(i)%>);--%>
<%--</script>--%>
<%--<%--%>

<%--for (int j = 0; j <= 21; j += 3) {--%>
<%--String str_date = dates.get(i) + "_";--%>
<%--if (j < 10)--%>
<%--str_date += "0";--%>
<%--str_date += String.valueOf(j) + "00";--%>
<%--String str_date_format = dates.get(i).subSequence(4, 6) + "/" + dates.get(i).substring(6, 8) + "/" + dates.get(i).substring(0, 4)--%>
<%--+ " " + str_date.substring(9, 11) + ":" + str_date.substring(11);--%>
<%--%>--%>
<%--<input type="radio" id="<%=str_date%>" name="radio"/><label--%>
<%--for="<%=str_date%>"><%=str_date_format%>--%>
<%--</label>--%>
<%--<%--%>

<%--}--%>
<%--}--%>
<%--%>--%>
<%--</div> <!-- end div id "time-list" -->--%>
<%--</form>--%>
<%--<div id="archive_0">--%>
<%--Choose a date to populate the Date and Time list:--%>
<%--<input type="text" id="datepicker">--%>
<%--</div>  <!-- end div id "archive_0" -->--%>
<%--<!--<dir id="archive_1">--%>
<%--Please select the date below: <input type="text" id="datepicker">--%>
<%--</dir>  -->--%>
<%--<br>--%>
<%--<div id="animationbutton">--%>
<%--<form>--%>
<%--<input type="button" id="start" OnClick="foo();" value="Start animation"/>--%>
<%--<input type="button" OnClick="stopCount();" disabled="disabled" value="Stop"/>--%>
<%--</form>--%>
<%--</div>  <!-- end div id "animation button" -->--%>
<%--<a id="download" href="#">Download</a>--%>
<%--<div id="description">--%>
<%--<h1>Instructions</h1>--%>
<%--<ul>--%>
<%--<li><strong>Date and Time:</strong> Click on the date and time from the list to be shown on the--%>
<%--map. Dates before the present can be selected to populate the Date and Time list.--%>
<%--</li>--%>
<%--<li><strong>Variables:</strong> Click on the variable to be shown on the map.</li>--%>
<%--<li><strong>Animation:</strong> Click on &quot;Start animation&quot; to display the 72 hour--%>
<%--forecast from today. Click on &quot;Stop&quot; to terminate the animation. Please allow the--%>
<%--animation to run through once before it becomes smooth.--%>
<%--</li>--%>
<%--<li><strong>Download:</strong> Click Download to save a copy of the map (as a KMZ file).</li>--%>
<%--</ul>--%>
<%--</div><!-- end div "description"  -->--%>
<%--</div><!-- end div "date"  -->--%>
<%--</div><!-- end div "map"  -->--%>
<%--<div id="footer">--%>
<%--<jsp:include page="footer.jsp"></jsp:include>--%>
<%--</div>--%>
<%--</div><!-- end div "box"  -->--%>
<%--</div><!-- end div "page"  -->--%>
<%--</body>--%>
<%--</html>--%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="./mns-css/bootstrap.css">
        <link rel="stylesheet" href="./mns-css/bootstrap-theme.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">


        <!-- Script region -->

        <script type="text/javascript"
                src="http://maps.google.com/maps/api/js?sensor=false">
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

        <script src="content/js/jquery.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script>
        <script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script>


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
                    });

                    function initialize() {

//                        $(function () {
//                            $("#variables").buttonset();
//                            $("#time-list").buttonset();
//                        });
//
//                        $('#variables > input').on("click",
//                                function () {
//                                    variable = this.id;
//                                    plotwa();
//                                });
//                        $('#time-list > input').on("click",
//                                function () {
//                                    date = this.id;
//                                    plotwa();
//                                });

                        $(function () {
                            $("#datepicker").datepicker({
                                changeMonth: true,
                                changeYear: true,
                                onSelect: function (dateText, inst) {
                                    loadMoreDates(dateText);
                                }
                            });
                        });

                        $('#time_list').change(function () {
                            date = this.value;
                            alert("time list changed " + this.value);
                            plotwa();
                        });
                        
                          $('#variable_list').change(function () {
                            variable = this.value;
                            alert("variable list changed " + this.value);
                            plotwa();
                        });
                        
                        
                        

                        $(document).ready(function () {
                            $("#showtext").click(function () {
                                $("#description").toggle();
                            });
                        });

                        $(function () {
                            $("#showtext").button({
                                icons: {
                                    primary: "ui-icon-plusthick"
                                },
                                text: false
                            });
                        });
                        $(function () {
                            $("#download")
                                    .button()
                                    .click(function () {
                                        document.getElementById('download').href = download();
                                    });
                        });


                        //$(document).ready(function(){
                        //	$("#description").hide();
                        //});

                        mapInit();

                        //InitLatlng(map);

                        //To display the default figure (current day, 0 meter, uv) on the map
                        var d = new Date();
                        var month = d.getMonth() + 1;
                        //d.setDate(d.getDate()-1)
                        var day_0 = d.getDate();
                        //d.setDate(day_0+1);
                        //var day_0=d.getDate()-1;
                        if (month < 10)
                            month = "0" + month.toString();
                        else
                            month = month.toString();
                        if (day_0 < 10)
                            day_0 = "0" + day_0.toString();
                        else
                            day_0 = day_0.toString();
                        var s = (d.getYear() + 1900).toString() + month + day_0 + "_0000";

                        //ie doesn't work using $().click();
                        $('#' + s).trigger('click');
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

        </style>


    </head>
    <body>

        <div class="jumbotron" style="background: -webkit-linear-gradient(left,#0A38B5, #33ccff);color:white;margin-bottom: 2px">

            <div class="container">
                <h1>CNAPS</h1>
                <p>Coupled Northwest Atlantic Prediction System</p>
            </div>

        </div>
        <div class="bs-example">
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
                    <ul class="nav navbar-nav"">
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
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
                    <div class="main-content" id="map_canvas" style="float:left; width:100%;height:600px;"></div>

                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
                    <!--Nested rows within a column-->

                    <table class="table" style="table-layout: fixed; word-wrap: break-word">
                        <tbody>
                            <tr>
                                <td>Variable</td>
                                <td colspan="2"> <select class="form-control" style="width: 100%" id="variable_list">
                                        <option value="w">10 m Wind</option>
                                        <option value="at">2 m Temperature</option>
                                        <option value="slp">Sea level Pressure</option> 
                                    </select></td>
                            </tr>
                            <tr>
                                <td>Dates</td>
                                <td colspan="2"><select class="form-control" style="width: 100%" id="time_list">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Depth</td>
                                <td colspan="2"><select class="form-control" style="width: 100%">
                                        <option>0 m</option>
                                        <option>5 m</option>
                                        <option>10 m</option>
                                        <option>15 m</option>
                                        <option>20 m</option>
                                        <option>25 m</option>
                                        <option>30 m</option>
                                        <option>35 m</option>
                                    </select></td>
                            </tr>
                            <tr>
                                <td>Start Date</td>
                                <td colspan="2"> <input class="form-control" style="width: 100%" type="text" id="datepicker"></td>
                            </tr>
                            <tr>
                                <td><button id="btn2" class="btn btn-danger">Stop Animation</button></td>
                                <td> <button id="btn" class="btn btn-success">Start Animation</button></td>
                                <td><button id="btn0" class="btn btn-info">Download data</button></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div class="panel panel-success">
                                        <div class="panel-heading">Instructions</div>
                                        <div class="panel-body">
                                            <ul>
                                                <li><strong>Date and Time:</strong> Click on the date and time from the list to be shown on the map. Dates before the present can be selected to populate the Date and Time list. </li>
                                                <li><strong>Variables:</strong> Click on the variable to be shown on the map.</li> 
                                                <li><strong>Animation:</strong> Click on "Start animation" to display the 72 hour forecast from today. Click on "Stop" to terminate the animation. Please allow the animation to run through once before it becomes smooth.</li>
                                                <li><strong>Download:</strong> Click Download to save a copy of the map (as a KMZ file).</li>
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
        <footer id="footer" class="jumbotron" style="background-color:rgba(0, 0, 0, 0.73);color:white;margin-bottom: 2px">
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
                top.document.referrer ? EXref = top.document.referrer : EXref = document.referrer;//-->

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
                        "l=" + escape(EXref) + " height=1 width=1>");//-->
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

