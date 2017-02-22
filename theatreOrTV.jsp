<%--------------------------------------------------------------
Copyright Stefan Cao and Ting-Yi Huang 2016 - All Rights Reserved          

	Name: Stefan Cao (ID# 79267250)					
		  Ting-Yi Huang (ID# 58106363)							          
	Assignment: Movie Go						          
												          
	File: theatreOrTV.jsp 										 
												          
	Description:	
		send to handle theatre or TV

	History:
		Date 	Update Description 	   		   Developer  
     --------  ---------------------          ------------	     
     11/28/2016 		Created 					SC,TH
--------------------------------------------------------------%>

<%@include file="/includes/javaLib.jsp" %>

<%
	String sendToURL = "";

	// if searchType is theatre
	if (request.getParameter("searchType").equals("theatre")) {
		sendToURL = "movieList.jsp";
	}	

	// if searchType is TV
	else {
		sendToURL = "showLineup.jsp";
	}

	// send all the form vars to the next redirected page
	Enumeration en = request.getParameterNames();
 		
	String returnString = "<form method='post' id='sendFormId' name='sendForm' action='" + sendToURL + "'>";

	while (en.hasMoreElements()) {
		String parameterName = (String) en.nextElement();
		String parameterValue = request.getParameter(parameterName);

		returnString += "<input type='hidden' name='" + parameterName + "' value='" + parameterValue + "'>";
	}

	returnString += "</form>";

	// submit the page
	returnString += "<script type='text/javascript'>document.getElementById('sendFormId').submit();</script>";
	
	out.println(returnString);

%>