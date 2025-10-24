package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.ConnectDB;

/**
 * Servlet implementation class BarberRegister
 */
@WebServlet("/BarberRegister")
public class BarberRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BarberRegister() {
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
		
		String bname = request.getParameter("bname");
		String bemail = request.getParameter("bemail");
		String  bphone = request.getParameter("bphone");
		String bshop = request.getParameter("bshop");
		String bpassword = request.getParameter("bpassword");
		
		try {
			int bid = 0;
			Connection con = ConnectDB.getConnect();
			
			String BRegister = "insert into barber(bname, bemail, bphone, bpassword, bshop) values(?, ?, ?, ?, ?)";
			PreparedStatement ps1 = con.prepareStatement(BRegister);
			
			ps1.setString(1, bname);
			ps1.setString(2, bemail);
			ps1.setString(3, bphone);
			ps1.setString(4, bpassword);
			ps1.setString(5, bshop);
			
			int rs = ps1.executeUpdate();
			 if(rs > 0)
			 {
				 System.out.println("THE BARBER  IS REGISTERRED SUCCESSFULLY !");
				 response.sendRedirect("barberLogin.html");
				 
			 }
			 else
			 {
				 System.out.println("there  is smething wrong ");
				 response.sendRedirect("error.html");
			 }
			
			
		} catch (Exception e) {
		
			
		e.printStackTrace();
		}
	}

}
