package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.ConnectDB;
import pojo.CustomerPojo;

/**
 * Servlet implementation class BarberLogin
 */
@WebServlet("/BarberLogin")
public class BarberLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BarberLogin() {
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
		
		String bemail = request.getParameter("bemail");
		String bpassword = request.getParameter("bpassword");
		 
		Connection con = ConnectDB.getConnect();
		
		
		try {
			String login = "select * from barber where  bemail =? and bpassword=?";
			PreparedStatement ps1 = con.prepareStatement(login);
			
			ps1.setString(1, bemail);
			ps1.setString(2, bpassword);
			
			ResultSet rs = ps1.executeQuery();
			
			if(rs.next())
			{
				CustomerPojo.setCemail(bemail);
				
				CustomerPojo.setCpassword(bpassword);
				
				response.sendRedirect("barberdashboard.html");
			}
			
			else
			{
				System.out.println("error.html");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
