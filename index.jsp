<!DOCTYPE html>
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>I4 Space Group</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
		<style>


		</style>

	</head>

	<body>

		<div class="container" align="center">
		
			<h1>Welcome to I4</h1>
	
			<br><br>


			<a href="./costOfShip.jsp"> Cost of Ships</a>

			<br/>
    
			<a href="./partialShips.jsp"> Partially Complete Ships</a>
		
			<br/>

			<a href="./bestCustomer.jsp">Top Customer</a>

			<br/>
			
			<a href="./engineerPage.jsp"> Engineer Log In </a>	

			<br/>	

			<a href="./missingPartsAvg.jsp"> Average Cost of Missing Parts </a>	

			<br/>	

			<a href="./mostExpensivePart.jsp"> Most Expensive Missing Part</a>	

			<br/>	



			<form action="./index.jsp" method="GET">

				<h2>Order a Ship</h2>

				<label> Ships 
				<select name="custShip">
					<option>Choose a Ship</option>
			<%

			ArrayList<ArrayList<Object>> table = null;

			DBConnect conn = new DBConnect ("dsantana","silence");	
			
			//get part names to make options table
			String query ="select ShipName from emanuelb.Ship"; 

			//get query from DB as an array of arrays. 
			table = conn.getQueryAsLists(query);

			for(int i=1; i<table.get(0).size(); i++){
				String shipName = (String) table.get(0).get(i);
				out.write("<option value=\"");
				out.write(shipName);
				out.write("\">" + shipName);
				out.write("</option>");
			}

			%>

				</select>
				</label>
				<br><br>
				<label>Customer Name 
					<input type=text name="custName" required=true></input>
				</label>
				<br><br>
				<input type=submit value="Order Ship"> </input>
			</form>

			<%

				String customerName = request.getParameter("custName");
				String customerShip = request.getParameter("custShip");
			
				//place query to add ship order to DB here. 
				if(customerName!=null && customerShip!=null){
				
					if(customerShip.equals("Choose a Ship"))	
						out.write("<p>Please choose a ship from the list.</p>");
					else
						out.write("<p>Thank you "+customerName+", your order for "+customerShip+" has been recieved.</p>");
				}

			%>
	
		</div>

	</body>
</html>

