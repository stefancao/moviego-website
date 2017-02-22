<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: manageAccount.jsp
												          
	Description:	
		manage/edit account

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/25/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<% String pageTitle = "Manage Account"; %>
<%@include file="/includes/header.jsp" %>
<%@include file="/includes/DB_info.jsp" %>

<div class="alert alert-info">
	Please fill in to update your current info
</div>

<%
	if (request.getParameter("u") != null && request.getParameter("u").equals("t")) {
		out.println("<div class='alert alert-success'><strong>Success!</strong> Your account was updated successfully</div>");
	}
%>

<%!
	private String generateLabelandInput (String label, String inputName, String inputValue, String erMessage) {
		return "<label class='col-lg-2 control-label'>" + label + ":</label><div class='col-lg-3'><input type='text' class='form-control' id='" + inputName + "Id' name='" + inputName + "' value=" + inputValue + "></div><label id='" + inputName + "ErId' style='display: none' class='col-lg-6 control-label'>" + erMessage + "</label>";
	}

	private String generateLabelandInputPassword (String label, String inputName, String erMessage) {
		return "<label class='col-lg-2 control-label'>" + label + ":</label><div class='col-lg-3'><input type='password' class='form-control' id='" + inputName + "Id' name='" + inputName + "'></div><label id='" + inputName + "ErId' style='display: none' class='col-lg-6 control-label'>" + erMessage + "</label>";
	}

%>

<%
	// establish a connection
	Connection con = DriverManager.getConnection(getURL(),getUser(),getPwd());
	PreparedStatement pstmt;
	ResultSet rs;

	String userId = (String) session.getAttribute("user_id");

	pstmt = con.prepareStatement("SELECT * FROM user WHERE user_id = ?");
	pstmt.clearParameters();
	pstmt.setString(1, userId);	
	rs = pstmt.executeQuery();
	rs.next();
	String userName = rs.getString("username");

	pstmt = con.prepareStatement("SELECT * FROM user_detail WHERE user_detail_id = ?");
	pstmt.clearParameters();
	pstmt.setString(1, userId);	
	rs = pstmt.executeQuery();
	rs.next();

	String firstName = rs.getString("first_name");
	String lastName = rs.getString("last_name");
	String streetAddress = rs.getString("street_address");
	String city = rs.getString("city");
	String zipCode = rs.getString("zipcode");
	int genrePreference = rs.getInt("genre_preference");

%>

<form class='form-horizontal' name='manageAccountForm' method='post' action='manageAccount_post.jsp' onsubmit='return checkValidation()'>

	<!-- First and Last name -->
	<div class='form-group' id='firstLastNameDiv'>
		<div id="firstNameDiv">
		<%
			// first name
			out.println(generateLabelandInput("First name", "firstName", firstName, "Please enter your first name"));
		%>
		</div>
		<div id="lastLastNameDiv">
		<%
			// last name
			out.println(generateLabelandInput("Last name", "lastName", lastName,"Please enter your last name"));
		%>
		</div>
	</div>

	<!-- username -->
	<div class='form-group' id='userNameDiv'>
		<%
			out.println(generateLabelandInput("User Name", "userName", userName, "Please enter a username"));
		%>
	</div>

	<!-- new password -->
	<div class='form-group' id='newPasswordDiv'>
		<%
			out.println(generateLabelandInputPassword("New Password", "newPassword", "Please enter your new password"));
		%>
	</div>

	<!-- re-enter new password -->
	<div class='form-group' id='reEnterNewpasswordDiv'>
		<%
			out.println(generateLabelandInputPassword("Reenter New Password", "reEnterNewPassword", "Please Reenter your new password"));
		%>
	</div>

	<hr>

	<!-- street address -->
	<div class='form-group' id='streetAddressDiv'>
		<%
			out.println(generateLabelandInput("Street Address", "streetAddress", streetAddress, ""));
		%>
	</div>

	<!-- city -->
	<div class='form-group' id='cityDiv'>
		<%
			out.println(generateLabelandInput("City", "city", city, ""));
		%>
	</div>

	<!-- zip code -->
	<div class='form-group' id='zipCodeDiv'>
		<%
			out.println(generateLabelandInput("ZIP Code", "zipCode", zipCode, ""));
		%>
	</div>

	<hr>

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
			int tmp = genrePreference & maskNumber;
			if (tmp == maskNumber) {
				out.println("<label class='checkbox-inline'><input type='checkbox' value='" + maskNumber + "' name='genrePreference' checked>" + genre + "</label>");
			}
			else {
				out.println("<label class='checkbox-inline'><input type='checkbox' value='" + maskNumber + "' name='genrePreference'>" + genre + "</label>");
			}
		}
			
	%>

	<hr>
	
	<!-- update button -->
	<div class='form-group' id='updateAcctButtonDiv'>
		<label class='col-lg-2 control-label'>
			<button class='btn btn-primary' type='submit'>Update</button>
		</label>
	</div>
