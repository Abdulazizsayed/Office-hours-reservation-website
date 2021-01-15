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
    ResultSet res = q.select("*", "id = " + session.getAttribute("id"));

    if (!res.next()) {
        response.sendRedirect("failure.jsp?page=logout.jsp&reason=Error-in-the-system,-please-login-again");
    }
    
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/profilecss.css">
        <title>Reservation - Profile</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Your profile</h2>
            <form class="edit-user-form" action="editUser" method="POST">
                <label>Name: </label><br>
                <%
                    String name = "";
                    if (res.getString("name") != null) {
                        name = res.getString("name");
                    }
                %>
                <input name="name" value="<%=name%>" minlength="3" maxlength="50" required /><br>
                <label>Username: </label><br>
                <input value="<%=res.getString("username")%>" disabled/>
                <input name="username" value="<%=res.getString("username")%>" hidden/><br>
                <label>Password: </label><br>
                <input name="password" value="<%=res.getString("password")%>" minlength="3" maxlength="50" required /><br>
                <label>email </label><br>
                <input id="email" name="email" type="email" value="<%=res.getString("email")%>" required/><br>
                <input id="submitBtn" type="submit" value="Edit" />
            </form>
                <a href="home.jsp">Back to home</a>
        </div>
    </body>
</html>
    <%
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>

