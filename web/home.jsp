<%@include file="isLoggedIn.jsp" %>  
<%@page import="java.sql.ResultSet"%>
<%@page import="com.database.Queries"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.database.DatabaseConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try {
    DatabaseConnection dbConnection = new DatabaseConnection();
    Connection con = dbConnection.connect();
    Queries q = new Queries(con, "notifications");
    ResultSet res = q.select("*", "`from` = " + session.getAttribute("id") + " OR `to` = " + session.getAttribute("id") + " order by id desc");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Reservation - Home</title>
    </head>
    <body>
        <div class="container">
                <a class="profile" href="profile.jsp">Profile</a>
                <a class="logout" href="logout">Logout</a>
            <center>
                <div class="home-links">
                    <h1>Hello <%=session.getAttribute("username")%></h1>
                    <a href="subjects.jsp">My subjects</a>
                    <a href="reservations.jsp">My Reservations</a>
                    <%
                    if (!session.getAttribute("role").equals("0")) {
                        out.println("<a href='officeHours.jsp'>My office hours</a>");
                    }
                    %>
                    <form action="searchUser.jsp" method="POST">
                        <label for="username">Enter username: </label>
                        <input id="username" name="username" required />
                        <br>
                        <button id="submitBtn" type="submit">Search</button>
                    </form>
                    
                    <h2>Notifications</h2>
                    <ol>
                        <%
                            while (res.next()) {
                                out.print("<li> <a href='" + res.getString("link") + "'>" + res.getString("content") + "</a></li>");
                            }
                        %>
                    </ol>
                </div>
            </center>
        </div>
    </body>
</html>
<%
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>