function single(){
	//Add event listener
	google.maps.event.addListener(map, 'click', function(event) {
    	addMarker(event.latLng);
  	}); 
}



var rectangle;
var marker1;
var marker2;

function multi(){
	  // Plot two markers to represent the Rectangle's bounds.
    marker1 = new google.maps.Marker({
      map: map,
      position: new google.maps.LatLng(22, -90),
      draggable: true,
      title: 'Drag me!'
    });
    marker2 = new google.maps.Marker({
      map: map,
      position: new google.maps.LatLng(25, -85),
      draggable: true,
      title: 'Drag me!'
    });
    
    // Allow user to drag each marker to resize the size of the Rectangle.
    google.maps.event.addListener(marker1, 'drag', redraw);
    google.maps.event.addListener(marker2, 'drag', redraw);
    
    // Create a new Rectangle overlay and place it on the map.  Size
    // will be determined by the LatLngBounds based on the two Marker
    // positions.
    rectangle = new google.maps.Rectangle({
      map: map,
      fillColor: '#FF0000'
    });
    redraw();
    
    google.maps.event.addListener(rectangle, 'click', showDrifters);
}

function redraw() {
    var latLngBounds = new google.maps.LatLngBounds(
      marker1.getPosition(),
      marker2.getPosition()
    );
    rectangle.setBounds(latLngBounds);
  }

function showDrifters(){
	if (marker1.getPosition().lat()>marker2.getPosition().lat())
	{
		max=marker1.getPosition().lat();
		min=marker2.getPosition().lat();
	}
	else
	{
		max=marker2.getPosition().lat();
		min=marker1.getPosition().lat();
	}
	lng1=marker1.getPosition().lng();
	lng2=marker2.getPosition().lng();
	
	for(i=0;i<5;i++){
		var latLng=new google.maps.LatLng(
				(max-min)*Math.random()+min,
				(lng2-lng1)*Math.random()+lng1);
		plotDrifter(latLng);
	}
			
}