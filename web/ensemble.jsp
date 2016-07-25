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
                src="http://maps.google.com/maps/api/js?key=AIzaSyDx-ZeKRkXTjD1iNGF6tGD85U3M2x5lYV4">
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="./lib/global.js"></script>

        <script type="text/javascript">
                    var ensemble_date;
                    var variable;


                    $(document).ready(function () {
                        initialize();
                        loadEnsembleImage();
                    });


                    function loadEnsembleImage() {
//                        var xhttp = new XMLHttpRequest();
//                        xhttp.onreadystatechange = function () {
//                            alert(xhttp.statusText);
//                            if (xhttp.readyState == 4 && xhttp.status == 200) {
//                                alert("got a response ");
//                            }
//                        };
//                        xhttp.open("GET", "servlet/Ensemble?" +
//                                "date=" + ensemble_date + "&variable=" + variable, true);
//                        xhttp.send();
                        document.getElementById("img_ensemble").src = "servlet/Ensemble?" +
                                "date=" + ensemble_date + "&variable=" + variable;
                    }

                    function initialize() {

                        variable = "t";
                        var date = getYYYYMMYY(new Date());
                        ensemble_date = date;
                        $('#variable_list').change(function () {
                            variable = this.value;
                        });


                        $("#datepicker").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            onSelect: function (dateText, inst) {
                                var date = new Date(dateText);
                                ensemble_date = getYYYYMMYY(date);
                                
                            }

                        }).datepicker("setDate", new Date());

                        $('#btn_show_model').on("click",function(){
                            loadEnsembleImage();
                        });

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

                        $("#id_list_nav > li:nth-child(5)").addClass("active");
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
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1"></div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                        <div class="main-content"  style="float:left; width:90%;height:700px;">
                            <img id="img_ensemble" src="" alt="Sorry, the image is not available yet" height="700px" width="100%"  >
                        </div>
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
                                    <td>Variable</td>
                                    <td colspan="2"><select class="form-control" style="width: 100%" id="variable_list">
                                            <option value="t">Temperature</option>
                                            <option value="s">Salinity</option>
                                            <option value="uv">Current</option>
                                        </select></td>
                                </tr>

                                <tr>
                                    <td>
                                        <button id="btn_show_model" class="btn btn-success">Show Models</button>
                                    </td>
                                </tr>

                                <tr style="height: 40px"></tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="panel panel-primary">
                                            <div class="sec-header">Model Ensemble</div>
                                            <div class="panel-body">
                                                <ul style="color: black;padding-left: 20px">
                                                    <li>Because there are a number of operational ocean models providing predictions of
                                                        the marine environment for the northwest Atlantic Ocean, a multi-model ensemble is used routinely to
                                                        generate a representative ocean state estimation and to facilitate inter-model comparison. This Ensemble page shows
                                                        the CNAPS model (top left), the U.S. Navy's HYCOM model, the National Centers for Environmental Prediction (NCEP)'s HYCOM model, and an
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
                                                <ul style="color: black;padding-left: 20px">
                                                    <li><strong>Date:</strong> Click on the date from the list to be shown on the maps.
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

