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
    String id = request.getParameter("id");
    
    Queries q = new Queries(con, "users");
    ResultSet user = q.select("*", "id = " + id);
    
    Queries q1 = new Queries(con, "messages");
    ResultSet messages = q1.select("*", "`from` in (" + session.getAttribute("id") + ", " + id + ") OR `to` in (" + session.getAttribute("id") + ", " + id + ") order by id desc");
    
    ResultSet office_hours = null;
    String dayString = "Sun,Mon,Tue,Wen,Thu,Fri,Sat";
    String[] days = dayString.split(",");
    if (user.next()) {
        Queries q2 = new Queries(con, "office_hours");
        office_hours = q2.select("*", "instructor_id = " + id);
    } else {
        response.sendRedirect("failure.jsp?page=index.jsp&reason=User-didn't-found");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - User</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title"><%=user.getString("username")%></h2>
            <p><b>Name: </b><%=user.getString("name")%></p><br>
            <p><b>Contact </b><%=user.getString("email")%></p><br>
            <%
                if (!user.getString("role").equals("0")) {
            %>
            <h3 class="side-title">Office hours</h3>
            <table border="1">
                <tr> 
                    <th>From</th> 
                    <th>To</th> 
                    <th>Day</th>
                    <th>Reserve</th>
                </tr>
                <%
                    while (office_hours.next()) {%>
                <tr>
                    <td><%=office_hours.getString("from")%></td>
                    <td><%=office_hours.getString("to")%></td>
                    <td><%=days[office_hours.getInt("day") - 1]%></td>
                    <td>
                        <button>
                            <a href="reserve.jsp?id=<%=office_hours.getString("id")%>">Reserve</a>
                        </button>
                    </td>
                </tr>
                <%}%>
            </table>
            <%
                }
            %>
            <h3 class="side-title">Messages</h3>
                <%
                    if (messages.next()) {
                        if (messages.getString("from").equals(session.getAttribute("id"))) {
                            out.println(session.getAttribute("username") + ": " + messages.getString("content") + "<br>");
                        } else {
                            out.println(user.getString("username") + ": " + messages.getString("content") + "<br>");
                        }
                        
                        while(messages.next()) {
                            if (messages.getString("from").equals(session.getAttribute("id"))) {
                                out.println(session.getAttribute("username") + ": " + messages.getString("content") + "<br>");
                            } else {
                                out.println(user.getString("username") + ": " + messages.getString("content") + "<br>");
                            }
                        }
                    } else {
                        out.println("<b>This conversation have no messages yet</b><br>");
                    }
                %>
                
                
            <input id="message" name="message" required /><label id="sent"></label>
            <input id="to" name="to" value="<%=user.getString("id")%>" hidden/>
            <input id="to-name" name="toName" value="<%=user.getString("username")%>" hidden/>
            <button id="submitBtn">Send</button><br>
                
            <a href="home.jsp">Back to home</a>
            
        </div>
    </body>
    <script src="javascript/custom.js"></script> <!-- Possible error -->
    <script>
        let to = document.getElementById("to").value;
        let toName = document.getElementById("to-name").value;
        let content = document.getElementById("message");
        let label = document.getElementById("sent");
        sendMessageToUser(to, toName, content, label);
    </script>
</html>
<%

} catch (Exception ex) {
    ex.printStackTrace();
}
%>

