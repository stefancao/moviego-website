<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: login_post.jsp 										 
												          
	Description:	
		login post file			

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/24/2016 		Created 					SC,TH
--------------------------------------------------------------%>
<%@include file="/includes/javaLib.jsp" %>
<%@include file="/includes/DB_info.jsp" %>

<%!
	// function to redirect to the previos page
	private String redirectBack(String page) {
		String returnValue = "<form id='main' method='post' name='main' action='" + page + "'</form>";

		returnValue += "<script type='text/javascript'>document.getElementById('main').submit();</script>";

		return returnValue;
	}
%>

<%
	// set vars
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");

	// establish a connection
	Connection con = DriverManager.getConnection(getURL(),getUser(),getPwd());
	PreparedStatement pstmt = con.prepareStatement("SELECT user_id,password FROM user WHERE username = ?");
	pstmt.clearParameters();
	pstmt.setString(1, userName);
	ResultSet rs = pstmt.executeQuery();

	// if there exists a such user
	if (rs.next() != false) {
		String userId = rs.getString(1);
		String pwdDB = rs.getString(2);
		
		// if password matches log in
		if (password.equals(pwdDB)) {
			session.setAttribute("active", true);
			session.setAttribute("user_id", userId);
			session.setAttribute("user", userName);
			response.sendRedirect(request.getParameter("return_url"));
		}

		// else go back to login
		else {
			String returnString = "login.jsp?return_url=" + request.getParameter("return_url") + "&er=pwd";
			out.println(redirectBack(returnString));
		}
	}

	// else if it doesn't exists such user
	else {
		String returnString = "login.jsp?return_url=" + request.getParameter("return_url") + "&er=usr";
			out.println(redirectBack(returnString));
	}
%>