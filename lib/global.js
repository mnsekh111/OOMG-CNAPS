var image_base_url = "omglnx6.meas.ncsu.edu/sabgom_nfcast";
var figure_location = "/Plot/Plot_zyao/"
var circulation_figure_location = "http://omgsrv1.meas.ncsu.edu:8080/Plot/Plot_zyao/";



function mapInit() {
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
}

function download() {
    var addr = circulation_figure_location + date.substring(0, 6) + "/" + date.substring(0, 8) + "/" + date + "_" + variable + ".kmz";
    return addr;
}
function getTodayStr()
{
    var d = new Date();
    var month = d.getMonth() + 1;
    d.setDate(d.getDate() - 1);
    var day_0 = d.getDate();
    if (month < 10)
        month = "0" + month.toString();
    else
        month = month.toString();
    if (day_0 < 10)
        day_0 = "0" + day_0.toString();
    else
        day_0 = day_0.toString();
    buoy_date = (d.getYear() + 1900).toString() + month + day_0 + "_0000";
}
//Initialize the map
var latlng = new google.maps.LatLng(25, -90);
var myOptions = {
    zoom: 10,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
};


//For figure display on the z-level
var imageBounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(8.2, -112.9514),
        new google.maps.LatLng(49.6, -45.8400)
        );

var availableDates = [];
var availableDates1 = [];

//rectangle area for transection and trajectory
var limitCoords = [
    new google.maps.LatLng(46.9679, -98.9514),
    new google.maps.LatLng(8.0466, -98.9514),
    new google.maps.LatLng(8.0466, -59.94),
    new google.maps.LatLng(46.9679, -59.94)];

var hfrectangle = [new google.maps.Rectangle(), new google.maps.Rectangle(), new google.maps.Rectangle(), new google.maps.Rectangle(), new google.maps.Rectangle(), new google.maps.Rectangle()];
var hfrecbound = [
    new google.maps.LatLngBounds(new google.maps.LatLng(34.5, -77), new google.maps.LatLng(42, -70)),
    new google.maps.LatLngBounds(new google.maps.LatLng(31.7, -79.3), new google.maps.LatLng(34, -76.5)),
    new google.maps.LatLngBounds(new google.maps.LatLng(32.2, -81.5), new google.maps.LatLng(30, -78.9)),
    new google.maps.LatLngBounds(new google.maps.LatLng(26.8, -80.6), new google.maps.LatLng(25, -78.6)),
    new google.maps.LatLngBounds(new google.maps.LatLng(27.85, -84.1), new google.maps.LatLng(25.25, -82)),
    new google.maps.LatLngBounds(new google.maps.LatLng(42.75, -69.2), new google.maps.LatLng(45.3, -65.3)),
];
var overlayvalidation1;

var buoystation = [
    new google.maps.LatLng(31.8620, -74.8350),
    new google.maps.LatLng(31.4020, -80.8690),
    new google.maps.LatLng(30.0420, -80.5340),
    new google.maps.LatLng(33.4360, -77.7430),
    new google.maps.LatLng(23.8380, -68.3330),
    new google.maps.LatLng(27.4690, -71.4910),
    new google.maps.LatLng(31.9500, -69.4970),
    new google.maps.LatLng(25.8880, -89.6580),
    new google.maps.LatLng(26.0440, -85.6120),
    new google.maps.LatLng(30.0650, -87.5550),
    new google.maps.LatLng(26.9680, -96.6940),
    new google.maps.LatLng(28.5000, -84.8570),
    new google.maps.LatLng(19.8020, -84.8570),
    new google.maps.LatLng(14.9230, -74.9180),
    new google.maps.LatLng(36.6110, -74.8420),
    new google.maps.LatLng(22.2030, -94.0000),
    new google.maps.LatLng(43.4840, -67.8830),
    new google.maps.LatLng(36.2000, -75.7140),
    new google.maps.LatLng(40.3690, -73.7030),
    new google.maps.LatLng(28.8850, -90.0240)];

