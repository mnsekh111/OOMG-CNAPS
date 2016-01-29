var timer_is_on = 0;
var c = 0;	//counter for animation
var t;
var overlaysArray = [];
var isFirstTime = true;

function foo()
{
     overlaysArray = [];

    if (overlaywa != null)
        overlaywa.setMap(null);

    var length = availableDates.length;
    for (i = length - 4; i < length; i++) {
        for (j = 0; j <= 21; j += 3) {
            d1 = availableDates[i];
            setDate(d1, j);
            //overlaywa=new google.maps.GroundOverlay(figure_location+d1.substring(0,6)+"/"+d1+"/"+date+"_"+variable+".png"
            //		,imageBounds);
            overlaywa = new google.maps.KmlLayer(circulation_figure_location + d1.substring(0, 6) + "/" + d1 + "/" + date + "_" + variable + ".kmz", imageBounds);
            overlaysArray.push(overlaywa);
        }
    }
    doTimer();
}

function animation()
{
    if (isFirstTime != true && c != 0)
        overlaysArray[c - 1].setMap(null);
    else if (c == 0)
        overlaysArray[overlaysArray.length - 1].setMap(null);
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

