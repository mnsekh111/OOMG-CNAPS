<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@page import="method.TimePeriod"%>
<%@page import="util.Global"%>
<%@ page import="java.util.Arrays" %>



<!DOCTYPE html>
<html lang="en-US" style="width:655px; height:475px;">
    <head>
        <title>CNAPS Coupled Northwest Atlantic Prediction System</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript">

            var buoy_date = "<%=request.getParameter("date")%>";
            var buoy = "<%=request.getParameter("buoy")%>";
            var root = "<%=Global.val_figures_location%>";
            var day = "<%=request.getParameter("day")%>";

            $(document).ready(function () {
                initialize();
            });


          function initialize() {
                $("#info").hide();
                $.ajax({
                    url: "servlet/BuoyServlet?" + "day=" + day + "&" + "date=" + buoy_date + "&" + "buoy=" + buoy,
                    success: function (data, textStatus, jqXHR) {
                        $("#buoyimage").prop("src", 'data:image/png;base64,' + data);
                        //alert(jqXHR.getAllResponseHeaders())
                        if (jqXHR.getResponseHeader("meta-correct") == "false") {
                            var info = jqXHR.getResponseHeader("meta-info");
                            $("#info").width($("#buoyimage").width());
                            $("#info").text("Showing information for " + info)
                        } else {
                            $("#info").css("background-color", "#3c763d");
                            $("#info").width($("#buoyimage").width());
                            $("#info").text("Showing information for " + "Date : "+buoy_date);

                        }
                        $("#info").show();

                    }
                });
//                        document.getElementById("buoyimage").src = "servlet/ValServlet1?" +
//                        "day=" + hfdate.substring(0, 8) +
//                        "&hfdate=" + hfdate + "&time=" + time + "&areanum=" + areanum;
            }

        </script> 
    </head>

    <body>

        <img id="buoyimage" src="image/loading.gif" alt="Sorry, the image is not available yet"/>

        <p style="background-color: #ac2925;padding: 10px; color: white" id="info">

        </p>
    </body>
</html>
