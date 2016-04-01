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
                    buoy_date=dateText;
                    if(buoy!==null)
                    {
                        alert(buoy_date);
                        $.get(	"servlet/WaveValServlet?"+
                                "day="+buoy_date.substring(0,8)+"&"+
                                "date="+buoy_date+"&"+"buoy="+buoy, function(data){
                            if (data=="fail"){
                                alert("Sorry, this data is not available yet.");
                                return;
                            }});
                        window_handle = window.open("wavevalimage.jsp?day="+buoy_date.substring(0,8)+"&"+"date="+buoy_date+"&"+"buoy="+buoy, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=800' );
                    }
                }
            }).datepicker("setDate", new Date());


            $('#buoy_list').change(function () {
                buoy = this.id;
                if (buoy_date != null) {
                    window.open("wavevalimage.jsp?day=" + buoy_date.substring(0, 8) + "&date=" + buoy_date + "&buoy=" + buoy, "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=470, width=800');
                }
            });


            $(document).ready(function () {
                $('.dropdown-toggle').dropdown();
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

                <tr style="height: 40px"></tr>
                <tr>
                    <td colspan="3">
                        <div class="panel panel-primary">
                            <div class="sec-header">Instructions</div>
                            <div class="panel-body">
                                <ul style="color: black">
                                    <li>This page compares observational data to model predictions.
                                    </li>
                                    <li>First, choose a date from the Date list. Dates before the present can be
                                        selected to populate the Date list.
                                    </li>
                                    <li>Then choose a buoy station from the list or the map. A plot of observational
                                        data, when available, and model output will appear in
                                    </li>
                                    <li>a new window.</li>
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

