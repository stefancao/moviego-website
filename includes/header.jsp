<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved            
												          
	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363)								          
	Assignment: Movie Go						          
												          
	File: header.jsp 										 
												          
	Description:	
		header file

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/6/2016 		Created 					SC,TH
--------------------------------------------------------------%>
<%@ page contentType = "text/html;charset=UTF-8" pageEncoding = "UTF-8" %>

<%@include file="/includes/javaLib.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<title>
		<%
			if (pageTitle != null) {
				out.println(pageTitle);
			}
		%>
		</title>

		<!-- for mobile support -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- load bootstrap library -->
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	</head>
	<body>

		<!-- navbar -->
		<div class = '
			<%
				String navClassString = "navbar ";
				if (session.getAttribute("active") != null) {
					navClassString += "navbar-inverse ";
				}
				else {
					navClassString += "navbar-default ";
				}
				out.println(navClassString);
			%>
		'>

			<div class = "container">

			<!-- 3 bar for mobile version -->
				<button class = "navbar-toggle" data-toggle = "collapse" data-target = ".navHeaderCollapse">
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
				</button>

				<div class = "collapse navbar-collapse navHeaderCollapse">
					
					<ul class = "nav navbar-nav  navbar-left">
						<li><a href = "index.jsp"><img style='margin: 5px'width=25 height=25 src='images/moviego.png'>Movie Go</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">

						<%
							if (session.getAttribute("active") != null) {
								out.println("<li><a>Hello " + session.getAttribute("user") + "!</a></li>");
								out.println("<li><a href='manageAccount.jsp'>Manage Account</a></li>");
								out.println("<li><a href='logout.jsp'>Logout</a></li>");
							}
							else {
								out.println("<li><a href='login.jsp?return_url=" + request.getRequestURI() + "'>Login</a></li>");
							}
						%>
						
					</ul>
				</div>
			</div> <!-- end container-->
		</div> <!-- end navbar -->

		<!-- start of main container -->
		<div class="container">