<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          

  Name: Stefan Cao (ID# 79267250)         
      Ting-Yi Huang (ID# 58106363)                        
  Assignment: Movie Go                      
                                  
  File: showMovie.jsp                      
                                  
  Description:  
    list all the movies from selected service provider (lineupId)   

  History:
    Date  Update Description           Developer  
     --------  ---------------------          ------------       
     10/30/2016     Created           SC,TH
--------------------------------------------------------------%>
<% String pageTitle = "Movies from TV"; %>

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
        <th>Start Time</th>
        <th>End Time</th>
        <th>Duration</th>
        <th>Channel</th>
      </tr>
    </thead>

    <!-- table container -->
    <tbody class="tablecontainer">
    </tbody>
  </table>
</div>
<script>
  var smovieUrl = baseUrl + '/movies/airings';
  <%
    out.println("var lineupId = '" + request.getParameter("lineupId") + "';");
    out.println("var movieNameSearch = '" + request.getParameter("movieName") + "';");
  %>

  var d = new Date();
  var today = d.getFullYear() + '-' + (d.getMonth()+1) + '-' + d.getDate();
  var mList = []; //list to store the pushed result of movies

  $(document).ready(function() {
    // send off the query
    $.ajax({
      
      //url: theatreURL,
      url: smovieUrl,
      data: { 
        startDate: today,
        lineupId: lineupId,
        jsonp: "dataHandler",
        api_key: apikey
      },
      dataType: "jsonp",
      
    });

  });

  // callback to handle the results
  function dataHandler(data) {
    var count = 0; //num of results
    var tmptmsid; //keep track of the prev tmsid

    $.each(data, function(index, airings){
       var movieTitle = airings.program.title;
       //if movieTitle was entered, it will filter down to show the movie from that service company
        if(movieTitle.toLowerCase().indexOf(movieNameSearch.toLowerCase()) != -1){
            count++;
            if(tmptmsid != airings.program.tmsId){
              mList.push(airings.program.tmsId);
              tmptmsid = airings.program.tmsId;
            }
            movieData = "<tr>";

            //title: will show the image of the movie and its basic descritions
            var divIdName = "result_" + count;
            movieData += "<td><a onclick='showHideMoreInfo(";
            movieData += '"' + divIdName + '"); ';
            movieData += "'><img style='margin: 5px' height='70px' width='50px' src='http://developer.tmsimg.com/" + airings.program.preferredImage.uri + "?api_key=" + apikey + "'> <font size='4'>" + airings.program.title + "</font></a><div id='result_" + count + "' style='margin:5px; display: none'><strong>Description:</strong> " + airings.program.longDescription + "<br><br><strong>Genre:</strong> " + airings.program.genres + "<br><br>";
            movieData += "</div></td>";

            //Start Time
            movieData += "<td>" +airings.startTime.replace(/T/g,' ').replace(/Z/g,' ')+"<img width=25 height=25 src='images/start-time-clock.png'></td>";

            //End Time
            movieData += "<td>" +airings.endTime.replace(/T/g,' ').replace(/Z/g,' ')+"<img width=25 height=25 src='images/end-time-clock.png'></td>";

            //Duration
            movieData += "<td>" +airings.duration+"</td>";

            //Channel
            movieData += "<td>"+"<img width=25 height=25 src='images/tv.png'>"+" "+airings.channels+"</td>";

            $(".tablecontainer").append(movieData);
          
        }
    });//end each
     $(".searchResultInfo").append('<p>Found ' + count + ' Movies From '+lineupId+' service provider</p>');
  } //end dataHandler()

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

  
    
</script>

<%@include file="includes/footer.jsp" %>