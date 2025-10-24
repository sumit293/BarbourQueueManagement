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
<%
try{
	
	String bid = request.getParameter("bid");
Connection con = ConnectDB.getConnect();


String  sql = "delete from barber where bid=?";
PreparedStatement ps1 = con.prepareStatement(sql);
ps1.setString(1, bid);

int i = ps1.executeUpdate();

if (i > 0)
{
	System.out.println("THE ITEM IS DELETED SUCCESSFULLY ! ");
	response.sendRedirect("manageBarber.jsp");
}

else { 
	
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