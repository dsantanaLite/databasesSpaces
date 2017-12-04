<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, java.math.BigDecimal, dbController.DBConnect" %>

<html>
	<head>
		<title> Database Access </title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div id="searchresult" align="center" >

			<form id="orderForm" action="./orderPage.jsp" method="POST">

				<h1>Order a Ship</h1>

				<fieldset align="left">
					<legend>Choose Your Ship and Parts:</legend> 
					<br><br>
			
					<select name="ships">
						<option>Choose a Ship</option>
		<%

					//This code block creates an options list of all ships in the database
					//for the user to choose from
	
					ArrayList<ArrayList<Object>> table = null;

					DBConnect conn = new DBConnect ("dsantana","silence");	
			
					//get ship names to make options table
					String query ="select SHIPNAME from emanuelb.Ship"; 
	
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

					<br><br>
			<%

			//get part names to make options
			query ="select PartName, PartCost from emanuelb.Part where isLux=1"; 

			//get query from DB as an array of arrays. 
			table = conn.getQueryAsLists(query);

			for(int i=1; i<table.get(0).size();i++){
				String name = (String) table.get(0).get(i);
				String cost = table.get(1).get(i).toString();
				out.write("<input type=checkbox name=\"parts[]\" id=\""+name+"\" value=\""+name+"\"/>");
				out.write("<label for=\""+name+"\">"+name+" ($"+cost+")</label><br>");
			}

			%>

			<p>These parts are required:</p>

			<%
			//get part names to make options
			query ="select PartName, PartCost from emanuelb.Part where isLux=0"; 

			//get query from DB as an array of arrays. 
			table = conn.getQueryAsLists(query);

			for(int i=1; i<table.get(0).size();i++){
				String name = (String) table.get(0).get(i);
				String cost = table.get(1).get(i).toString();
				out.write("<input type=checkbox checked=\"checked\" name=\"parts[]\" id=\""+name+"\" value=\""+name+"\"/>");
				out.write("<label for=\""+name+"\">"+name+" ($"+cost+")</label><br>");
			}



			%>

				</fieldset>

				<br><br>

				<label>Customer Name 
					<input type=text name="custName" required=true></input>
				</label>

				<br><br>

				<input type=submit value="Order Ship"> </input>


			</form>

			<%
				//THIS BLOCK ONLY NECESSARY POST-ORDER

				String customerName = request.getParameter("custName");
				String shipName = request.getParameter("ships");			

				out.write("<p>");		
			
				if(customerName!=null && !shipName.equals("Choose a Ship")){

					if(shipName.contains("'")){
						int index=shipName.indexOf('\'');
						shipName = shipName.substring(0,index)+"'"+shipName.substring(index);
					}

					//get select parts
					String[] partArray=request.getParameterValues("parts[]");		

					if(partArray!=null && partArray.length>=3){	

						query = "select MAX(CustNum) from emanuelb.Customer";

						table = conn.getQueryAsLists(query);
			
						//custNum of new customer is one more than the current max cust value. 
						BigDecimal custNumBig = (BigDecimal)table.get(0).get(1); 
						int custNum = custNumBig.intValue()+1; 

						query = "select MAX(ContractNum) from emanuelb.Contract";

						table = conn.getQueryAsLists(query);
			
						//contractNum of new contract is one more than the current max value. 
						BigDecimal contractNumBig = (BigDecimal)table.get(0).get(1); 
						int contractNum = contractNumBig.intValue()+1; 

						//get shipNumber that user chose
						query = "select ShipNum from emanuelb.Ship where ShipName='"+shipName+"'";

						table = conn.getQueryAsLists(query);
						BigDecimal shipNumBig = (BigDecimal) table.get(0).get(1); 
						int shipNum = shipNumBig.intValue();

						//select a department to build the ship
						query = "select DeptName from emanuelb.Department where ShipNum="+shipNum;

						table = conn.getQueryAsLists(query);
				
						Random rand = new Random();

						int deptIndex = rand.nextInt(table.get(0).size()-1)+1;
	
						String deptName = (String) table.get(0).get(deptIndex);

						int cost = 0;

						for (int i=0; i<partArray.length; i++){
							query = "select PartCost from emanuelb.Part where PartName='"+partArray[i]+"'";	
							table = conn.getQueryAsLists(query);
							BigDecimal costBig = (BigDecimal) table.get(0).get(1); 
							int newCost = costBig.intValue();
							cost += newCost;
						}
						
						query = "Insert into emanuelb.Customer values ("+custNum+", '"+customerName+"')";

						conn.execute(query);

						query = "insert into emanuelb.Contract values ("+contractNum+", "+custNum+", '"+deptName+"', "+shipNum+", "+cost+")";

						conn.execute(query);

						for(int i=0; i<partArray.length;i++){
							query = "select PartNum from emanuelb.Part where PartName='"+partArray[i]+"'";
							table = conn.getQueryAsLists(query);
							BigDecimal partNumBig = (BigDecimal) table.get(0).get(1);
							int partNum = partNumBig.intValue();
							query = "Insert into emanuelb.MissingPart values ("+contractNum+", "+partNum+")";
							conn.execute(query);
						}

						out.write("Your order has been placed, Thanks "+customerName);


					}else{
						out.write("ERROR: You must include the 3 required parts.");
					}
				
				}else{
					if(customerName!=null)
						out.write("ERROR: Please select a base ship");
				}
				
				out.write("</p>");

				conn.close();
			
			%>


			<a href=./index.jsp> Go Home</a>

		</div>


	</body>
</html>
