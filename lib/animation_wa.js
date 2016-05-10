var timer_is_on = 0;
var c = 0;	//counter for animation
var t;
var overlaysArray = [];
var isFirstTime = true;
var start_date;
var end_date;
var availableDates=[];

function foo()
{
    if (overlaywa != null)
        overlaywa.setMap(null);
    overlaysArray = [];

    var start = availableDates.indexOf(parseInt(start_date));
    var end = availableDates.indexOf(parseInt(end_date));

    alert("inside foo")
    console.log("inside foo " +start + " " + end)

    for (i = start; i <= end; i++) {
        for (j = 0; j <= 21; j += 3) {
            d1 = availableDates[i];
            setDate(d1, j);
            overlaywa = new google.maps.KmlLayer(circulation_figure_location + d1.substring(0, 6) + "/" + d1 + "/" + date + "_" + variable + ".kmz", imageBounds);
            console.log(""+circulation_figure_location + d1.substring(0, 6) + "/" + d1 + "/" + date + "_" + variable + ".kmz")
            overlaysArray.push(overlaywa);
        }
    }
    doTimer();
}

function animation()
{
    //if (isFirstTime != true && c != 0)
    //    overlaysArray[c - 1].setMap(null);
    //else if (c == 0)
    //    overlaysArray[overlaysArray.length - 1].setMap(null);
    isFirstTime = false;
    overlaysArray[c].setMap(map);
    t = setTimeout("animation()", 1000);
    c = (c + 1) % overlaysArray.length;

}

function clearOverlays() {
    if (overlaysArray) {
        for (i in overlaysArray) {
            overlaysArray[i].setMap(null);
        }
    }
}

function showOverlays() {
    if (overlaysArray) {
        for (i in overlaysArray) {
            overlaysArray[i].setMap(map);
        }
    }
}

function doTimer()
{
    if (!timer_is_on)
    {
        timer_is_on = 1;
        animation();
    }
}

function stopCount()
{
    clearTimeout(t);
    timer_is_on = 0;
    isFirstTime = true;
    clearOverlays();

}

