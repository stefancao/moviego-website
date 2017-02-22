<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          

	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363)								          
	Assignment: Movie Go						          
												          
	File: DB_info.jsp 										 
												          
	Description:	
		information to connect to database	

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/24/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<%@ page import = "java.sql.*"%>

<%!
	private String getURL () {
		return "jdbc:mysql://127.0.0.1:3306/moviego";		
	}

	private String getUser () {
		return "moviego";
	}

	private String getPwd () {
		return "eecs118";	
	}
%>