var buoymarker = [new google.maps.Marker({position: buoystation[0], title: 'NDBC Station 41002 (LLNR 830) - South Hatteras - 225 NM South of Cape Hatteras'}),
    new google.maps.Marker({position: buoystation[1], title: 'NDBC Station 41008 - Grays Reef - 40 NM southeast of Savannah, GA'}),
    new google.maps.Marker({position: buoystation[2], title: 'NDBC Station 41012 (LLNR 845.3) - St. Augustine - 40 NM ENE of St Augustine, FL'}),
    new google.maps.Marker({position: buoystation[3], title: 'NDBC Station 41013 (LLNR 815) - Frying Pan Shoals, NC'}),
    new google.maps.Marker({position: buoystation[4], title: 'NDBC Station 41046 - East Bahamas - 335 NM East of San Salvador Is, Bahamas'}),
    new google.maps.Marker({position: buoystation[5], title: 'NDBC Station 41047 - NE Bahamas - 350 NM ENE of Nassau, Bahamas'}),
    new google.maps.Marker({position: buoystation[6], title: 'NDBC Station 41048 - West Bermuda -240 NM West of Bermuda'}),
    new google.maps.Marker({position: buoystation[7], title: 'NDBC Station 42001 (LLNR 1400) - Mid Gulf - 180 NM South of Southwest Pass, LA'}),
    new google.maps.Marker({position: buoystation[8], title: 'NDBC Station 42003 (LLNR 1395) - East Gulf - 208 NM West of Naples, FL'}),
    new google.maps.Marker({position: buoystation[9], title: 'NDBC Station 42012 - Orange Beach - 44 NM SE of Mobile, AL'}),
    new google.maps.Marker({position: buoystation[10], title: 'NDBC Station 42020 (LLNR 1330) - Corpus Christi - 60NM SSE of Corpus Christi, TX'}),
    new google.maps.Marker({position: buoystation[11], title: 'NDBC Station 42036 (LLNR 855) - West Tampa - 112 NM WNW of Tampa, FL'}),
    new google.maps.Marker({position: buoystation[12], title: 'NDBC Station 42056 (LLNR 110) - Yucatan Basin - 120 NM ESE of Cozumel, MX'}),
    new google.maps.Marker({position: buoystation[13], title: 'NDBC Station 42058 - Central Caribbean - 210 NM SSE of Kingston, Jamaica'}),
    new google.maps.Marker({position: buoystation[14], title: 'NDBC Station 44014 (LLNR 550) - Virginia Beach - 64 NM East of Virginia Beach, VA'}),
    new google.maps.Marker({position: buoystation[15], title: 'NDBC Station 42055 (LLNR 1101) - Bay of Campeche - 214 NM NE of Veracruz, MX'}),
    new google.maps.Marker({position: buoystation[16], title: 'NDBC Station 44037 - Buoy M01 - Jordan Basin, Gulf of Maine'}),
    new google.maps.Marker({position: buoystation[17], title: 'NDBC Station 44056 - Duck FRF, NC'}),
    new google.maps.Marker({position: buoystation[18], title: 'NDBC Station 44065 (LLNR 725) - New York Harbor Entrance - 15 NM SE of Breezy Point , NY'}),
    new google.maps.Marker({position: buoystation[19], title: 'Station LOPL1 - Louisiana Offshore Oil Port, LA'})];

var buoyid = ["41002", "41008", "41012", "41013", "41046", "41047", "41048", "42001",
    "42003", "42012", "42020", "42036", "42056", "42058", "44014", "42055",
    "44037", "44056", "44065", "LOPL1"];


var circulationstation = [
    new google.maps.LatLng(44.9136, -67.0039),
    new google.maps.LatLng(44.90333, -66.98167),
    new google.maps.LatLng(44.39167, -68.20500),
    new google.maps.LatLng(43.65667, -70.24667),
    new google.maps.LatLng(42.35333, -71.05333),
    new google.maps.LatLng(41.28500, -70.09667),
    new google.maps.LatLng(41.52333, -70.67167),
    new google.maps.LatLng(41.50500, -71.32667),
    new google.maps.LatLng(41.36000, -72.09000),
    new google.maps.LatLng(41.28333, -72.90833),
    new google.maps.LatLng(40.81000, -73.76333),
    new google.maps.LatLng(41.04833, -71.96000),
    new google.maps.LatLng(40.46667, -74.00833),
    new google.maps.LatLng(39.35500, -74.41833),
    new google.maps.LatLng(38.78167, -75.12000),
    new google.maps.LatLng(38.32833, -75.09167),
    new google.maps.LatLng(37.16500, -75.98833),
    new google.maps.LatLng(38.98333, -76.48000),
    new google.maps.LatLng(37.61500, -76.29000),
    new google.maps.LatLng(36.18333, -75.74667),
    new google.maps.LatLng(34.72000, -76.67000),
    new google.maps.LatLng(34.21333, -77.78667),
    new google.maps.LatLng(33.65500, -78.91833),
    new google.maps.LatLng(32.78167, -79.92500),
    new google.maps.LatLng(32.03333, -80.90167),
    new google.maps.LatLng(30.39667, -81.43000),
    new google.maps.LatLng(28.41500, -80.59167),
    new google.maps.LatLng(26.61167, -80.03333),
    new google.maps.LatLng(25.73000, -80.16167),
    new google.maps.LatLng(24.55500, -81.80667),
    new google.maps.LatLng(24.71167, -81.10500),
    new google.maps.LatLng(26.13167, -81.80667),
    new google.maps.LatLng(27.63833, -82.56167),
    new google.maps.LatLng(27.97833, -82.83167),
    new google.maps.LatLng(29.13500, -83.03167),
    new google.maps.LatLng(29.72667, -84.98167),
    new google.maps.LatLng(30.15167, -85.66667),
    new google.maps.LatLng(30.25000, -88.07500),
    new google.maps.LatLng(28.93167, -89.40667),
    new google.maps.LatLng(29.44833, -91.33667),
    new google.maps.LatLng(29.72833, -93.87000),
    new google.maps.LatLng(29.35667, -94.72333),
    new google.maps.LatLng(28.94333, -95.30167),
    new google.maps.LatLng(27.58000, -97.21667),
    new google.maps.LatLng(32.37333, -64.70333), ];

