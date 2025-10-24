<%@page import="pojo.ServicesPojo"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="pojo.CustomerPojo"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dbcon.ConnectDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add apponitment</title>
</head>
<body>
<%

try{
	//String sid = request.getParameter("sid");
	
	
	 String sidStr = request.getParameter("sid");  // always String from request
	    int sid = Integer.parseInt(sidStr);           // convert to int

	    ServicesPojo.setsid(sid); 
	
	
	
		Connection con = ConnectDB.getConnect();
		int cid = CustomerPojo.getCid();
		String  sql = "insert into appointment(cid, sid, status) values(?, ?, ?)";
		
		PreparedStatement ps1 = con.prepareStatement(sql);
		ps1.setInt(1,cid);
		ps1.setInt(2, sid);
		ps1.setString(3, "in_progress");
		
		
		int rs = ps1.executeUpdate();
		 if(rs > 0)
		 {
			 System.out.println("sucess the sppointment ");
			 response.sendRedirect("bookApointment.jsp");
			 
		 }
		 else
		 {
			 System.out.println("there  is smething wrong ");
			 response.sendRedirect("error.html");
		 }
		
	
}

catch(Exception e){
	e.printStackTrace();
	
}
%>

</body>
</html>