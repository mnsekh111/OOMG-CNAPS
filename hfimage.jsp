<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
<%@ page import="java.util.Arrays" %>


<html lang="en-US" style="width:800; height:475px;">
    <head>
        <title>CNAPS Coupled Northwest Atlantic Prediction System</title>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <link type="text/css" href="layout.css" rel="stylesheet">
        <script type="text/javascript"
                src="http://maps.google.com/maps/api/js?sensor=false">
        </script>

        <link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />   
        <link rel="stylesheet" href="/css/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css" />
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
        <script type="text/javascript" src="./lib/animation.js"></script>
        <script type="text/javascript" src="./lib/val.js"></script>
        <script type="text/javascript" src="./lib/global.js"></script>
        <script type="text/javascript">

                var root = "<%=Global.val_figures_location%>";

                var s = "<%=request.getParameter("hfdate")%>";
                var areanum = "<%=request.getParameter("areanum")%>";
                var day = "<%=request.getParameter("day")%>";
                var hfdate;


                $(document).ready(function () {
                    initialize();
                });

                function initialize() {
                    $(function () {

                        $("#animationbutton").buttonset();
                        //if ($.browser.msie==null)
                        $("#time-list").buttonset();

                        //else{
                        //	var version=$.browser.version;
                        //	if (version!="8.0" && version!="9.0")
                        //		alert("Detected your web browser is: IE "+version+".\nKnown compatibility issue is existed with this browser, please use another browser to gain better experience.");
                        //}
                    });

                    //ValServlet1 is the plot for hf radar
                    $('#time-list >  input').bind("click",
                            function () {
                                hfdate = this.id;
                                $.get("servlet/ValServlet1?" +
                                        "day=" + hfdate.substring(0, 8) + "&" +
                                        "hfdate=" + hfdate + "&areanum=" + areanum, function (data) {
                                            if (data == "fail") {
                                                alert("Sorry, this data is not available yet.");
                                                return;
                                            } else {
                                                document.getElementById("hfimage").src = "servlet/ValServlet1?" + "day=" + hfdate.substring(0, 8) + "&hfdate=" + hfdate + "&areanum=" + areanum;
                                                //document.getElementById("hfimage").src="http://omgsrv1.meas.ncsu.edu:8080/ocean-circulation/servlet/ValServlet1?day=20121110&hfdate=20121110_0000";
                                                setTimeout("reload", 5000);
                                            }
                                        });

                                //plotvalidation1();
                            });

                    $(function () {
                        $("#datepicker").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            onSelect: function (dateText, inst) {
                                loadMoreDates(dateText);
                            }
                        });
                    });

                    //InitLatlng(map);

                    //To display the default figure (current day, 0 meter, uv) on the map
                    /*var d=new Date();
                     var month=d.getMonth()+1;
                     var day_0=d.getDate();
                     if (month<10)
                     month="0"+month.toString();
                     else
                     month=month.toString();
                     if (day_0 <10)
                     day_0="0"+day_0.toString();
                     else
                     day_0=day_0.toString();
                     var s=(d.getYear()+1900).toString()+month+day_0+"_0000";*/

                    // $('#'+s).click();

                    $(function () {
                        document.getElementById("hfimage").src = "servlet/ValServlet1?" + "day=" + s.substring(0, 8) + "&hfdate=" + s + "&areanum=" + areanum;
                    });

                }

        </script> 
    </head>

    <body style="width=765px;height=475px">

        <img id="hfimage" src="" alt="Sorry, the image is not available yet" height="329" width="642">

        <!-- <div id="date" style="top:330px; height:140px; left:0px; width:650px;">
        

</div> -->

    </body>
</html>
