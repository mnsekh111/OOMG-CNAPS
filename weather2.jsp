





<!DOCTYPE html>
<html>
<head>
    <title>USeast Nowcast/Forecast System</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <link type="text/css" href="layout.css" rel="stylesheet">
    <link type="text/css" href="reset.css" rel="stylesheet">
    <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?sensor=false">
    </script>

    <link type="text/css" href="jquery/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />
    <link rel="stylesheet" href="/css/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src=".jquery/js/jquery-ui-1.9.1.custom.min.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script>
    <script src="./development-bundle/ui/jquery.ui.button.js"></script>
    <script src="./jquery/development-bundle/external/jquery.bgiframe-2.1.2.js"></script>
    <script src="./development-bundle/ui/jquery.ui.core.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.mouse.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.draggable.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.position.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.resizable.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.dialog.js"></script>
    <script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script>



    <script type="text/javascript" src="./lib/loadImage.js"></script>
    <script type="text/javascript" src="./lib/animation_model.js"></script>
    <script type="text/javascript" src="./lib/val.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>
    <script type="text/javascript" src="./lib/weather.js"></script>
    <script type="text/javascript">
        var map;
        var overlaysArray=[];
        var root="/raid0/xzeng2/operational/plot/";

        var hfdate;
        var buoy_date;
        var buoy=null;
        var variable="Pair";

        $(document).ready(function () {
            getTodayStr();
            initialize();
            Init_map();
        });



        function initialize() {


            $(function() {

                $( "#variables" ).buttonset();
                //$( "#animationbutton").buttonset();
                $( "#buoy" ).buttonset();
                //if it's not IE
                $( "#buoy-time-list" ).buttonset();
                //if ($.browser.msie==null)

                //else{
                //	var version=$.browser.version;
                //	if (version!="8.0" && version!="9.0")
                //		alert("Detected your web browser is: IE "+version+".\nKnown compatibility issue is existed with this browser, please use another browser to gain better experience.");
                //}
            });


            //$('#time-list >  input').bind("click",
            //		function(){
            //			hfdate=this.id;
            //			$.get(	"servlet/ValServlet1?"+
            //					"day="+hfdate.substring(0, 8)+"&"+
            //					"hfdate="+hfdate, function(data){
            //					if (data=="fail"){
            //						alert("Sorry, this data is not available yet.");
            //						return;
            //					}});
            //window.open("servlet/ValServlet1?"+
            //		"day="+hfdate.substring(0, 8)+"&"+
            //		"hfdate="+hfdate, "Model Validation", 'height=700,width=1100' );
            //			window.open("hfimage.jsp","hfradarimage","width=665, height=500");
            //plotvalidation1();
            //					});


            jQuery(document).ready(function(){
                $("#buoy > input").click(function(e){
                    buoy=this.id;
                    if(buoy_date!=null)
                    {
                        $.get(	"servlet/WeatherValServlet?"+
                                "day="+buoy_date.substring(0,8)+"&"+
                                "date="+buoy_date+"&"+"buoy="+buoy+"&variable="+variable, function(data){
                            if (data=="fail"){
                                alert("Sorry, this data is not available yet.");
                                return;
                            }});
                        window.open("weathervalimage.jsp?day="+buoy_date.substring(0,8)+"&date="+buoy_date+"&buoy="+buoy+"&variable="+variable, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=665' );
                    }
                });
            });

            jQuery(document).ready(function(){
                $("#buoy-time-list > input").click(function(e){
                    buoy_date=this.id;
                    if(buoy!==null)
                    {
                        $.get(	"servlet/WeatherValServlet?"+
                                "day="+buoy_date.substring(0,8)+"&"+
                                "date="+buoy_date+"&buoy="+buoy+"&variable="+variable, function(data){
                            if (data=="fail"){
                                alert("Sorry, this data is not available yet.");
                                return;
                            }});
                        window.open("weathervalimage.jsp?day="+buoy_date.substring(0,8)+"&date="+buoy_date+"&buoy="+buoy+"&variable="+variable, "Model Validation", 'top='+e.screenY + ',left=' + e.screenX +', height=470, width=665' );
                    }
                    else
                        alert("Sorry, please select a buoy site first.");
                });
            });



            $(function() {
                $( "#datepicker2" ).datepicker({
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function(dateText,inst){
                        loadMoreDates2(dateText);
                    }
                });
            });

            $(document).ready(function(){
                $("#Pair").click(function(){
                    variable=this.id;
                    Init_slp_map();
                    //Hide_wspmap();
                    //Hide_2mtempmap();
                });
                $("#Wind").click(function(){
                    variable=this.id;
                    //Init_wsp_map();
                    //Hide_slpmap();
                    //Hide_2mtempmap();
                });
                $("#Tair").click(function(){
                    variable=this.id;
                    //Init_2mtemp_map();
                    //Hide_wspmap();
                    //Hide_slpmap();
                });
            });

            $(document).ready(function(){
                $("#showtext").click(function(){
                    $("#description").toggle();
                });
            });

            $(function(){
                $("#showtext").button({
                    icons: {
                        primary: "ui-icon-plusthick"
                    },
                    text: false
                });
            });

            $(document).ready(function(){
                $("#Pair").trigger('click');
                //$("#description").hide();
                //$("#archive_2").hide();
            });

            mapInit();

            //InitLatlng(map);

        }





    </script>

    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-12288686-5']);
        _gaq.push(['_trackPageview']);

        (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

    </script>

</head>
<body>
<div id="page">
    <div id="logo" align="center" >
        <img src="image/banner_new.png" width="1140" height = "120">

    </div>
    <div id="box">
        <div id="links" >
            <ul id="menu">
                <li><a href="atm.jsp" title="marine weather">Marine Weather</a></li>
                <li><a href="wave.jsp" title="wave">Ocean Wave</a></li>
                <li>
                    <a href="ocean.jsp" title="ocean">Ocean Circulation</a>
                    <ul class = "noJS">
                        <li><a href="ocean.jsp" title="Ocean">Simulated Isosurface</a></li>
                        <li><a href="transection.jsp" title="Transection">Simulated Transect</a></li>
                        <li><a href="vertical.jsp" title="Vertical">Simulated Profile</a></li>
                        <li><a href="trajectory.jsp" title="Drifter Trajectory">Simulated Trajectory</a></li>
                        <!--  <li><a href="float.jsp" title="Float Experiment">Float Experiment</a></li>-->
                    </ul>
                </li>
                <li><a href="val.jsp" title="Model Validation">Model Validation</a>
                    <ul class = "noJS">
                        <li><a href="val.jsp" title="Ocean">Circulation</a></li>
                        <li><a href="weather.jsp" title="Transection">Weather</a></li>
                        <li><a href="waveval.jsp" title="Vertical">Wave</a></li>
                    </ul>
                </li>
                <li><a href="ensemble.jsp" title="Ensemble">Ensemble</a></li>
                <!--  <li><a href="http://secoora.org/maps/" title="observation">Observations</a></li>-->
            </ul>

        </div>

        <div id="map">
            <div id="map_canvas" > </div>


            <form>
                <div id="variables">
                    <input type="radio" id="Pair" name="radio" checked="checked" /><label for="Pair"><big>SLP</big></label>
                    <input type="radio" id="Wind" name="radio"  /><label for="Wind"><big>Wind</big></label>
                    <input type="radio" id="Tair" name="radio"  /><label for="Tair"><big>Air Temperature</big></label>

                </div>
            </form>


            <div id="date">


                <form>
                    <div id="buoy">
                        <span class="text">Buoy Station</span><br/>
                        <input type="radio" id="41002" name="radio"   /><label for="41002"><big>Wrightsville Beach, NC</big></label>
                        <input type="radio" id="41008" name="radio"   /><label for="41008"><big>Springmaid Pier, NCL</big></label>
                        <input type="radio" id="41012" name="radio"   /><label for="41012"><big>Mayport, FL</big></label>
                        <input type="radio" id="41013" name="radio"   /><label for="41013"><big>Virginia Key, FL</big></label>
                        <input type="radio" id="41046" name="radio"   /><label for="41046"><big>Key West, FL</big></label>
                        <input type="radio" id="41047" name="radio"   /><label for="41047"><big>Naples, FL</big></label>
                        <input type="radio" id="41048" name="radio"   /><label for="41048"><big>Clearwater Beach, FL</big></label>
                        <input type="radio" id="42001" name="radio"   /><label for="42001"><big>Panama City, FL</big></label>
                        <input type="radio" id="42003" name="radio"   /><label for="42003"><big>Wrightsville Beach, NC</big></label>
                        <input type="radio" id="42012" name="radio"   /><label for="42012"><big>Springmaid Pier, NCL</big></label>
                        <input type="radio" id="42020" name="radio"   /><label for="42020"><big>Mayport, FL</big></label>
                        <input type="radio" id="42036" name="radio"   /><label for="42036"><big>Virginia Key, FL</big></label>
                        <input type="radio" id="42056" name="radio"   /><label for="42056"><big>Key West, FL</big></label>
                        <input type="radio" id="42058" name="radio"   /><label for="42058"><big>Naples, FL</big></label>
                        <input type="radio" id="44014" name="radio"   /><label for="44014"><big>Clearwater Beach, FL</big></label>
                        <input type="radio" id="44025" name="radio"   /><label for="44025"><big>Panama City, FL</big></label>
                        <input type="radio" id="44037" name="radio"   /><label for="44037"><big>Wrightsville Beach, NC</big></label>
                        <input type="radio" id="44056" name="radio"   /><label for="44056"><big>Springmaid Pier, NCL</big></label>
                        <input type="radio" id="44065" name="radio"   /><label for="44065"><big>Mayport, FL</big></label>
                        <input type="radio" id="99999" name="radio"   /><label for="99999"><big>Virginia Key, FL</big></label>
                    </div>
                </form>


                <form>
                    <div id="buoytime">
                        <span class="text">Buoy Date:</span>
                        <div id="buoy-time-list">


                            <script type="text/javascript">
                                buoy_date=20160511+"_0000";
                            </script>

                            <script>
                                availableDates1.push(20160430);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160430_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160430_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">04/30/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160430_" name="radio" /><label for="20160430_">04/30/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160501);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160501_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160501_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/01/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160501_" name="radio" /><label for="20160501_">05/01/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160502);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160502_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160502_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/02/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160502_" name="radio" /><label for="20160502_">05/02/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160503);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160503_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160503_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/03/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160503_" name="radio" /><label for="20160503_">05/03/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160504);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160504_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160504_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/04/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160504_" name="radio" /><label for="20160504_">05/04/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160505);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160505_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160505_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/05/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160505_" name="radio" /><label for="20160505_">05/05/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160506);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160506_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160506_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/06/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160506_" name="radio" /><label for="20160506_">05/06/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160507);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160507_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160507_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/07/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160507_" name="radio" /><label for="20160507_">05/07/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160508);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160508_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160508_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/08/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160508_" name="radio" /><label for="20160508_">05/08/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160509);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160509_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160509_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/09/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160509_" name="radio" /><label for="20160509_">05/09/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160510);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160510_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160510_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/10/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160510_" name="radio" /><label for="20160510_">05/10/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160511);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160511_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160511_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/11/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160511_" name="radio" /><label for="20160511_">05/11/2016</label>
                            <!--  [endif]>-->



                            <script>
                                availableDates1.push(20160512);
                            </script>

                            <!--  [if IE]>
                            <input type="radio" id="20160512_" name="radio" class="ui-helper-hidden-accessible"/>
                            <label for="20160512_" aria-pressed="false" class="ui-button ui-widget ui-state-default ui-button-text-only" role="button" aria-disabled="false">
                                <span class="ui-button-text">05/12/2016</span>
                            </label>
                            <![endif]>

		  			<![if !IE]>-->
                            <input type="radio" id="20160512_" name="radio" /><label for="20160512_">05/12/2016</label>
                            <!--  [endif]>-->



                        </div>
                    </div>
                </form>


                <div id="archive_2">
                    <a href="#" onClick="showDatepicker2();">Buoy Archive</a>
                </div>

                <dir id="archive_3">
                    Please select the date below:<input type="text" id="datepicker2">
                </dir>


                <p>Instruction &nbsp;&nbsp;<button id="showtext">Show Instruction</button></p>
                <div id="description">
                    <li>Depth: Clicking on one of these will update the layer and display the selected depth</li>
                    <li>Variables: Selecting different one can control the model variable shown</li>
                    <li>Date: Selecting one of these will update the model so that the time selected is display</li>
                    <li>Animation: Click on &quot;Start animation&quot; button will display the 72 hours forecast from today, given the selected depth and variable; Click on &quot;Stop&quot; to terminate the animation</li>
                    <li>Archive: Click and select the date of archive you want to inspect</li>
                    <p><font color="#ff0000">DISCLAIMER:
                        This nowcast/forecast system is a research product developed and maintained by
                        <a href="http://omgrhe.meas.ncsu.edu/Group/">Ocean Observing and Modeling Group</a> at North Carolina State University.
                        No warranty is made, expressed or implied at this stage, regarding the accuracy
                        or validity of model results, or regarding the suitability of the model output
                        for any particular application. </font>
                    </p>
                </div>
            </div>


        </div>
    </div>
    <div id="footer">
        <a href="http://omgrhe.meas.ncsu.edu/Group/" title="Ocean Observing and Modeling Group"><img src="image/omg_logo2.png" width="142" height="80"></img></a>
        <a href="http://www.ncsu.edu"><img src="image/ncsu_logo.gif" width="100" height="80"/></a>
        <a href="http://secoora.org/"><img src="image/secoora_logo.png" width="280" height="80" /></a>
        <a href="http://www.noaa.gov/"><img src="image/noaa-logo.jpg" width="100" height="80"/></a>
        <a href="http://www.renci.org//"><img src="image/renci_logo.jpg" width="138" height="80"/></a></br></br>
        <div id="eXTReMe">
            <a href="http://extremetracking.com/open?login=omgncsu">
                <img src="http://t1.extreme-dm.com/i.gif" style="border: 0; float:left;" height="38" width="41" id="EXim" alt="eXTReMe Tracker" /></a>
            Questions or comments? Please contact here <a href="mailto:rhe@ncsu.edu">1</a>,<a href="mailto:zxue@ncsu.edu">2</a>,<a href="mailto:yliu63@ncsu.edu">3</a>
            <script type="text/javascript"><!--
            EXref="";top.document.referrer?EXref=top.document.referrer:EXref=document.referrer;//-->
            </script><script type="text/javascript"><!--
        var EXlogin='omgncsu' // Login
        var EXvsrv='s9' // VServer
        EXs=screen;EXw=EXs.width;navigator.appName!="Netscape"?
                EXb=EXs.colorDepth:EXb=EXs.pixelDepth;EXsrc="src";
        navigator.javaEnabled()==1?EXjv="y":EXjv="n";
        EXd=document;EXw?"":EXw="na";EXb?"":EXb="na";
        EXref?EXref=EXref:EXref=EXd.referrer;
        EXd.write("<img "+EXsrc+"=http://e0.extreme-dm.com",
                "/"+EXvsrv+".g?login="+EXlogin+"&amp;",
                "jv="+EXjv+"&amp;j=y&amp;srw="+EXw+"&amp;srb="+EXb+"&amp;",
                "l="+escape(EXref)+" height=1 width=1>");//-->
        </script>
            <noscript>
                <div id="neXTReMe"><img height="1" width="1" alt=""
                                        src="http://e0.extreme-dm.com/s9.g?login=omgncsu&amp;j=n&amp;jv=n" />
                </div>
            </noscript>
        </div>

    </div>
</div>

</body>
</html>
