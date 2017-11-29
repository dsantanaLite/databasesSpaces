package dbController;

/*
This class constructor created with help from Dr. McCann's JDBC.java example. 

	Class: 
		DBConnect
	Name:
		David Santana
	Dependency:
		oracle.jdbc.OracleDriver
	Purpose:	
		This class created to make querying simpler when a user wants to receive a table as a list of objects.
		Also prevents user from having to import any SQL into their program if using this object and the 
		querying method provided. 
	Class Variables:
		Connection dbconn - the connection to the oracle db
		Statement stmt    - the statement used for all queries
	Constructor:
		DBConnect(username, password)  
			create the Connection dbconn using the provided username and password
	Methods:
		ArrayList<ArrayList<Object>> getQueryAsLists(String query)  
			execute the query argument and return a 2d arraylist containing the resulting
			relation's columns and rows. 
							
		void close()
			close the statement and connection to the DB. 
*/
import java.util.ArrayList;
import java.sql.*;          

public class DBConnect{
      
	Connection dbconn;//the connection to the database. 
	Statement stmt; //the statement used to execute all queries

	/*
		CONSTRUCTOR DBConnect(username, password)

		Creates a connection to the oracle database using the username and password
		arguments. 

	*/
	public DBConnect(String username, String password){


	    final String oracleURL = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
	
		 try {

                Class.forName("oracle.jdbc.OracleDriver");

        } catch (ClassNotFoundException e) {

                System.err.println("ClassNotFoundException: Error loading Oracle JDBC driver.");
                System.exit(-1);

        }

        // make and return a database connection to the user's
        // Oracle database
        dbconn = null;

        try {
                dbconn = DriverManager.getConnection(oracleURL,username,password);

        } catch (SQLException e) {

                System.err.println("SQLException: Could not open JDBC connection.");
                System.err.println("Message:   " + e.getMessage());
                System.err.println("SQLState:  " + e.getSQLState());
                System.err.println("ErrorCode: " + e.getErrorCode());
                System.exit(-1);

        }
	}

	/*
		close()
		close this db connection

	*/
	public void close(){

		try{
		
			//if a query is never made stmt could be null	
			if(stmt!=null)
				stmt.close();
			dbconn.close();	
		}
		catch(SQLException e){
			System.out.println("Error trying to close db connection");
			System.exit(-1);
		}

	}

	public ArrayList<ArrayList<Object>> getQueryAsLists (String query){

		ResultSet answer = null;
		ArrayList<ArrayList<Object>> table = null;

        try {

			//make the resultset scrollable and read only 
            stmt = dbconn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

			//execute query provided by user in the argument
	        answer = stmt.executeQuery(query);

			ResultSetMetaData metadata = answer.getMetaData();

			//number of columns in the result. 
			int numColumns = metadata.getColumnCount();

			//create arraylist of arraylist with initial capacity of numColumns
			table = new ArrayList<ArrayList<Object>>(numColumns);

			//for all columns in the result set, add a new arraylist with the values in that column. 	
			for (int i=1; i<=numColumns;i++){

				// add a new list for each column 
				table.add(new ArrayList<Object>());
				table.get(i-1).add(metadata.getColumnName(i));

				while(answer.next()){

					//table.get(i-1) will contain column i from the resultSet,
					//because sql column starts at 1, arraylist starts at 0.
					table.get(i-1).add(answer.getObject(i));
				}
			
				//set the cursor to the top of the rows. 	
				answer.beforeFirst();
			}

        } catch (SQLException e) {

                System.err.println("*** SQLException: Could not fetch query results.");
                System.err.println("Message:   " + e.getMessage());
                System.err.println("SQLState:  " + e.getSQLState());
                System.err.println("ErrorCode: " + e.getErrorCode());
                System.exit(-1);

        }

		return table;
	}
}
