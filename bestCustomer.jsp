<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title> I4 Best Customer</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>

	
		<div id="searchresult" align="center" >
	
			<h1>Top Customer</h1>	

		<%
		
			ArrayList<ArrayList<Object>> table = null;

			DBConnect conn = new DBConnect ("dsantana","silence");	

			String query =  "select customer.custnum, customer.custname, sum(Contract.cost) as total_cost "+
							"from emanuelb.Contract "+
							"join emanuelb.Customer on Contract.custnum=Customer.custnum "+
							"where rownum<=1 "+
							"GROUP BY customer.custnum, customer.custname "+
							"ORDER BY total_cost DESC";

			//get query from DB as an array of arrays. 
			table = conn.getQueryAsLists(query);
	
			conn.close();

			out.write(DBConnect.toTable(table));

		%>
	
			<br><br>
			<a href=./index.jsp> Go Home</a>

		</div>
	</body>
</html>
		
