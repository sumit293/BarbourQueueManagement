<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbcon.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h1>This is background jsp page </h1>
<%
try{
	String aid = request.getParameter("aid");
	
	Connection con = ConnectDB.getConnect();
	
	String sql ="update appointment set  status ='Approved' where aid =?";
	PreparedStatement ps1 = con.prepareStatement(sql);
	ps1.setString(1, aid);
	
	int i =  ps1.executeUpdate();
	if (i>0)
	{
		System.out.println("YES THE STATUS IS APPROVED ");
		response.sendRedirect("manageAppointment.jsp");
		
	}
	else
	{
		System.out.println("THERE IS SOMETHING ERROR ");
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