var circulationmarker = [new google.maps.Marker({position: circulationstation[1], title: 'Eastport, ME'}),
    new google.maps.Marker({position: circulationstation[2], title: 'Bar Harbor, ME'}),
    new google.maps.Marker({position: circulationstation[3], title: 'Portland, ME'}),
    new google.maps.Marker({position: circulationstation[4], title: 'Boston, MA'}),
    new google.maps.Marker({position: circulationstation[5], title: 'Nantucket Island, MA'}),
    new google.maps.Marker({position: circulationstation[6], title: 'Woods Hole, MA'}),
    new google.maps.Marker({position: circulationstation[7], title: 'Newport, RI'}),
    new google.maps.Marker({position: circulationstation[8], title: 'New London, CT'}),
    new google.maps.Marker({position: circulationstation[9], title: 'New Haven, CT'}),
    new google.maps.Marker({position: circulationstation[10], title: 'Kings Point, NY'}),
    new google.maps.Marker({position: circulationstation[11], title: 'Montauk, NY'}),
    new google.maps.Marker({position: circulationstation[12], title: 'Sandy Hook, NJ'}),
    new google.maps.Marker({position: circulationstation[13], title: 'Atlantic City, NJ'}),
    new google.maps.Marker({position: circulationstation[14], title: 'Lewes,DE'}),
    new google.maps.Marker({position: circulationstation[15], title: 'Ocean City, MD'}),
    new google.maps.Marker({position: circulationstation[16], title: 'Kiptopeke, VA'}),
    new google.maps.Marker({position: circulationstation[17], title: 'Annapolis, MD'}),
    new google.maps.Marker({position: circulationstation[18], title: 'Windmill Point, VA'}),
    new google.maps.Marker({position: circulationstation[19], title: 'Duck, NC'}),
    new google.maps.Marker({position: circulationstation[20], title: 'Beaufort, NC'}),
    new google.maps.Marker({position: circulationstation[21], title: 'Wrightsville Beach, NC'}),
    new google.maps.Marker({position: circulationstation[22], title: 'Springmaid Pier, NC'}),
    new google.maps.Marker({position: circulationstation[23], title: 'Charleston, SC'}),
    new google.maps.Marker({position: circulationstation[24], title: 'Fort Pulaski, GA'}),
    new google.maps.Marker({position: circulationstation[25], title: 'Mayport, FL'}),
    new google.maps.Marker({position: circulationstation[26], title: 'Trident Pier, FL'}),
    new google.maps.Marker({position: circulationstation[27], title: 'Lake Worth Pier, FL'}),
    new google.maps.Marker({position: circulationstation[28], title: 'Virginia Key, FL'}),
    new google.maps.Marker({position: circulationstation[29], title: 'Key West, FL'}),
    new google.maps.Marker({position: circulationstation[30], title: 'Vaca Key, FL'}),
    new google.maps.Marker({position: circulationstation[31], title: 'Naples, FL'}),
    new google.maps.Marker({position: circulationstation[32], title: 'Port Manatee, FL'}),
    new google.maps.Marker({position: circulationstation[33], title: 'Clearwater Beach, FL'}),
    new google.maps.Marker({position: circulationstation[34], title: 'Cedar Key, FL'}),
    new google.maps.Marker({position: circulationstation[35], title: 'Apalachicola, FL'}),
    new google.maps.Marker({position: circulationstation[36], title: 'Panama City, FL'}),
    new google.maps.Marker({position: circulationstation[37], title: 'Dauphin Island, AL'}),
    new google.maps.Marker({position: circulationstation[38], title: 'Pilots Station East, LA'}),
    new google.maps.Marker({position: circulationstation[39], title: 'Lawma, LA'}),
    new google.maps.Marker({position: circulationstation[40], title: 'Sabine Pass, TX'}),
    new google.maps.Marker({position: circulationstation[41], title: 'Galveston, TX'}),
    new google.maps.Marker({position: circulationstation[42], title: 'USCG Freeport, TX'}),
    new google.maps.Marker({position: circulationstation[43], title: 'Corpus Christi, TX'}),
    new google.maps.Marker({position: circulationstation[44], title: 'Bermuda'})
];

