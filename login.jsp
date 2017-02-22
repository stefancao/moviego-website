<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: login.jsp 										 
												          
	Description:	
		login page			

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/24/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<% String pageTitle = "Login"; %>

<%@include file="includes/header.jsp" %>

<div class="alert alert-info">
	Please enter your login informations
</div>

<%
	// if error has been sent back
	if (request.getParameter("er") != null) {
		String erMessage = "";
		if (request.getParameter("er").equals("pwd")) {
			erMessage = "Password does NOT match";
		}
		else if (request.getParameter("er").equals("usr")) {
			erMessage = "No such username";
		}
		out.println("<div class='alert alert-danger'>" + erMessage + "</div>");
	}
%>

<form class='form-horizontal' name='loginForm' method='post' action='login_post.jsp' onsubmit='return checkValidation()'>

	<input type="hidden" name="return_url" value='
	<%
		// save the return url as hidden input
		out.println(request.getParameter("return_url"));
	%>
	'>

	<!-- username -->
	<div class='form-group' id='userNameDiv'>
		<label for='userName' class='col-lg-2 control-label'>User:</label>
		<div class='col-lg-3'>
			<input type='text' class='form-control' id='userNameId' name='userName'>
		</div>
		<label id='userNameErId' style='display: none' class='col-lg-6 control-label' for='inputError'>Please enter your username</label>
	</div>

	<!-- password -->
	<div class='form-group' id='passwordDiv'>
		<label for='password' class='col-lg-2 control-label'>Password:</label>
		<div class='col-lg-3'>
			<input type='password' class='form-control' id='passwordId' name='password'>
		</div>
		<label id='passwordErId' style='display: none' class='col-lg-6 control-label' for='inputError'>Please enter your password</label>
	</div>

	<!-- Login button -->
	<div class='form-group' id='loginButtonDiv'>
		<label for='loginButton' class='col-lg-2 control-label'>
			<button class='btn btn-primary' type='submit'>Login</button>
		</label>
	</div>

</form>

<!-- create an account -->
<div align="center" style="margin: 20px">
	<label>
		Don't have an account? <a href='createAccount.jsp?return_url=
		<%
			out.println(request.getParameter("return_url"));
		%>
		'>Create one!</a>	
	</label>
</div>

<script>
	function checkValidation() {

		// get the values and store in vars
		var userName = document.forms["loginForm"]["userName"].value;
		var password = document.forms["loginForm"]["password"].value;
		
		// if if any inputs are empty
		if (userName == "" || password == "") {
			
			// alert that there are errors
			alert ("Please fill fix the indicated inputs");

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
			
			// return false so that user has to fix errors
			return false;
		}
	} 
</script>

<%@include file="includes/footer.jsp" %>