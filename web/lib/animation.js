var kmzNames = [];
var overlayArray = [];
var intervalId = null;
var currIndex = 0;

function animate(overlay) {
    if (overlaywa != null)
        overlaywa.setMap(null);
    overlaywa = null;

    overlaywa = overlay;
    overlaywa.setMap(map);
}

function startAnimation() {
    $.get("AnimationServlet?startDate=" + start_date + "&endDate=" + end_date + "&variable=" + variable + "&depth=" + depth, function (data, status) {
        alert("Data: " + data + "\nStatus: " + status);
        if (data.length > 0) {
            kmzNames = data.split("\n");
            if (kmzNames == null || kmzNames.length == 0) {
                alert("No data available for the specified parameters");
                return;
            }

            for (i=0;i<kmzNames.length - 1;i++) {
                var overlay = new google.maps.KmlLayer({
                    url: getAnimationFullPath(kmzNames[i]),
                    map: map});
                overlayArray.push(overlay);
            }

            intervalId = setInterval(function () {
                animate(overlayArray[currIndex]);
                currIndex = (currIndex + 1)%overlayArray.length;
            }, 1000);
        } else {
            alert("No data available for the specified parameters");
        }
    });
}


function stopAnimation() {
    if (intervalId != null) {
        clearInterval(intervalId);
    }

    overlayArray = [];
    currIndex = 0;
    intervalId = null;

    downloadFigure();
}

