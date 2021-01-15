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
    Queries q = new Queries(con, "office_hours");
    ResultSet res = q.select("*", "id = " + request.getParameter("id"));

    if (!res.next()) {
        
        response.sendRedirect("includes/failure.jsp?page=index.jsp&reason=Id-not-found,-you'll-be-redirected-to-home");
    }
    
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Reserve a slot</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Your profile</h2>
            <form class="edit-user-form" action="reserve" method="POST">
                <label>Date: </label><br>
                <input id="date" name="date" type="date" required/><br>
                <input name="id" value="<%=res.getString("id")%>" hidden/>
                <input id="submitBtn" type="submit" value="Confirm reservation" />
            </form>
                <%
                    if (session.getAttribute("role").equals("0")) {
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

