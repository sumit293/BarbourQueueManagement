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
 * Servlet implementation class CustomerRegister
 */
@WebServlet("/CustomerRegister")
public class CustomerRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerRegister() {
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
		
		String cname = request.getParameter("cname");
		String cemail = request.getParameter("cemail");
		String cphone = request.getParameter("cphone");
		String cpassword = request.getParameter("cpassword");
		
		try {
			int id = 0;
			 Connection con = ConnectDB.getConnect();
			 String CRegister = "insert into customer(cname, cemail, cphone, cpassword) values(?, ?, ?, ?)";
			 PreparedStatement ps1 =  con.prepareStatement(CRegister);
			 ps1.setString(1, cname);
			 ps1.setString(2, cemail);
			 ps1.setString(3, cphone);
			 ps1.setString(4, cpassword);
			 
			 
			 int rs = ps1.executeUpdate();
			 
			 if(rs > 0)
			 {
				 System.out.println("THE CUSTOMER  IS REGISTERRED SUCCESSFULLY !");
				 response.sendRedirect("customerLogin.html");
				 
			 }
			 else
			 {
				 System.out.println("there  is smething wrong ");
				 response.sendRedirect("customerRegister.html");
			 }
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