var circulationid = ["8410140", "8413320", "8418150", "8443970", "8449130", "8447930", "8452660", "8461490", "8465705",
    "8516945", "8510560", "8531680", "8534720", "8557380", "8570283", "8632200", "8575512", "8636580",
    "8651370", "8656483", "8658163", "8661070", "8665530", "8670870", "8720218", "8721604", "8722670",
    "8723214", "8724580", "8723970", "8725110", "8726384", "8726724", "8727520", "8728690", "8729108",
    "8735180", "8760922", "8764227", "8770570", "8771341", "8772447", "8775870", "2695540"];


var limitArea = new google.maps.Polyline({
    strokeColor: "#FF0000",
    strokeWeight: 1
});

var limitArea_polygon = new google.maps.Polygon({
    paths: limitCoords
});


var colors = [
    ["red", "#FF0000"], ["green", "#00FF00"],
    ["blue", "#0000FF"], ["yellow", "#FFFF00"],
    ["purple", "#FF00FF"], ["grey", "#C0C0C0"],
    ["white", "#FFFFFF"], ["black", "#000000"]
];



var fileTypes = [['', '_0000.png'],
    ['', '_0300.png'],
    ['', '_0600.png'],
    ['', '_0900.png'],
    ['', '_1200.png'],
    ['', '_1500.png'],
    ['', '_1800.png'],
    ['', '_2100.png'],
    ['Currents_', '.kmz'],
    ['salt_', '.kml'],
    ['sss_', '.png'],
    ['sst_', '.kml'],
    ['sst_', '.png'],
    ['', '_w.png'],
    ['', '_slp.png'],
    ['', '_at.png'],
    ['', '_swd.png'],
    ['track_sabgom_ltrans_floats_NF_', '.png'],
    ['', '_hfuv.png']

]

var year;
var month;
var day;
var files;

function InitLatlng(map) {

    limitArea.setMap(map);
    var path = limitArea.getPath();
    path.push(limitCoords[0]);
    path.push(limitCoords[1]);
    path.push(limitCoords[2]);
    path.push(limitCoords[3]);
    path.push(limitCoords[0]);

    // Create new control to display latlng and coordinates under mouse.
    var latLngControl = new LatLngControl(map);

    // Register event listeners
    google.maps.event.addListener(map, 'mouseover', function (mEvent) {
        latLngControl.set('visible', true);
    });
    google.maps.event.addListener(map, 'mouseout', function (mEvent) {
        latLngControl.set('visible', false);
    });
    google.maps.event.addListener(map, 'mousemove', function (mEvent) {
        latLngControl.updatePosition(mEvent.latLng);
    });

}
function add_hfradar_listener() {

    function linkevent(rect) {
        var hfrectOptions = {strokeColor: "#FF0000", strokeOpacity: 0.8, strokeWeight: 2,
            fillColor: "#FF0000", fillOpacity: 0.35, map: map, bounds: hfrecbound[rect]
        };
        hfrectangle[rect].setOptions(hfrectOptions);
        google.maps.event.addListener(hfrectangle[rect], 'click', function (e) {
            //infowindow.setPosition(e.latLng);
            //infowindow.open(map,marker);
            window.open("hfimage.jsp?day=" + s.substring(0, 8) + "&hfdate=" + s + "&areanum=" + (rect + 1), "hfradar", "top=" + e.screenY + ",left=" + e.screenX + ", height=470, width=665");
        });
    }

    for (var i = 0; i < hfrectangle.length; i++)
    {
        linkevent(i);
    }
}
function Init_hfradar_map() {

    /*var infowindow=new google.maps.InfoWindow({
     content:"hello world"
     });*/
    overlayvalidation1 = new google.maps.GroundOverlay("servlet/ValServlet3?" + "day=" + s.substring(0, 8) + "&" + "date=" + s, imageBounds);
    overlayvalidation1.setMap(map);
    add_hfradar_listener();
}

