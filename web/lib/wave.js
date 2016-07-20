var overlaywa;

function downloadkmz() {
    alert(full_path + ".kmz");
    var img = document.createElement("img");
    img.setAttribute("src", full_path + ".png");
    $("map_canvas").append(img);

}

function downloadFigure() {
    var url = "ImageFetchServlet?date=" + date + "&variable=" + variable + "&time=" + time;
    console.log("url" + url);
    $("#map_canvas_temp").attr("src",url);

}

function plotwa() {

    //Clear the previous overlay
    if (overlaywa != null)
        overlaywa.setMap(null);

    d1 = date.substring(0, 8);

    overlaywa = null;


    alert("Plotwa is called");
    $.get(full_path + ".kmz", function (data) {
        if (data == "fail") {
            alert("Sorry, this data is not available yet.");
            return;
        }
    });

    //overlaywa=new google.maps.GroundOverlay(figure_location+d1.substring(0,6)+"/"+d1+"/"+date+"_"+variable+".png",imageBounds);

    overlaywa = new google.maps.KmlLayer(full_path + ".kmz", imageBounds);

    alert(d1.substring(0, 6) + "/" + d1 + "/" + date + "_" + variable + ".kmz", imageBounds);

    overlaywa.setMap(map);
}


function showDatepicker() {
    $("#archive_1").css('visibility', 'visible');
}
