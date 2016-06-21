function showVertical() {
    if (overlays == null)
    {
        alert("Please select one location");
        return;
    } else if (date == null) {
        alert("Please select dates");
    } else if (time == null) {
        alert("Please select time");
    } else
    {
        var lon = overlays.lng();
        var lat = overlays.lat();
        parameters = "lon=" + lon + "&lat=" + lat + "&date=" + date + "&time=" + time;

        newwindow = window.open("new_window_vertical.jsp?" + parameters, 'vertical', 'height=600,width=600');
        if (window.focus) {
            newwindow.focus()
        }
    }
}