</form>

<script>
	function checkValidation() {

		// get the values and store in vars
		var firstName = document.forms["manageAccountForm"]["firstName"].value;
		var lastName = document.forms["manageAccountForm"]["lastName"].value;
		var userName = document.forms["manageAccountForm"]["userName"].value;
		var newPassword = document.forms["manageAccountForm"]["newPassword"].value;
		var reEnterNewPassword = document.forms["manageAccountForm"]["reEnterNewPassword"].value;
		var streetAddress = document.forms["manageAccountForm"]["streetAddress"].value;
		var city = document.forms["manageAccountForm"]["city"].value;
		var zipCode = document.forms["manageAccountForm"]["zipCode"].value;
		
		// if if any inputs are empty
		if (firstName == "" || lastName == "" 
			|| userName == "" || newPassword == "" 
			|| reEnterNewPassword == "" || streetAddress == ""
			|| city == "" || zipCode == "" || newPassword != reEnterNewPassword) {
			
			// alert that there are errors
			alert ("Please fill fix the indicated inputs");

			if (firstName == "") {
				$('#firstNameDiv').addClass('has-error');
				document.getElementById("firstNameErId").style.display = "block";
			}
			else {
				$('#firstNameDiv').removeClass('has-error');
				document.getElementById("firstNameErId").style.display = "none";
			}

			if (lastName == "") {
				$('#lastLastNameDiv').addClass('has-error');
				document.getElementById("lastNameErId").style.display = "block";
			}
			else {
				$('#lastLastNameDiv').removeClass('has-error');
				document.getElementById("lastNameErId").style.display = "none";
			}

			if (userName == "") {
				$('#userNameDiv').addClass('has-error');
				document.getElementById("userNameErId").style.display = "block";
			}
			else {
				$('#userNameDiv').removeClass('has-error');
				document.getElementById("userNameErId").style.display = "none";
			}

			if (newPassword == "") {
				$('#newPasswordDiv').addClass('has-error');
				document.getElementById("newPasswordErId").style.display = "block";
			}
			else {
				$('#newPasswordDiv').removeClass('has-error');
				document.getElementById("newPasswordErId").style.display = "none";
			}

			if (reEnterNewPassword == "") {
				$('#reEnterNewpasswordDiv').addClass('has-error');
				document.getElementById("reEnterNewPasswordErId").style.display = "block";
			}
			else {
				$('#reEnterNewpasswordDiv').removeClass('has-error');
				document.getElementById("reEnterNewPasswordErId").style.display = "none";
			}

			if (streetAddress == "") {
				$('#streetAddressDiv').addClass('has-error');
				document.getElementById("streetAddressErId").style.display = "block";
			}
			else {
				$('#streetAddressDiv').removeClass('has-error');
				document.getElementById("streetAddressErId").style.display = "none";
			}

			if (city == "") {
				$('#cityDiv').addClass('has-error');
				document.getElementById("cityErId").style.display = "block";
			}
			else {
				$('#cityDiv').removeClass('has-error');
				document.getElementById("cityErId").style.display = "none";
			}

			if (zipCode == "") {
				$('#zipCodeDiv').addClass('has-error');
				document.getElementById("zipCodeErId").style.display = "block";
			}
			else {
				$('#zipCodeDiv').removeClass('has-error');
				document.getElementById("zipCodeErId").style.display = "none";
			}

			// check if passwords matches
			if (newPassword != "" && reEnterNewPassword != "" && newPassword != reEnterNewPassword) {
				alert("The passwords don't match!");
			}
			
			// return false so that user has to fix errors
			return false;
		}
	} 
</script>

<%@include file="includes/footer.jsp" %>