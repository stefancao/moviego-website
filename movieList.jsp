<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          

	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363)							          
	Assignment: Movie Go						          
												          
	File: movieList.jsp 										 
												          
	Description:	
		list all the movies given zipCode		

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     10/30/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<% String pageTitle = "Movie List"; %>

<%@include file="includes/header.jsp" %>
<%@include file="includes/tmsapi.jsp" %>

<div>
	<!-- div for search result info -->
	<div class="searchResultInfo">
	</div>

	<table class='table table-striped'>
		<thead>
			<tr>
				<th>Movie</th>
				<th>Show Time</th>
				<th>Location</th>
			</tr>
		</thead>

		<!-- table container -->
		<tbody class="tablecontainer">
		</tbody>
	</table>
</div>

<script>

	// genre array
	var genre = [];
	<%
		// push the genre preference selected tot he array
		String genre[] = request.getParameterValues("genre");
		for (int i=0; i<genre.length; i++) {
			out.println("genre.push('" + genre[i] + "');");
		}
	%>

	// construct show time url
	var showtimesUrl = baseUrl + '/movies/showings';

	<%
		// set the js vars
		out.println("var zipCode = '" + request.getParameter("zipCode") + "';");
		out.println("var movieNameSearch = '" + request.getParameter("movieName") + "';");
		out.println("var searchDistance = '" + request.getParameter("searchDistance") + "';");
		out.println("var address = '" + request.getParameter("streetAddress") + ", " +request.getParameter("city") + ", " + request.getParameter("zipCode") + "';");

	%>

	// get today's date
	var d = new Date();
	var today = d.getFullYear() + '-' + (d.getMonth()+1) + '-' + d.getDate();

	$(document).ready(function() {

		// send off the query
		$.ajax({
			url: showtimesUrl,
			data: { 
				startDate: today,
				zip: zipCode,
				radius: searchDistance,
				jsonp: "showTimesDataHandler",
				api_key: apikey
			},
			dataType: "jsonp",
		});	
	});

	// callback to handle the show times data results
	function showTimesDataHandler(data) {

		// init count to keep track of how many search results are found
		var count = 0;
		
		// loop through the data
		$.each(data, function(index, movie) {
			var movieTitle = movie.title;

			// if the title or part of the title matches with the movie name search, keep it, else filter it out also make sure that the genre selection passes
			if ((movieTitle.toLowerCase().indexOf(movieNameSearch.toLowerCase()) != -1) && (passGenreSelection(movie.genres) != -1)) {

				// increment the count
				count++;

				// start tag of new row
				var movieData = "<tr>";

				// movie
				var divIdName = "result_" + count;
				movieData += "<td><a onclick='showHideMoreInfo(";
				movieData += '"' + divIdName + '"); ';
				movieData += "'><img style='margin: 5px' height='70px' width='50px' src='http://developer.tmsimg.com/" + movie.preferredImage.uri + "?api_key=" + apikey + "'> <font size='4'>" + movie.title + "</font></a><div id='result_" + count + "' style='margin:5px; display: none'><strong>Description:</strong> " + movie.longDescription + "<br><br><strong>Genre:</strong> " + movie.genres + "<br><br><strong>Cast: </strong>" + movie.topCast;

				// display rating if it exists
				if (movie.qualityRating != null) {
					movieData += "<br><br><strong>Rating: </strong>" + movie.qualityRating.value + "/4";
				} 
				movieData += "</div></td>";
						
				// show time
				movieData += "<td>";

				var isShowTimeValid = false;

				// loop through all showtimes
				for (var i=0; i<movie.showtimes.length; i++) {

					// if showtime has already passed, don't show it
					if (new Date().getTime() < new Date(movie.showtimes[i].dateTime).getTime()){
						movieData += "<div><a href='" + movie.showtimes[i].ticketURI + "'>" + movie.showtimes[i].dateTime.replace(/T/g, ' ') + " <img width=25 height=25 src='images/fandango_icon.png'></a></div>";
						isShowTimeValid = true;
					}
				}

				// if there is now showtime anymore, display message
				if (isShowTimeValid == false) {
					movieData += "There are no future showtime available today";
				}

				movieData += "</td>";
				
				// theatre name and link to direction
				movieData += "<td>"+" "+"<img width=25 height=25 src='images/location.png'><a href='direction.jsp?tid=" + movie.showtimes[0].theatre.id + "&address=" + address + "'> " + movie.showtimes[0].theatre.name +"</td>";

				movieData += "</tr>";
				$(".tablecontainer").append(movieData);
			}
		}); // end each

		// output the search result number
		$(".searchResultInfo").append('<p>Found ' + count + ' movies showing within ' + searchDistance + ' miles of ' + zipCode+':</p>');
		
	} // end showTimesDataHandler()

	// function to hide or show more info
	function showHideMoreInfo(idName) {
		
		// Hide advanced option
    	if (document.getElementById(idName).style.display == "block") {
    		document.getElementById(idName).style.display = "none";
    	}

    	// show advanced option
    	else {
	    	document.getElementById(idName).style.display = "block";
	    }
	}

	// function to test if a movie passes based on genre selection
	function passGenreSelection (genreList) {
		for (var i=0; i<genreList.length; i++) {
			for (var j=0; j<genre.length; j++) {
				if (genreList[i].toLowerCase().indexOf(genre[j].toLowerCase()) != -1) {

					// passes
					return 0;
				}
			}
		}

		// at this point, no genre passed so it fails
		return -1;
	}

</script>

<%@include file="includes/footer.jsp" %>