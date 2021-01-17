<%@page import="java.sql.ResultSet"%>
<%@page import="com.database.Queries"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.database.DatabaseConnection"%>
<%@include file="isLoggedIn.jsp" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try {
    DatabaseConnection dbConnection = new DatabaseConnection();
    Connection con = dbConnection.connect();
    Queries q = new Queries(con, "users");
    ResultSet res = q.select("*", "username LIKE '%" + request.getParameter("username") + "%'");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Reservation - Search results for users</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Users: </h2>
            <%
                while (res.next()) {
                    %>
                    <ul>
                        <li>Username: <%=res.getString("username")%></li>
                        <li>Email: <%=res.getString("email")%></li>
                    </ul>
                    <%
                }
            %>
            <a href="home.jsp">Back to home</a>
        </div>
    </body>
</html>
    <%
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>

