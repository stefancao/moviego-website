<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          

  Name: Stefan Cao (ID# 79267250)         
      Ting-Yi Huang (ID# 58106363)                        
  Assignment: Movie Go                      
                                  
  File: showLinup.jsp                      
                                  
  Description:  
    list all the service provider from user's zipcode and country

  History:
    Date  Update Description           Developer  
     --------  ---------------------          ------------       
     10/30/2016     Created           SC,TH
--------------------------------------------------------------%>
<% String pageTitle = "Lineup From Zip Code"; %>

<%@include file="includes/header.jsp" %>
<%@include file="includes/tmsapi.jsp" %>

<div>
  <!-- div for search result info -->
  <div class="searchResultInfo">
  </div>

  <table class='table table-striped'>
    <thead>
      <tr>
        <th>Cable Provider</th>
        <th>Lineup ID</th>
      </tr>
    </thead>

    <!-- table container -->
    <tbody class="tablecontainer">
    </tbody>
  </table>
</div>

<script>
  var showtimesUrl = baseUrl + '/lineups';
  var lineList = [];
  var smovieUrl = baseUrl + '/movies/airings';
<%
   out.println("var zipCode = '" + request.getParameter("zipCode") + "';");
   out.println("var country = '" + request.getParameter("country") + "';");
   out.println("var lineupId = '" + request.getParameter("lineupId") + "';");
  out.println("var movieNameSearch = '" + request.getParameter("movieName") + "';");

%>
  var d = new Date();
  var today = d.getFullYear() + '-' + (d.getMonth()+1) + '-' + d.getDate();
  var mList = []; 

  $(document).ready(function() {
    // send off the query
    $.ajax({
      url: showtimesUrl,
      data: {
        country: country,
        postalCode: zipCode, 
        jsonp: "dataHandler",
        api_key: apikey
      },
      dataType: "jsonp",
      
    }); //end ajax

  }); //end ready

   // callback to handle the results
  function dataHandler(data) {
    var count = 0;
    var tmplineID;

      $.each(data, function(index, lineups) {
        var lineName = lineups.name;
        count++;

        if(tmplineID != lineups.lineupId){
          lineList.push(lineups.lineupId);
          tmplineID = lineups.lineupId;
        }
       
        lineupData = "<tr>";
        //sending specific lineupId
        lineupData +="<td><a href = 'showMovie.jsp?lineupId=";
        lineupData += lineups.lineupId;
        lineupData += "&movieName=" + movieNameSearch +  "'>";
        lineupData += lineName;
        lineupData += "</a></td>";
        //lineup id
        lineupData += "<td>" +lineups.lineupId+"</td>";
        $(".tablecontainer").append(lineupData);
    }); //end each
      
      $(".searchResultInfo").append('<p>Found ' + count + ' Lineup names in ' + zipCode+':</p>');
  
  }//end dataHandler()





</script>
<%@include file="includes/footer.jsp" %>