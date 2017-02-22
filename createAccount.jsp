<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: createAccount.jsp 
												          
	Description:	
		create an account	

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/24/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<% String pageTitle = "Create an Account"; %>

<%@include file="includes/header.jsp" %>

<div class="alert alert-info">
	Please fill in your informations to create an account
</div>

<%!
	// function to generate label and input
	private String generateLabelandInput (String label, String inputName, String erMessage) {
		return "<label class='col-lg-2 control-label'>" + label + ":</label><div class='col-lg-3'><input type='text' class='form-control' id='" + inputName + "Id' name='" + inputName + "'></div><label id='" + inputName + "ErId' style='display: none' class='col-lg-6 control-label'>" + erMessage + "</label>";
	}

	// function to generate label and input for password
	private String generateLabelandInputPassword (String label, String inputName, String erMessage) {
		return "<label class='col-lg-2 control-label'>" + label + ":</label><div class='col-lg-3'><input type='password' class='form-control' id='" + inputName + "Id' name='" + inputName + "'></div><label id='" + inputName + "ErId' style='display: none' class='col-lg-6 control-label'>" + erMessage + "</label>";
	}
%>

<form class='form-horizontal' name='createAccountForm' method='post' action='createAccount_post.jsp' onsubmit='return checkValidation()'>

	<input type="hidden" name="return_url" value='
	<%
		// save the return URL 
		out.println(request.getParameter("return_url"));
	%>
	'>

	<!-- First and Last name -->
	<div class='form-group' id='firstLastNameDiv'>
		
		<div id="firstNameDiv">
		<%
			// first name
			out.println(generateLabelandInput("First name", "firstName", "Please enter your first name"));
		%>
		</div>
		<div id="lastLastNameDiv">
		<%
			// last name
			out.println(generateLabelandInput("Last name", "lastName", "Please enter your last name"));
		%>
		</div>
	</div>

	<!-- username -->
	<div class='form-group' id='userNameDiv'>
		<%
			out.println(generateLabelandInput("User Name", "userName", "Please enter a username"));
		%>
	</div>

	<!-- password -->
	<div class='form-group' id='passwordDiv'>
		<%
			out.println(generateLabelandInputPassword("Password", "password", "Please enter a password"));
		%>
	</div>

	<!-- re-enter password -->
	<div class='form-group' id='repasswordDiv'>
		<%
			out.println(generateLabelandInputPassword("Reenter Password", "reEnterPassword", "Please Reenter the password"));
		%>
	</div>

	<hr>

	<!-- street address -->
	<div class='form-group' id='streetAddressDiv'>
		<%
			out.println(generateLabelandInput("Street Address", "streetAddress", "Please enter your street address"));
		%>
	</div>

	<!-- city -->
	<div class='form-group' id='cityDiv'>
		<%
			out.println(generateLabelandInput("City", "city", "Please enter your city"));
		%>
	</div>

	<!-- zip code -->
	<div class='form-group' id='zipCodeDiv'>
		<%
			out.println(generateLabelandInput("ZIP Code", "zipCode", "Please enter your zip code"));
		%>
	</div>

	<!-- submit button -->
	<div class='form-group' id='createAcctButtonDiv'>
		<label class='col-lg-2 control-label'>
			<button class='btn btn-primary' type='submit'>Submit</button>
		</label>
	</div>
</form>

<script>
	function checkValidation() {

		// get the values and store in vars
		var firstName = document.forms["createAccountForm"]["firstName"].value;
		var lastName = document.forms["createAccountForm"]["lastName"].value;
		var userName = document.forms["createAccountForm"]["userName"].value;
		var password = document.forms["createAccountForm"]["password"].value;
		var reEnterPassword = document.forms["createAccountForm"]["reEnterPassword"].value;
		var streetAddress = document.forms["createAccountForm"]["streetAddress"].value;
		var city = document.forms["createAccountForm"]["city"].value;
		var zipCode = document.forms["createAccountForm"]["zipCode"].value;
		
		// if if any inputs are empty
		if (firstName == "" || lastName == "" 
			|| userName == "" || password == "" 
			|| reEnterPassword == "" || streetAddress == ""
			|| city == "" || zipCode == "" || password != reEnterPassword) {
			
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

			if (password == "") {
				$('#passwordDiv').addClass('has-error');
				document.getElementById("passwordErId").style.display = "block";
			}
			else {
				$('#passwordDiv').removeClass('has-error');
				document.getElementById("passwordErId").style.display = "none";
			}

			if (reEnterPassword == "") {
				$('#repasswordDiv').addClass('has-error');
				document.getElementById("reEnterPasswordErId").style.display = "block";
			}
			else {
				$('#repasswordDiv').removeClass('has-error');
				document.getElementById("reEnterPasswordErId").style.display = "none";
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
			if (password != "" && reEnterPassword != "" && password != reEnterPassword) {
				alert("The passwords don't match!");
			}
			
			// return false so that user has to fix errors
			return false;
		}
	} 
</script>

<%@include file="includes/footer.jsp" %>