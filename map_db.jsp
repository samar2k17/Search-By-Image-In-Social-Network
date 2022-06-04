


<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<html>
<head>
    
<!-- begin snippet: js hide: false console: false babel: false -->

<!-- language: lang-js -->
<link href="css/style.css" rel="stylesheet" type="text/css">      
  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyBf5lpsj8kOMHBec3il2wdAsczo0_nHbAk"></script>
  <%
      ArrayList<String>lstLatitude=new ArrayList();
      ArrayList<String>lstLongitude=new ArrayList();
      
  Enumeration enum1=request.getParameterNames();
  while(enum1.hasMoreElements()){
      String str=(String)enum1.nextElement();
      lstLatitude.add(str.substring(0, str.indexOf(",")));
      lstLongitude.add(str.substring(str.indexOf(",")+1));

  }
 System.out.println( lstLatitude+"\n"+lstLongitude);
  %>
<script type="text/javascript">
    var map;
    var infowindow = new google.maps.InfoWindow();

    function initMap() {
      var directionsService = new google.maps.DirectionsService;
      var directionsDisplay = new google.maps.DirectionsRenderer({
        suppressPolylines: true,
        infoWindow: infowindow
      });
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 6,
        center: {
          lat: 28.70543,
          lng: 77.30285
        }
      });
      directionsDisplay.setMap(map);
      calculateAndDisplayRoute(directionsService, directionsDisplay);
    }

    function calculateAndDisplayRoute(directionsService, directionsDisplay) {
      var waypts = [
          <%
 int count=1;
          while(count<lstLatitude.size()){
          out.println("{ location: '"+lstLatitude.get(count)+","+lstLongitude.get(count)+"',  stopover: true   }");
          count++;
          if(count==lstLatitude.size()){
          
          }else{
          out.print(",");
          }
          }
          %>
            
  
        ];
      
directionsService.route({
        origin: {
          lat:<%=lstLatitude.get(0)%>,
          lng: <%=lstLongitude.get(0)%>
        },
        destination: {
          lat:<%=lstLatitude.get(lstLatitude.size()-1)%>,
          lng: <%=lstLongitude.get(lstLongitude.size()-1)%>
        },
        waypoints: waypts,
        optimizeWaypoints: true,
        travelMode: google.maps.TravelMode.DRIVING
      }, function(response, status) {
        if (status === google.maps.DirectionsStatus.OK) {
          directionsDisplay.setOptions({
            directions: response,
          })
          var route = response.routes[0];
          renderDirectionsPolylines(response, map);
        } else {
          window.alert('Directions request failed due to ' + status);
        }
      });
    }

    google.maps.event.addDomListener(window, "load", initMap);

    var polylineOptions = {
      strokeColor: '#C83939',
      strokeOpacity: 1,
      strokeWeight: 4
    };
    var colors = ["#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF", "#00FFFF"];
    var polylines = [];

    function renderDirectionsPolylines(response) {
      var bounds = new google.maps.LatLngBounds();
      for (var i = 0; i < polylines.length; i++) {
        polylines[i].setMap(null);
      }
      var legs = response.routes[0].legs;
      for (i = 0; i < legs.length; i++) {
        var steps = legs[i].steps;
        for (j = 0; j < steps.length; j++) {
          var nextSegment = steps[j].path;
          var stepPolyline = new google.maps.Polyline(polylineOptions);
          stepPolyline.setOptions({
            strokeColor: colors[i]
          })
          for (k = 0; k < nextSegment.length; k++) {
            stepPolyline.getPath().push(nextSegment[k]);
            bounds.extend(nextSegment[k]);
          }
          polylines.push(stepPolyline);
          stepPolyline.setMap(map);
          // route click listeners, different one on each step
          google.maps.event.addListener(stepPolyline, 'click', function(evt) {
            infowindow.setContent("you clicked on the route<br>" + evt.latLng.toUrlValue(6));
            infowindow.setPosition(evt.latLng);
            infowindow.open(map);
          })
        }
      }
      map.fitBounds(bounds);
    }
</script>
   </script>
</head>

<!-- language: lang-html -->

    <center><div id="map" style="width:660px; height:560px;"></div>
</body>
</html>
<!-- end snippet -->

