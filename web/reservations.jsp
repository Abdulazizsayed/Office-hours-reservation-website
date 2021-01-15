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
    Queries q = new Queries(con, "reservations");
    ResultSet res = null;
    
    res = q.selectWithMultipleTables("reservations.*, office_hours.*", "office_hour_id = office_hours.id AND (instructor_id = " + session.getAttribute("id") + " OR student_id=" + session.getAttribute("id") + ")", "office_hours");
    String dayString = "Sun,Mon,Tue,Wen,Thu,Fri,Sat";
    String[] days = dayString.split(",");
    
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Reservations</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Your meetings</h2>
            <table border="1">
                <tr> 
                    <th>From</th> 
                    <th>To</th> 
                    <th>Day</th>
                    <th>Date</th>
                    <th>Cancel</th>
                </tr>
                <%
                    while (res.next()) {
                        String toId = res.getString("instructor_id");
                        
                        Queries q1 = new Queries(con, "users");
                        ResultSet user = q1.select("email", "id=" + toId);
                        user.next();
                %>
                <tr>
                    <td><%=res.getString("from")%></td>
                    <td><%=res.getString("to")%></td>
                    <td><%=days[res.getInt("day") - 1]%></td>
                    <td><%=res.getString("date")%></td>
                    <td>
                        <button>
                            <a href="cancelReservation?id=<%=res.getString("reservations.id")%>&toId=<%=toId%>&toEmail=<%=user.getString("email")%>">Cancel</a>
                        </button>
                    </td>
                </tr>
                <%}%>
            </table>
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

