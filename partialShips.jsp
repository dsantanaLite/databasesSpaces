<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Partially Complete Ships</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>

	<h1>Partially Complete Ships</h1>	

	<div id="searchresult" align="center" >
	<pre>

	<%
		
		ArrayList<ArrayList<Object>> table = null;

		DBConnect james = new DBConnect ("dsantana","silence");	

		String query ="select CNTLOCID, ROUTE from dsantana.adot2012 where CNTLOCID<100010"; 

		out.write(query);
	
		//get query from DB as an array of arrays. 
		table = james.getQueryAsLists(query);

		james.close();

		out.write(DBConnect.toTable(table));

	%>
	</pre>
	</div>
	<a href=./index.jsp> Go Home</a>
	</body>
</html>