function Change_hfradar_map() {

    overlayvalidation1.setMap(null);

    overlayvalidation1 = new google.maps.GroundOverlay(
            "servlet/ValServlet3?" +
            "day=" + hfdate.substring(0, 8) + "&" +
            "date=" + hfdate, imageBounds);

    overlayvalidation1.setMap(map);

}
function Hide_hfradar() {
    overlayvalidation1.setMap(null);
    for (var i = 0; i < hfrectangle.length; i++)
        hfrectangle[i].setMap(null);
}

function Init_buoy_map() {

    function linkevent(m) {
        circulationmarker[m].setMap(map);
        google.maps.event.addListener(circulationmarker[m], 'click', function (e) {
            window.open("buoyimage.jsp?day=" + s.substring(0, 8) + "&" + "date=" + s + "&" + "buoy=" + circulationid[m],
                    "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=470, width=665');
        });
    }
    //ValServlet2 used to show the default bouy station image(how many station, where it is).
    //overlayvalidation=new google.maps.GroundOverlay(
    //		"servlet/ValServlet22",imageBounds);

    //overlayvalidation.setMap(map);

    for (var i = 0; i < circulationmarker.length; i++)
        linkevent(i);

}
function Hide_buoymap() {

    function hidemarker(m) {
        circulationmarker[m].setMap(null);
    }

    //overlayvalidation.setMap(null);
    for (var i = 0; i < circulationmarker.length; i++)
        hidemarker(i);

}

function Change_buoy_map() {

    overlayvalidation.setMap(null);

    overlayvalidation = new google.maps.GroundOverlay(
            "servlet/BuoyServlet?" +
            "day=" + buoy_date.substring(0, 8) + "&" +
            "date=" + buoy_date + "&" + "buoy=" + buoy, imageBounds);

    overlayvalidation.setMap(map);

}

function Init_waveval_map() {

    function linkevent(m) {
        buoymarker[m].setMap(map);
        google.maps.event.addListener(buoymarker[m], 'click', function (e) {
            window.open("wavevalimage.jsp?day=" + buoy_date.substring(0, 8) + "&" + "date=" + buoy_date + "&" + "buoy=" + buoyid[m],
                    "Model Validation", 'top=' + e.screenY + ',left=' + e.screenX + ', height=470, width=665');
        });
    }
    //ValServlet2 used to show the default bouy site image.
    overlayvalidation = new google.maps.GroundOverlay(
            "servlet/ValServlet2", imageBounds);

    overlayvalidation.setMap(map);

    for (var i = 0; i < 20; i++)
    {
        linkevent(i);
    }
}

function LatLngControl(map) {
    /**
     * Offset the control container from the mouse by this amount.
     */
    this.ANCHOR_OFFSET_ = new google.maps.Point(8, 8);

    /**
     * Pointer to the HTML container.
     */
    this.node_ = this.createHtmlNode_();

    // Add control to the map. Position is irrelevant.
    map.controls[google.maps.ControlPosition.TOP].push(this.node_);

    // Bind this OverlayView to the map so we can access MapCanvasProjection
    // to convert LatLng to Point coordinates.
    this.setMap(map);

    // Register an MVC property to indicate whether this custom control
    // is visible or hidden. Initially hide control until mouse is over map.
    this.set('visible', false);
}

// Extend OverlayView so we can access MapCanvasProjection.
LatLngControl.prototype = new google.maps.OverlayView();
LatLngControl.prototype.draw = function () {};

/**
 * @private
 * Helper function creates the HTML node which is the control container.
 * @return {HTMLDivElement}
 */
LatLngControl.prototype.createHtmlNode_ = function () {
    var divNode = document.createElement('div');
    divNode.id = 'latlng-control';
    divNode.index = 100;
    return divNode;
};

/**
 * MVC property's state change handler function to show/hide the
 * control container.
 */
LatLngControl.prototype.visible_changed = function () {
    this.node_.style.display = this.get('visible') ? '' : 'none';
};

/**
 * Specified LatLng value is used to calculate pixel coordinates and
 * update the control display. Container is also repositioned.
 * @param {google.maps.LatLng} latLng Position to display
 */
LatLngControl.prototype.updatePosition = function (latLng) {
    var projection = this.getProjection();
    var point = projection.fromLatLngToContainerPixel(latLng);

    // Update control position to be anchored next to mouse position.
    this.node_.style.left = point.x + this.ANCHOR_OFFSET_.x + 'px';
    this.node_.style.top = point.y + this.ANCHOR_OFFSET_.y + 'px';

    // Update control to display latlng and coordinates.
    this.node_.innerHTML = [
        latLng.toUrlValue(4)
    ].join('');
};
