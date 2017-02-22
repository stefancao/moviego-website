<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: direction.jsp 										 
												          
	Description:	
		show direction 

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/12/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<% String pageTitle = "Direction"; %>
<link rel="stylesheet" type="text/css" href="css/maps.css">
<%@include file="includes/header.jsp" %>
<%@include file="includes/tmsapi.jsp" %>

<div id="right-panel"></div>
<div id="map"></div>

<script>
	<%
		// js var for theatre URL
		out.println("var theatreURL = baseUrl + '/theatres/" + request.getParameter("tid") + "'; ");
	%>

	$(document).ready(function() {

		// send off the query
		$.ajax({
			url: theatreURL,
			data: { 
				jsonp: "dataHandler",
				api_key: apikey
			},
			dataType: "jsonp",
		});
	});

	// callback to handle the results
	function dataHandler(data) {

		// set the destination address
		var destinationAddress = data.location.address.street + ", " + data.location.address.city + ", " + data.location.address.postalCode;

		// call initMap
		initMap(destinationAddress);
	} // end dataHandler()

	// init map
	function initMap(destAddress) {
		var directionsDisplay = new google.maps.DirectionsRenderer;
		var directionsService = new google.maps.DirectionsService;
		var map = new google.maps.Map(document.getElementById('map'));
		directionsDisplay.setMap(map);
		directionsDisplay.setPanel(document.getElementById('right-panel'));

		// call calculateAndDisplayRoute()
		calculateAndDisplayRoute(directionsService, directionsDisplay,destAddress);

	} // end initMap()

	// calculated and displays the route
	function calculateAndDisplayRoute(directionsService, directionsDisplay,destAddress) {

		<%
			// start address
			out.println("var start = '" + request.getParameter("address") + "';");
		%>

		var end = destAddress;
			directionsService.route({
			origin: start,
			destination: end,
			travelMode: 'DRIVING'
			}, function(response, status) {
				if (status === 'OK') {
					directionsDisplay.setDirections(response);
				} else {
					window.alert('Directions request failed due to ' + status);
			}
		});
	} // end calculateAndDisplayRoute()
</script>

<!-- google maps -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDzx4W9lj1_S2yxVqbPDkw2xlgWvTu8Ra4">
</script>

<%@include file="includes/footer.jsp" %>