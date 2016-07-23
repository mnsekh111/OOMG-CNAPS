var overlaywa;


function getFullPath(){
    var path =  "http://omgsrv1.meas.ncsu.edu:8080/Plots/useast/"+date.substring(0,6)+"/"+date+"/"+
            date+"_"+time+"_"+variable;
    if(depth != ""){
        path = path + "_"+depth;
    }
    path = path+ ".kmz";
    console.log(path);
    return path;
}

function downloadFigure() {
    var url = getFullPath();
    
    if (overlaywa != null)
        overlaywa.setMap(null);
    overlaywa = null;
    
    overlaywa = new google.maps.KmlLayer({
            url:url,
            map: map});
    overlaywa.setMap(map);
}


function downloadkmz() {
    //var url = "KMZFetchServlet?date=" + date + "&variable=" + variable + "&time=" + time;
    window.location = getFullPath();
}

function getAnimationFullPath(subPath){
    var path =  "http://omgsrv1.meas.ncsu.edu:8080/Plots/useast/"+subPath.substring(0,6)+"/"+subPath.substring(0,8)+"/"+subPath;
    console.log(path);
    return path;
}

