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
    ResultSet office_hours = q.select("*", "instructor_id=" + session.getAttribute("id"));
    String dayString = "Sun,Mon,Tue,Wen,Thu,Fri,Sat";
    String[] days = dayString.split(",");
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet">
        <title>Reservation - Office hours</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title">Your subjects</h2>
            <table border="1">
                <tr> 
                    <th>From</th> 
                    <th>To</th> 
                    <th>Day</th>
                    <th>Operations</th>
                </tr>
                <%
                    while (office_hours.next()) {%>
                <tr>
                    <td><%=office_hours.getString("from")%></td>
                    <td><%=office_hours.getString("to")%></td>
                    <td><%=days[office_hours.getInt("day") - 1]%></td>
                    <td>
                        <button>
                            <a href="editSlot.jsp?id=<%=office_hours.getString("id")%>">Edit</a>
                        </button>
                        <button>
                            <a href="deleteSlot?id=<%=office_hours.getString("id")%>">Delete</a>
                        </button>
                        <button>
                            <a href="slotReservations?id=<%=office_hours.getString("id")%>">View Reservations</a>
                        </button>
                    </td>
                </tr>
                <%}%>
            </table><br><br>
            <b>Cancel reservations of specific day: </b><br><br>
            <form action="cancelSpecific" method="POST">
                <label>Enter day: </label>
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
                <button id="submitBtn" type="submit">Cancel</button>
            </form><br><br>
            <button>
                <a href="addSlot.jsp">Add new slot</a>
            </button>
            <a href="home.jsp">Back to home</a>
        </div>
    </body>
</html>
    <%
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>

