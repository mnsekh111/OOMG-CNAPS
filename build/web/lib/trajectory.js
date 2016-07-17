var markersArray = [];
var lonlatArray = [];
var colorIndex = 0;
var isProcessing = false;

function addMarker(location) {
    marker = new google.maps.Marker({
        position: location,
        icon: "image/" + colors[colorIndex][0] + ".png",
        map: map
    });
    markersArray.push(marker);
    lonlatArray.push({
        location: location,
        col: colors[colorIndex][1]
    });
    colorIndex = (colorIndex + 1) % colors.length;
    //plotDrifter(location);
}

function showTrajectory() {

    if (!isProcessing) {
        isProcessing = true;
        if (lonlatArray.length == 0) {
            alert("Please select at least 1 location");
            return;
        }

        var parameters = "n=" + lonlatArray.length;
        for (var i = 0; i < lonlatArray.length; i++) {
            parameters += "&";
            parameters += "lon" + i + "=" + lonlatArray[i].location.lng();
            parameters += "&";
            parameters += "lat" + i + "=" + lonlatArray[i].location.lat();
        }
        $.get("servlet/Trajectory?" + parameters,
                function (data)
                {
                    console.log("From the servlet" + data);
                   isProcessing = false;
                    plotDrifter(data);
                }
        );

        /*	$('#map_canvas').after(
         "<img class=\"loading\" src=\"./image/loading.gif\" /> "
         );*/

        var d = new Date();
        var $dialog = $([
            "<div id='loading' class='alert alert-info' >",
             "<img class=\"loading\" src=\"./image/loading.gif\" /> "+
            "   72 hours trajectory prediction <br/> starting from 0:00"+ (d.getMonth() + 1).toString() + "/"
               + d.getDate().toString() + "/" + (d.getYear() + 1900).toString(),
            "</div>"
        ].join("\n"));
        
        $('#map_canvas').after(dialogbox);

        //Solve the compatibility issue of IE 7.0
        if ($.browser.version != "7.0")
            $('#map_canvas').fadeTo('slow', 0.8);

    }else{
        alert("The app is processing the previous request. Please wait");
    }

}

function plotDrifter(data) {

    $('#loading').remove();

    if ($.browser.version != "7.0")
        $('#map_canvas').fadeTo('slow', 1);


    //path.push(location);

    var locations = data.split("\n");
    for (i = 0; i < locations.length - 1; i++) {

        //For the drifter
        var polyOptions = {
            strokeColor: lonlatArray[i].col,
            strokeOpacity: 1.0,
            strokeWeight: 3
        }

        poly = new google.maps.Polyline(polyOptions);
        poly.setMap(map);

        var path = poly.getPath();


        var lonlats = locations[i].split(";");
        for (j = 0; j < lonlats.length - 1; j++)
        {
            var lonlat = lonlats[j].split(",");
            path.push(new google.maps.LatLng(lonlat[1], lonlat[0]));		//first lat, second lon
        }
    }
}


function addDrifter() {
    var lon = $('#txt_lon').val();
    var lat = $('#txt_lat').val();
    if (lat == null || lat.trim().length == 0 || lon == null || lon.trim().length == 0) {
        alert("Input is invalid");
        return;
    } else {
        google.maps.event.trigger(map, 'click', {latLng: new google.maps.LatLng(lat, lon)});
        //To prevent addition of duplicate points by accident
        $('#txt_lon').val("");
        $('#txt_lat').val("");
    }
}
