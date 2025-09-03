package dbcon;

import java.sql.*;





public class ConnectDB 
{

	
	
	
	static Connection con = null;
	public static Connection getConnect()
	{
		
		try 
		{
			
//			Class.forName("com.mysql.jdbc.Driver");
			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/barbourdb","root","Sumit@1947");
			System.out.println("CONNECTION SUCCESSFULL, con = "+con);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	
	
}
