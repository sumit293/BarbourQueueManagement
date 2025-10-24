<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbcon.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Services </title>
</head>
<body>
<%

try { 
	

String sid = request.getParameter("sid");
Connection con = ConnectDB.getConnect();


String  sql = "delete from services where sid=?";
PreparedStatement ps1 = con.prepareStatement(sql);
ps1.setString(1, sid);

int i = ps1.executeUpdate();


if (i > 0)
{
	System.out.println("THE ITEM IS DELETED SUCCESSFULLY ! ");
	response.sendRedirect("ManageServices.jsp");
}

else { 
	
	response.sendRedirect("error.html");
	
}
%>

<%
}
catch(Exception e)
{
e.printStackTrace();

}
%>
</body>
</html>