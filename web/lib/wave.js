var overlaywa;


function getFullPath() {
//    var path = "http://omgsrv1.meas.ncsu.edu:8080/Plots/useast/" + date.substring(0, 6) + "/" + date + "/" +
//            date + "_" + time + "_" + variable;
//
//    if (depth != "") {
//        path = path + "_" + depth;
//    }
//    path = path + ".kmz";
//    console.log(path);
//    
    var path = circulation_figure_location;

    $.ajax({
        url: "ValidImageServlet?" + "date=" + date + "&variable=" + variable + "&time=" + time + "&depth=" + depth,
        async: false,
        success: function (data, textStatus, jqXHR) {
            path = path + data;
            //alert(path)
        }
    });

    //alert(path);
    return path;
}

function downloadFigure() {
    var url = getFullPath();

    if (overlaywa != null)
        overlaywa.setMap(null);
    overlaywa = null;

    overlaywa = new google.maps.KmlLayer({
        url: url,
        map: map});
    google.maps.event.addListener(overlaywa, "status_changed", function () {
        if (overlaywa.getStatus() != google.maps.KmlLayerStatus.OK) {
            alert("KMZ Data is unavailable");
        }
    });
    overlaywa.setMap(map);
}


function downloadkmz() {
    //var url = "KMZFetchServlet?date=" + date + "&variable=" + variable + "&time=" + time;
    window.location = getFullPath();
}

function getAnimationFullPath(subPath) {
    var path = "http://omgsrv1.meas.ncsu.edu:8080/Plots/useast/" + subPath.substring(0, 6) + "/" + subPath.substring(0, 8) + "/" + subPath;
    console.log(path);
    return path;
}

