package services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import dbcon.ConnectDB;
import java.sql.*;
/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		String aemamil = request.getParameter("aemail");
		String apassword = request.getParameter("apassword");
		
	Connection con = ConnectDB.getConnect();
	
	try {
		String q1 = "SELECT * FROM admin WHERE  aemail = ? and apassword = ? ";
		PreparedStatement ps1 = con.prepareStatement(q1);
		ps1.setString(1, aemamil);
		ps1.setString(2, apassword);
		ResultSet rs = ps1.executeQuery();
		
		if(rs.next()){
			response.sendRedirect("admindashboard.html");
			//remain to make admindashboard and sql workbench :)
		}
		else{
			response.sendRedirect("error.html");
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
		
		
		
		
	}

}
