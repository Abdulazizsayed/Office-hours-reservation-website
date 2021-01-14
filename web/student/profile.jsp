<%@page import="java.sql.ResultSet"%>
<%@page import="com.database.Queries"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.database.DatabaseConnection"%>
<%@include file="../isLoggedIn.jsp" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try {
    DatabaseConnection dbConnection = new DatabaseConnection();
    Connection con = dbConnection.connect();
    Queries q = new Queries(con, "users");
    ResultSet res = q.select("*", "id = " + session.getAttribute("id"));

    if (!res.next()) {
        response.sendRedirect("failure.jsp?page=logout.jsp&reason=Error-in-the-system,-please-login-again");
    }
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Profile</title>
    </head>
    <body>
        <center>
            
        </center>
    </body>
</html>
