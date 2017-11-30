<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Cost of Ship</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />

	</head>
	
	<body>


	<div align="center" >

		<h1>Cost of Ships</h1>

		<form action="./costOfShip.jsp" method="GET">
			<label> Ship Types <select name="ships">
				<option value="Good Ship">Good Ship</option>
				<option value="Bad Ship">Bad Ship</option>
				<option value="Mediocre Ship">Mediocre Ship</option>
			</select>
			</label>
			<br><br>
			<input type=submit value="See Cost"> </input>
		</form>
	<%
	
		String chosenShip = request.getParameter("ships");

		if(chosenShip!=null)	
			out.write("You chose to see the cost of ship: "+chosenShip);

		/*
			Once tables are prepared, the options table will be created
			by making a query to the database to get the names of all the ships. 
			
			Once a name is selected the database can again be queried to check its cost. 
		*/

		ArrayList<ArrayList<Object>> table = null;

		DBConnect james = new DBConnect ("dsantana","silence");	
			
		String query ="select CNTLOCID, ROUTE from dsantana.adot2012 where CNTLOCID<100010"; 

		//get query from DB as an array of arrays. 
		table = james.getQueryAsLists(query);

		james.close();

		out.write(DBConnect.toTable(table));

	%>

	<a href=./index.jsp> Go Home</a>


	</div>

	</body>
</html>
