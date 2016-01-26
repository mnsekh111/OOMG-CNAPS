<!DOCTYPE html>
<html lang="en-US">
<head>
<title>CNAPS Coupled Northwest Atlantic Prediction System</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<link type="text/css" href="layout.css" rel="stylesheet">

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
	<script src="./jquery/development-bundle/ui/jquery.ui.button.js"></script> 
	<script src="./jquery/development-bundle/external/jquery.bgiframe-2.1.2.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.core.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.widget.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.mouse.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.draggable.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.position.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.resizable.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.dialog.js"></script> 
	<script src="./jquery/development-bundle/ui/jquery.ui.datepicker.js"></script> 
	<script type="text/javascript" src="./lib/loadImage.js"></script>
    <script type="text/javascript" src="./lib/animation_wa.js"></script>
    <script type="text/javascript" src="./lib/wave.js"></script>
    <script type="text/javascript" src="./lib/global.js"></script>

</head>
<body>
	<div id="page">
		<div id="logo" >
			<img src="image/bannerCNAPS.png" width="1140" height = "120">
		</div> <!-- end div id "logo" -->
		
		<div id="box">
			<div id="links" >
				<jsp:include page="links.jsp"></jsp:include>
			</div> <!-- end div id "links" -->
        <div id="title">Model Methods and Background
		</div>
		<div id="map">
     		<h1>Introduction</h1>
<p>This interactive site presents the Coupled Northwest Atlantic Prediction System (CNAPS), a three-dimensional marine environment nowcast and forecast model developed by the Ocean Observing and Modeling Group at North Carolina State University. This fully coupled ocean circulation, wave, and atmosphere model predicts conditions over a wide area of the coastal northwest Atlantic Ocean based on data collected daily. The model domain covers from the eastern edge of Nova Scotia to the north coast of Venezuela, including the Gulf of Maine, Middle Atlantic Bight, South Atlantic Bight, Gulf of Mexico, Caribbean Sea, and western Sargasso Sea. Model results are presented within the Google Maps interface with downloadable KML files for off line viewing.</p>

<p>Maps of model-generated regional dynamics over the northwest Atlantic Ocean along the coast of North America are organized into:
    <ul>
        <li><b>Marine Weather</b>, with variables: wind speed at 10 m above sea surface, air temperature at 2 m above sea surface, and sea-level air pressure;</li><br>
        <li><b>Ocean Waves</b>, showing significant wave height and direction; and</li><br>
        <li><b>Ocean Circulation</b>, with variables: ocean temperature, salinity, and currents that can be displayed at specific depths.</li>
    </ul>
<p><b>Virtual Oceanographer</b> allows users to take on the role of oceanographer, by collecting model-generated data. User-defined inquires include virtual transect (subsurface temperature, salinity, and velocity plots), virtual sounding (temperature and salinity profiles), and 72 hour particle trajectory prediction (Lagrangian drifters). </p>
<p><b>Model Validation </b>presents observational data alongside model output for a visual comparison of model accuracy.</p>
<hr>
<br>
<h1>How the CNAPS Nowcast/Forecast Works</h1>
<p>The CNAPS model takes into account dynamical couplings among ocean circulation, atmosphere, and ocean waves, and updates daily automatically, with outputs archived and distributed at 3 h intervals. Near-real time validations against extensive observations are incorporated to provide evaluations of model skill and performance. 72 h marine and atmospheric environmental predictions are presented seamlessly via the Google Maps framework.  Figure 1 is a diagram showing the model workflow.  Compared with the two other global models, the CNAPS solutions are unique in several ways, including: 1) the introduction of tidal forcing and river discharge from a lateral boundary, which provides a more realistic representation of coastal processes such as vertical mixing and river plume distributions; and 2) the three-way (ocean-atmosphere-wave) coupled framework accounts for a more complete physical processes.</p>
<img src="image/CNAPS-flowchart.JPG" style="width:693px; height:407px;">
<p id="caption">Figure 1. Flow chart of daily model initialization, iteration, and post-processing. From Yao et al. (in review). The variables exchanged through model coupling are shown.</p>
<hr>
<br>
<h1>How the CNAPS Nowcast/Forecast is Made</h1>
<p>The three-dimensional, coupled CNAPS system couples three state-of-the-art modeling components (ROMS, WRF and SWAN) that realistically account for dynamically important interactions and feedbacks among circulation, atmosphere, and wave processes. Several physical parameters, shown in Figure 1, are exchanged between the independent models every 10 minutes in model time.  This coupling is a key feature of CNAPS, increasing the accuracy of model predictions compared to uncoupled models. Extensive validations provide an indicator of model performance.</p>

<p>The CNAPS model was developed based on the Coupled Ocean-Atmosphere-Wave-Sediment Transport (COAWST) modeling system [Warner et al., 2010], which incorporates multiple state-of-the-art modeling components: the Regional Ocean Modeling System (ROMS) [Haidvogel et al., 2008] for ocean, the Weather Research and Forecasting Model (WRF) [Skamarock et al., 2008] for atmosphere, and Simulating Waves Nearshore (SWAN) [Booij et al., 1999] for surface waves. Precipitation, tidal, and river runoff effects are included in the model. The COAWST model has been used to study several coastal storms, associated physical interactions, and their effects on the atmosphere, ocean, and wave environments. These include simulations of tropical cyclones (Zambon et al. 2014a; Zambon et al. 2014b; Warner et al. 2010), strong Nor'easters (Nelson and He 2012), wave-current interactions along the inner-shelf (Kumar et al. 2012; Olabarrieta et al. 2011), and storms undergoing extra-tropical transition (Olabarrieta et al. 2012).</p>

