<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title> Database Access </title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div id="searchresult" align="center" >

	<h1> Welcome Engineers</h1>	

		<form action="./engineerPage.jsp" method="GET">
			<label> Parts 
			<select name="parts">
				<option>Choose a Part</option>
		<%

		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get part names to make options table
		String query ="select PartName from emanuelb.Part"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			String partName = (String) table.get(0).get(i);
			out.write("<option value=\"");
			out.write(partName);
			out.write("\">" + partName);
			out.write("</option>");
		}

		%>

			</select>
			</label>
			<br><br>
			<label>New Cost 
				<input type=number name="newCost" required=true></input>
			</label>
			<br><br>
			<input type=submit value="Update Cost"> </input>
		<%
			String partName = request.getParameter("parts");
			String cost = request.getParameter("newCost");
	
			if(partName!=null && cost!=null){

				query = "update emanuelb.Part set PartCost="+cost+" where PartName='"+partName+"'";
				conn.execute(query);
				//place query for cost update here
				out.write("<p>The cost of "+partName+" has been changed to "+cost+"</P>");	
			}

		%>

		</form>



		<a href=./index.jsp> Go Home</a>


	</div>
	</body>
</html>
