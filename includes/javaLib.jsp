<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          

	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363)								          
	Assignment: Movie Gp						          
												          
	File: javaLib.jsp 										 
												          
	Description:	
		importing java libraries	

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/6/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>

<%
	// include the mysql jdbc driver
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	} catch(Exception e) {
		out.println("can't load mysql driver");
		out.println(e.toString());
	}
%>


