<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Most Expensive Missing Part</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div align="center" >
	
		<h1>Most Expensive Missing Part</h1>	

	<%
		
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	

		String query ="SELECT MAX(PartCost) FROM emanuelb.Part "+
					"join emanuelb.MissingPart on MissingPart.PartNum=Part.PartNum";

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		out.write(DBConnect.toTable(table));

		conn.close();

	%>
		<br>
	
		<a href=./index.jsp> Go Home</a>

	</div>
	</body>
</html>
