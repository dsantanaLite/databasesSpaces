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
			
		String query ="select CNTLOCID, ROUTE from dsantana.adot"+request.getParameter("AdotYear")+" where CNTLOCID<100010"; 

		out.write(query);

		//get query from DB as an array of arrays. 
		table = james.getQueryAsLists(query);

		//the length of the longest string in each column. 
		//added to this list in order that they exist in the table object. 
		ArrayList<Integer> sizes = new ArrayList<Integer>();

		//find the greatest length string in each column and add that length to sizes arraylist. 
		for(int i=0; i<table.size();i++){

			ArrayList<Object> currList = table.get(i);

			int greatest=0;

			//each item in currList. 
			for (int j=0; j<currList.size();j++){

				String objstr;

				//some fields are null which will throw nullPointerException if tried to toString()
				if(currList.get(j)!=null)
					objstr = currList.get(j).toString();
				else
					objstr = "null";

				if(greatest<objstr.length())
					greatest = objstr.length();
			}

			sizes.add(greatest);	

		}

		//for num rows in the table. 	
		for(int i=0; i<table.get(0).size();i++){

			out.write("\n");
			//column seperator. 
			out.write(" | ");

			//for all columns
			for (int j=0; j<table.size();j++){

				String objstr;

				//some fields are null which will throw nullPointerException if tried to toString()
				if(table.get(j).get(i)!=null)
					objstr = table.get(j).get(i).toString();
				else
					objstr = "null";

				out.write(objstr);
	
				//print objstr.length()-sizes.get(j)+2 whitespaces this is to make
				//the columns print in clean columns. 
				for(int p=objstr.length(); p<sizes.get(j);p++){
					out.write(" ");
				}
				
				out.write(" | ");
			
			}
		}

		out.write("\n");


	%>
	</div>
	</body>
</html>
