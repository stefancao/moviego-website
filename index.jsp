<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: index.jsp 										 
												          
	Description:	
		index/home page			

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     10/30/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<% String pageTitle = "Movie Go"; %>

<%@include file="includes/header.jsp" %>
<%@include file="/includes/DB_info.jsp" %>

<%!
	// function to genereate the label and input
	private String generateLabelandInput (String label, String inputName, String inputValue, String erMessage) {
		return "<label class='col-lg-2 control-label'>" + label + ":</label><div class='col-lg-3'><input type='text' class='form-control' id='" + inputName + "Id' name='" + inputName + "' value='" + inputValue + "'></div><label id='" + inputName + "ErId' style='display: none' class='col-lg-6 control-label'>" + erMessage + "</label>";
	}
%>

<%
	// if create account (ca) is true (coming from createAccount.jsp), the show success message
	if (request.getParameter("ca") != null && request.getParameter("ca").equals("t")) {
		out.println("<div class='alert alert-success'><strong>Success!</strong> Your account was created successfully</div>");
	}
%>

<%

	// establish a connection
	Connection con = DriverManager.getConnection(getURL(),getUser(),getPwd());
	PreparedStatement pstmt;
	ResultSet rs;

	// init vars
	String streetAddress = "";
	String city = "";
	String zipCode = "";
	int genrePreference = 0;

	// if session is active, get user's details
	if (session.getAttribute("active") != null) {

		// get userId from session
		String userId = (String) session.getAttribute("user_id");

		// get user details
		pstmt = con.prepareStatement("SELECT * FROM user_detail WHERE user_detail_id = ?");
		pstmt.clearParameters();
		pstmt.setString(1, userId);	
		rs = pstmt.executeQuery();
		rs.next();

		// set the values to vars
		streetAddress = rs.getString("street_address");
		city = rs.getString("city");
		zipCode = rs.getString("zipcode");
		genrePreference = rs.getInt("genre_preference");
	}

%>

<form class='form-horizontal' name='Form' method='post' action='theatreOrTV.jsp'>
	
	<!-- search type (theatre or TV) -->
	<div class='form-group' id='searchTypeDiv'>
		<label style="margin-right: 20px">Please check your search type:</label>
		<label class='radio-inline'><input type='radio' value='theatre' name='searchType' checked>Theatre</label>
		<label class='radio-inline'><input type='radio' value='TV' name='searchType'>TV</label>
	</div>

	<!-- Movie -->
	<div class='form-group' id='movieNameDiv'>
		<%
			out.println(generateLabelandInput("Movie", "movieName", "", "Please enter the Movie Name"));
		%>
	</div>

	<hr>

	<!-- street address -->
	<div class='form-group' id='streetAddressDiv'>
		<%
			out.println(generateLabelandInput("Street Address", "streetAddress", streetAddress, "Please enter your street address"));
		%>
	</div>

	<!-- city -->
	<div class='form-group' id='streetAddressDiv'>
		<%
			out.println(generateLabelandInput("City", "city", city, "Please enter you city"));
		%>
	</div>

	<!-- zip code -->
	<div class='form-group' id='zipCodeDiv'>
		<%
			out.println(generateLabelandInput("ZipCode", "zipCode", zipCode, ""));
		%>
		
		<!-- added by EH -->
		<label for='country' class='col-lg-2 control-label'>Country:</label>
		<div class='col-lg-3'>
			<select name = 'country' class = "selectpicker">
				<option>USA</option>
				<option>CAN</option>
				<option>AUT</option>
				<option>GBR</option>
			</select>
		</div>
		<!-- added by EH -->
			
		<label id='zipCodeErId' style='display: none' class='col-lg-6 control-label' for='inputError'>Please enter the zip code</label>

	</div>

	<hr>

	<!-- toggler to show or hide advanced option -->
	<div>
		<a onclick="showHideAdvancedOption();">
			<span id="upDownIcon" style="margin:5px"class="glyphicon glyphicon-menu-down"></span><label id="showHideLabel">Show advanced options</label>
		</a>
	</div>

	<!-- show/hide advanced options -->
	<div id='advancedOptionsDiv' style="display: none">

		<!-- within what distance to search -->
		<div class='form-group' id='searchDistanceDiv'>
			<%
				out.println(generateLabelandInput("Search within (miles)", "searchDistance", "5", ""));
			%>
		</div>	

		<!-- Genre Preferences -->
		<label>Please check your genre preferences:</label>
		<br>
		
		<%
			pstmt = con.prepareStatement("SELECT * FROM genre");
			pstmt.clearParameters();
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String genre = rs.getString("genre_name");
				int maskNumber = rs.getInt("mask_number");

				// AND it to see if it is one of user's preference
				int tmp = genrePreference & maskNumber;

				// if user's preference or if user is not active check it
				if (tmp == maskNumber || session.getAttribute("active") == null) {
					out.println("<label class='checkbox-inline'><input type='checkbox' value='" + genre + "' name='genre' checked>" + genre + "</label>");
				}

				// else don't check the checkbox
				else {
					out.println("<label class='checkbox-inline'><input type='checkbox' value='" + genre + "' name='genre'>" + genre + "</label>");
				}
			}
				
		%>			
	</div>

	<!-- search button -->
	<div class='form-group' id='searchButtonDiv'>
		<label class='col-lg-2 control-label'>
			<button class='btn btn-primary' type='submit'>Search</button>
		</label>
	</div>
</form>

<script>

	// toggle between showing or hidign between advanced option
    function showHideAdvancedOption () {

    	// Hide advanced option
    	if (document.getElementById("advancedOptionsDiv").style.display == "block") {
    		document.getElementById("advancedOptionsDiv").style.display = "none";
    		document.getElementById("upDownIcon").className = "glyphicon glyphicon-menu-down";
    		document.getElementById("showHideLabel").innerHTML = "Show advanced options";
    	}

    	// show advanced option
    	else {
	    	document.getElementById("advancedOptionsDiv").style.display = "block";
	    	document.getElementById("upDownIcon").className = "glyphicon glyphicon-menu-up";
	    	document.getElementById("showHideLabel").innerHTML = "Hide advanced options";
	    }
    }

</script>

<%@include file="includes/footer.jsp" %>