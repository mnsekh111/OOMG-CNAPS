var timer_is_on=0;
var c=0;	//counter for animation
var t;
var overlaysArray=[];
var isFirstTime=true;
var datearray=[];

function foo()
{
	/*
	var imageBounds=new google.maps.LatLngBounds(
	    	new google.maps.LatLng(16.51,-97,87),
	    	new google.maps.LatLng(36.39,-69.70));
	*/
	/*
    var oldmap0=new google.maps.GroundOverlay(
        	"./image/20110111_0000.png",imageBounds);
    var oldmap1=new google.maps.GroundOverlay(
        	"./image/20110111_0300.png",imageBounds);
    var oldmap2=new google.maps.GroundOverlay(
        	"./image/20110111_0600.png",imageBounds);
    
    overlaysArray.push(oldmap0);
    overlaysArray.push(oldmap1);
    overlaysArray.push(oldmap2);      
     */
	
	overlaysArray=[];
	$('input:button')[0].disabled="disabled";
	$('input:button')[1].disabled="";
	
	overlayvalidation1.setMap(null);
	
	if (overlayvalidation!=null)
		overlayvalidation.setMap(null);
	
	var length=availableDates.length;
	for (i=length-4;i<length;i++){
		for(j=0;j<=21;j+=3){
			d1=availableDates[i];
			setDate(d1,j);
			overlayvalidation=new google.maps.GroundOverlay(
					"servlet/ValServlet3?"+
					"day="+d1.substring(0, 8)+"&"+
					"date="+date,imageBounds);
			overlaysArray.push(overlayvalidation);
		}
	}
	doTimer();
}

function foo_ensemble()
{
	$('input:button')[0].disabled="disabled";
	$('input:button')[1].disabled="";

	var length=availableDates1.length;
    var k=0;
	for (i=length-4;i<length;i++){
		for(j=0;j<=21;j+=3){
			d1=availableDates1[i];
			setDate(d1,j);
			datearray[k]=d1;
			k++;
		}
	}
	if (!timer_is_on)
	  {
	  timer_is_on=1;
	  animation_ensemble();
	  }

}

function animation()
{
	if (isFirstTime!=true && c!=0)
		overlaysArray[c-1].setMap(null);
	else if (c==0)
		overlaysArray[overlaysArray.length-1].setMap(null);
	isFirstTime=false;
	overlaysArray[c].setMap(map);
	t=setTimeout("animation()",1000);
	c=(c+1)%overlaysArray.length;
	
}

function animation_ensemble()
{
	document.getElementById("ensembleimage").src="servlet/Ensemble?"+"day="+datearray[c].substring(0,8);
	t=setTimeout("animation_ensemble()",3000);
	c=(c+1)%datearray.length;
}

function clearOverlays(){
	if (overlaysArray){
		for(i in overlaysArray){
			overlaysArray[i].setMap(null);
		}
	}
}

function showOverlays(){
	if (overlaysArray){
		for(i in overlaysArray){
			overlaysArray[i].setMap(map);
		}
	}
}

function doTimer()
{
if (!timer_is_on)
  {
  timer_is_on=1;
  animation();
  }
}

function stopCount()
{
clearTimeout(t);
timer_is_on=0;
isFirstTime=true;
clearOverlays();

$('input:button')[1].disabled="disabled";
$('input:button')[0].disabled="";

}

function stopCount_ensemble()
{
clearTimeout(t);
timer_is_on=0;
$('input:button')[1].disabled="disabled";
$('input:button')[0].disabled="";
}

