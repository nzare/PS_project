<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="ISO-8859-1">
   <title>OpenLayers Example</title>
    <script src="http://openlayers.org/api/OpenLayers.js"></script>
    </head>
    <body>
    
    <input type="button" value="Show Map" onclick="return change(this);" />

  <div style="width:100%; height:100%" id="map"></div>

<script defer="defer" type="text/javascript">
function change( el )
{
    if ( el.value === "Show Map" ){
    	document.getElementById('map').style.visibility = 'visible'; 
        el.value = "Hide Map";
    var map = new OpenLayers.Map('map');
    var wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
        "http://localhost:8083/geoserver/wms", {layers: 'ind:ind'}     );
    map.addLayer(wms);
    map.zoomToMaxExtent();
    }
    else{
        el.value = "Show Map";
        document.getElementById('map').style.visibility = 'hidden'; 
   }
}

</script>
</body>
</html>