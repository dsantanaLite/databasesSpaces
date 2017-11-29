<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Query Result</title>
		
	</head>
	
	<body>
	<div id="searchresult" align="center" >
	<%
		
		ArrayList<ArrayList<Object>> table = null;

		DBConnect james = new DBConnect ("dsantana","silence");	

		out.write("PARAMETER:");
		out.write(request.getParameter("AdotYear"));
			
		String query ="select CNTLOCID, ROUTE from dsantana.adot"+request.getParameter("AdotYear"); 

		out.write(query);

		//get query from DB as an array of arrays. 
		table = james.getQueryAsLists(query);

		out.write(table.toString());
	
	%>
	</div>
	</body>
</html>