<p>Particle trajectory prediction and other user-defined functions are also updated based on the latest model solutions but processed on-demand.</p>
<hr>
<br>
<h1>How the CNAPS Nowcast/Forecast is Validated</h1>
<p>Model validations provide continuous skill assessments for the operational forecasts. Observations from an extensive coastal ocean observing network provide the means to validate this model's predictions. These observations include routine measurements of marine meteorology, sea level, temperature, and salinity from buoys and coastal gauges; surface currents from high-frequency (HF) radar stations; sea surface temperature and sea surface height observations from satellites; and subsurface hydrographic data from opportunistic ship and glider surveys. These data are compared to the model's predictions. </p>
<p>On this site's Model Validation pages, the user may choose data stations and dates to see model predictions plotted with the observational data.</p>
<hr>
<br>
<h1>Model Ensemble</h1>
<p>Because there are a number of operational ocean models providing predictions of the marine environment for the northwest Atlantic Ocean, a multi-model ensemble is used routinely to generate a representative ocean state estimation and to facilitate inter-model comparison. Under the CNAPS Model Validation menu, the Ensemble page shows the CNAPS model (top left), the Navy's HYCOM model, the National Centers for Environmental Prediction (NCEP)'s HYCOM model, and an ensemble of the three models. </p>
<hr>
<br>
<h1>References</h1>
<p>Booij, N., R. C. Ris, and L. H. Holthuijsen (1999), A third-generation wave model for coastal regions: 1. Model description and validation, <i>Journal of Geophysical Research: Oceans</i>, 104(C4), 7649-7666.</p>
<p>Chassignet, E. P., H. E. Hurlburt, O. M. Smedstad, G. R. Halliwell, P. J. Hogan, A. J. Wallcraft, R. Baraille, and R. Bleck (2007), The HYCOM (HYbrid Coordinate Ocean Model) data assimilative system, <i>Journal of Marine Systems</i>, 65(1-4), 60-83.</p>
<p>Haidvogel, D. B., et al. (2008), Ocean forecasting in terrain-following coordinates: Formulation and skill assessment of the Regional Ocean Modeling System, <i>Journal of Computational Physics</i>, 227(7), 3595-3624. </p>
<p>Kalnay, E., et al. (1996), The NCEP/NCAR 40-Year Reanalysis Project, <i>Bulletin of the American Meteorological Society</i>, 77(3), 437-471.</p>

<p>Kumar, N., G. Voulgaris, J. C. Warner, and M. Olabarrieta (2012) Implementation of the vortex force formalism in the coupled ocean-atmosphere-wave-sediment transport (COAWST) modeling system for inner shelf and surf zone applications. <i>Ocean Modelling</i>, 47, 65-95, doi:10.1016/j.ocemod.2012.01.003.</p>
<p>NCEP  http://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/</p>

<p>Nelson, J., and R. He (2012) Effect of the Gulf Stream on winter extratropical cyclone outbreaks. <i>Atmospheric Science Letters</i>, 13(4), 311-316.</p>

<p>Olabarrieta, M., J. C. Warner, and N. Kumar (2011) Wave-current interaction in Willapa Bay. <i>Journal of Geophysical Research: Oceans</i>, 116, C12014, doi:10.1029/2011JC007387.</p>

<p>Olabarrieta, M., J. C. Warner, B. Armstrong, J. B. Zambon, and R. He (2012) Ocean-atmosphere dynamics during Hurricane Ida and Nor'Ida: An application of the coupled ocean-atmosphere-wave-sediment transport (COAWST) modeling system. <i>Ocean Modelling</i>, 43- 44, 112-137, doi:10.1016/j.ocemod.2011.12.008.</p>

<p>Shchepetkin, A. F., and J. C. McWilliams (2005), The regional oceanic modeling system (ROMS): a split-explicit, free-surface, topography-following-coordinate oceanic model, <i>Ocean Modelling</i>, 9(4), 347-404.</p>

<p>Skamarock, W. C., J. B. Klemp, J. Dudhia, D.O. Gill, D. Barker, M.G.Duda, X. Huang, and W. Wang (2008) A description of the advanced research WRF version 3. NCAR Technical Note NCAR/TN-475+STR, DOI: 10.5065/D68S4MVH.</p>

<p>Warner, J. C., B. Armstrong, R. He, and J. B. Zambon (2010), Development of a Coupled Ocean-Atmosphere-Wave-Sediment Transport (COAWST) Modeling System, <i>Ocean Modelling</i>, 35(3), 230-244.</p>

<p>Yao, Z., R. He, J. Zambon, Z. Xue, and Y. Liu, An integrated, three dimensional, coupled ocean circulation, wave, and atmosphere nowcast and forecast system developed for the U.S. East Coast, Gulf of Mexico, and Intra-Americas Sea, <i>Ocean Dynamics: Topical Collection on Coastal Ocean Forecasting Science</i>, in review.</p>

<p>Zambon, J. B., R. He, and J. C. Warner (2014) Investigation of Hurricane Ivan using the coupled ocean-atmosphere-wave-sediment transport (COAWST) model, <i>Ocean Dynamics</i>, 64(11), 1535-1554.</p>

<p>Zambon, J. B., R. He, and J. C. Warner (2014), Tropical to extratropical: Marine environmental changes associated with Superstorm Sandy prior to its landfall, <i>Geophysical Research Letters</i>, 41(24), 2014G-61357G.</p>
		</div><!-- end div "map"  -->
	</div><!-- end div "box"  -->
	<div id="footer">
       	<jsp:include page="footer.jsp"></jsp:include>
    </div>
</div><!-- end div "page"  -->


			
</body>
</html>
