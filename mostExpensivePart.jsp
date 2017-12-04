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

		<form action="./mostExpensivePart.jsp" method="GET">
			<select name="contractNum">
				<option>Choose a Contract</option>
	<%

		//This code block creates an options list of all contracts in the database
		//for the user to choose from
	
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get contracts to make options table
		String query ="select ContractNum from emanuelb.Contract"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			String contractNum = table.get(0).get(i).toString();
			out.write("<option value=\"");
			out.write(contractNum);
			out.write("\">" + contractNum);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>

			<input type=submit value="See Cost"> </input>
		</form>

	<%

			String contractNum = request.getParameter("contractNum");

			if(contractNum!=null && !contractNum.equals("Choose a Contract")){

				query ="SELECT MAX(PartCost) as Cost FROM emanuelb.Part "+
					"join emanuelb.MissingPart on MissingPart.PartNum=Part.PartNum "+
					"WHERE MissingPart.contractNum="+contractNum;

				table=conn.getQueryAsLists(query);
	
				out.write(DBConnect.toTable(table));

				conn.close();
			}



	%>

		<br>
	
		<a href=./index.jsp> Go Home</a>

	</div>
	</body>
</html>
