<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: manageAccount_post.jsp
												          
	Description:	
		manage/edit account post

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/25/2016 		Created 					SC,TH
--------------------------------------------------------------%>
<%@include file="/includes/javaLib.jsp" %>
<%@include file="/includes/DB_info.jsp" %>

<%

	// establish a connection
	Connection con = DriverManager.getConnection(getURL(),getUser(),getPwd());
	PreparedStatement pstmt;
	ResultSet rs;

	// set userId
	String userId = (String) session.getAttribute("user_id");

	// set vars
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String userName = request.getParameter("userName");
	String newPassword = request.getParameter("newPassword");
	String reEnterNewPassword = request.getParameter("reEnterNewPassword");
	String streetAddress = request.getParameter("streetAddress");
	String city = request.getParameter("city");
	String zipCode = request.getParameter("zipCode");

	String genrePreference[] = request.getParameterValues("genrePreference");

	// set the new Genre preference
	int newGenrePref = 0;
	for (int i=0; i<genrePreference.length; i++) {
		int tmpMask = Integer.parseInt(genrePreference[i]);
		newGenrePref |= tmpMask;
	}

	// update user
	pstmt = con.prepareStatement("UPDATE user SET username=?, password=? WHERE user_id=?");
	pstmt.clearParameters();
	pstmt.setString(1, userName);
	pstmt.setString(2, newPassword);
	pstmt.setString(3, userId);
	pstmt.executeUpdate();

	// update user detail
	pstmt = con.prepareStatement("UPDATE user_detail SET first_name=?, last_name=?, street_address=?, city=?, zipcode=?, genre_preference=? WHERE user_detail_id=?");
	pstmt.clearParameters();
	pstmt.setString(1, firstName);
	pstmt.setString(2, lastName);
	pstmt.setString(3, streetAddress);
	pstmt.setString(4, city);
	pstmt.setString(5, zipCode);
	pstmt.setInt(6, newGenrePref);
	pstmt.setString(7, userId);
	pstmt.executeUpdate();
	
	// go back with update is success
	response.sendRedirect("manageAccount.jsp?u=t");
%>