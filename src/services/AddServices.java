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
 * Servlet implementation class AddServices
 */
@WebServlet("/AddServices")
public class AddServices extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddServices() {
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
		int bid  =  0;
		
			String sname = request.getParameter("sname");
			String sdesc = request.getParameter("sdesc");
			String sprice= request.getParameter("sprice");
			
			try {
				Connection con   =ConnectDB.getConnect();
				String services = "insert into services(sname, sdesc, sprice) values(?, ?, ?)";
				PreparedStatement ps1 = con.prepareStatement(services);
				
				ps1.setString(1, sname);
				ps1.setString(2, sdesc);
				ps1.setString(3, sprice);
				
				int rs = ps1.executeUpdate();
				
				if(rs > 0){
					System.out.println("THIS SERVICE IS ADDED SUCCSSFULLY");
					response.sendRedirect("barberdashboard.html");
					
				}
				else
				{
					System.out.println("There is somethoiong error in  it ");
					response.sendRedirect("error.html");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
	}

}
