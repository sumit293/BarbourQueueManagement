<%@page import="dbcon.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
	String cid  = request.getParameter("cid");
	Connection con = ConnectDB.getConnect();
	
	//////////////////////
	
	 String delAppt = "DELETE FROM appointment WHERE cid=?";
    PreparedStatement psAppt = con.prepareStatement(delAppt);
    psAppt.setString(1, cid);
    psAppt.executeUpdate();

	///////////////////////////////
	
	
	String sql = "delete from customer where cid=?";
	
	PreparedStatement ps1 = con.prepareStatement(sql);
	ps1.setString(1, cid);
	
	int i  = ps1.executeUpdate();
	
	
	if (i > 0){
		
		System.out.println("THE CUSTOMER IS DELETES SUCESSFULLY !");
		
		response.sendRedirect("manageCustomer.jsp");
		
	}
	
	else
	{
		
		System.out.println("THERE IS SOMETHING ERROR ! ");
		response.sendRedirect("error.html");
		
	}
	
}
catch(Exception e)
{
	e.printStackTrace();
}

 %>
</body>
</html>