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
    Queries q = new Queries(con, "office_hours");
    ResultSet res = q.select("*", "id=" + request.getParameter("id"));
    
    if (!res.next()) {
        response.sendRedirect("failure.jsp?page=index.jsp&reason=Error-in-the-system!-Try-again-later");
    }
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Reservation - Edit office hour</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Your subjects</h2>
            <form action="editSlot" method="POST">
                <input name="id" value="<%=request.getParameter("id")%>" hidden>
                <label for="from">From: </label>
                <input id="from" name="from" type="time" value="<%=res.getString("from")%>" required/>
                <br>
                <label for="to">To: </label>
                <input id="to" name="to" type="time" value="<%=res.getString("to")%>" required/>
                <br>
                <label>Day: </label>
                <select name="day">
                    <option value="1">Sunday</option>
                    <option value="2">Monday</option>
                    <option value="3">Tuesday</option>
                    <option value="4">Wednesday</option>
                    <option value="5">Thursday</option>
                    <option value="6">Friday</option>
                    <option value="7">Saturday</option>
                </select>
                <br>
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

