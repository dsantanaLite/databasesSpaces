package dbController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

/**
 * Servlet implementation class for Servlet: DatabaseController
 *
 */
public class DatabaseController {
  static final long serialVersionUID = 1L;
  /**
   * A handle to the connection to the DBMS.
   */
  protected Connection connection_;
  /**
   * A handle to the statement.
   */
  protected Statement statement_;
  /**
   * The connect string to specify the location of DBMS
   */
  protected String connect_string_ = null;
  /**
   * The password that is used to connect to the DBMS.
   */
  protected String password = null;
  /**
   * The username that is used to connect to the DBMS.
   */
  protected String username = null;


  public DatabaseController() {
    // your cs login name
    username = "dsantana"; 
    // your Oracle password, NNNN is the last four digits of your CSID
    password = "silence";
    connect_string_ = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
  }


  /**
   * Closes the DBMS connection that was opened by the open call.
   */
  public void Close() {
    try {
      statement_.close();
      connection_.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    connection_ = null;
  }


  /**
   * Commits all update operations made to the dbms.
   * If auto-commit is on, which is by default, it is not necessary to call
   * this method.
   */
  public void Commit() {
    try {
      if (connection_ != null && !connection_.isClosed())
        connection_.commit();
    } catch (SQLException e) {
      System.err.println("Commit failed");
      e.printStackTrace();
    }
  }

    public void Open() {
	try {
	    Class.forName("oracle.jdbc.OracleDriver");
	    connection_ = DriverManager.getConnection(connect_string_, username, password);
	    statement_ = connection_.createStatement();
	    return;
	} catch (SQLException sqlex) {
	    sqlex.printStackTrace();
	} catch (ClassNotFoundException e) {
	    e.printStackTrace();
	    System.exit(1); //programemer/dbsm error
	} catch (Exception ex) {
	    ex.printStackTrace();
	    System.exit(2);
	}
    }


	public ArrayList<ArrayList<Object>> getQueryAsLists (){

		ArrayList<ArrayList<Object>> table = null;

		ResultSet answer = null;

		String query = "select CNTLOCID, ROUTE, DIST "+
						"from "+
							"(select CNTLOCID, ROUTE, DIST, RANK() OVER (ORDER BY DIST DESC) as RANK "+
							"from "+
								"(select CNTLOCID, ROUTE,  EMP-BMP as DIST "+ 
								"from dsantana.adot2012 "+ 
								"where EMP IS NOT NULL and BMP IS NOT NULL)) "+
						"where RANK<6";

        try {

			//execute query provided by user in the argument
	        answer = statement_.executeQuery(query);

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
		System.out.println(table.get(0).get(0));

		return table;
	}
}
