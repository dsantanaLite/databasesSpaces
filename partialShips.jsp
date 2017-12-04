<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Partially Complete Ships</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div  align="center" >
	
		<h1>Partially Complete Ships</h1>	

	<%
		
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	

//		String query ="SELECT ShipNum, emanuelb.Contract.ContractNum FROM emanuelb.Contract, emanuelb.MissingPart "+
//						"WHERE emanuelb.Contract.ContractNum = emanuelb.MissingPart.ContractNum "+
//						"group by emanuelb.Contract.ContractNum having emanuelb.Contract.ContractNum>0";

		String query = "select ShipNum, ContractNum from emanuelb.Contract where ContractNum IN ( "+
						"select ContractNum from emanuelb.MissingPart)";
	
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
