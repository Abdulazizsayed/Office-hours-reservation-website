<%@page import="java.sql.ResultSet"%>
<%@page import="com.database.Queries"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.database.DatabaseConnection"%>
<%@include file="includes/isLoggedIn.jsp" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try {
    DatabaseConnection dbConnection = new DatabaseConnection();
    Connection con = dbConnection.connect();
    Queries q = new Queries(con, "user_subject");
    ResultSet res = q.selectWithMultipleTables("subjects.id, name", "user_id = " + session.getAttribute("id") + " AND subject_id = subjects.id", "subjects");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Subjects</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Your subjects</h2>
            <ol>
                <%
                    if (res.next()) {
                        out.println("<li><a href='subject.jsp?id=" + res.getString("id") + "&name=" + res.getString("name") + "'>" + res.getString("name") + "</a></li>");
                        while (res.next()) {
                            out.println("<li><a href='subject.jsp?id=" + res.getString("id") + "&name=" + res.getString("name") + "'>" + res.getString("name") + "</a></li>");
                        }
                    } else {
                        out.println("<b>You have no subjects</b>");
                    }
                %>
            </ol>
                <%
                    if (res.getInt("role") == 0) {
                        %><a href="student/home.jsp">Back to home</a><%
                    } else {
                        %><a href="instructor/home.jsp">Back to home</a><%
                    }
                %>
        </div>
    </body>
</html>
    <%
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>

