<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved                   
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363) 								          
	Assignment: Movie Go						          
												          
	File: createAccount_post.jsp 
												          
	Description:	
		post file to create an account	

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/24/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<%@include file="/includes/javaLib.jsp" %>
<%@include file="/includes/DB_info.jsp" %>

<%
	// set vars
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String reEnterPassword = request.getParameter("reEnterPassword");
	String streetAddress = request.getParameter("streetAddress");
	String city = request.getParameter("city");
	String zipCode = request.getParameter("zipCode");

	// establish a connection
	Connection con = DriverManager.getConnection(getURL(),getUser(),getPwd());

	// prepared statement to insert user
	PreparedStatement pstmt = con.prepareStatement("INSERT INTO user VALUES(default,?,?,default,default)", Statement.RETURN_GENERATED_KEYS);
	pstmt.clearParameters();
	pstmt.setString(1, userName);
	pstmt.setString(2, password);
	pstmt.executeUpdate();
	ResultSet rs = pstmt.getGeneratedKeys();
	rs.next();
	String tmpId = rs.getString(1);

	// prepared statement to insert user_detail
	pstmt = con.prepareStatement("INSERT INTO user_detail VALUES(?,?,?,?,?,?,default)");
	pstmt.clearParameters();
	pstmt.setString(1, tmpId);
	pstmt.setString(2, firstName);
	pstmt.setString(3, lastName);
	pstmt.setString(4, streetAddress);
	pstmt.setString(5, city);
	pstmt.setString(6, zipCode);

	pstmt.executeUpdate();

	session.setAttribute("active", true);
	session.setAttribute("user_id", tmpId);
	session.setAttribute("user", userName);

	// return to index with param ca (create account) is t (true)
	response.sendRedirect("index.jsp?ca=t");
%>