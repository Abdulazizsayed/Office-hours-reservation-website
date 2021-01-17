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
    String sub_id = request.getParameter("id");
    String sub_name = request.getParameter("name");
    
    Queries q = new Queries(con, "user_subject");
    ResultSet staff = q.selectWithMultipleTables("users.*", "subject_id = " + sub_id + " AND user_id = users.id AND role IN (1,2)", "users");
    ResultSet students = q.selectWithMultipleTables("users.*", "subject_id = " + sub_id + " AND user_id = users.id AND role = 0", "users");
    
    Queries q1 = new Queries(con, "subject_messages");
    ResultSet messages = q1.selectWithMultipleTables("subject_messages.*, users.*", " `to` = " + sub_id + " AND `from` = users.id order by subject_messages.id desc", "users");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/profilecss.css" rel="stylesheet">
        <title>Reservation - Subject</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title"><%=sub_name%></h2>
            <h3 class="side-title">Staff members</h3>
            <ol>
                <%
                    if (staff.next()) {
                        if (!staff.getString("id").equals(session.getAttribute("id"))) {
                            out.println("<li><a href='member.jsp?id=" + staff.getString("users.id") + "'>" + staff.getString("users.username") + "</a></li>");
                        }
                        while(staff.next()) {
                            if (staff.getString("id").equals(session.getAttribute("id"))) {
                                continue;
                            }
                            out.println("<li><a href='member.jsp?id=" + staff.getString("users.id") + "'>" + staff.getString("users.username") + "</a></li>");
                        }
                    } else {
                        out.println("<b>This subject have no staff members yet</b>");
                    }
                %>
            </ol>
            <h3 class="side-title">Students</h3>
            <ol>
                <%
                    if (students.next()) {
                        if (!students.getString("id").equals(session.getAttribute("id"))) {
                            out.println("<li><a href='member.jsp?id=" + students.getString("users.id") + "'>" + students.getString("users.username") + "</a></li>");
                        }
                        while(students.next()) {
                            if (students.getString("id").equals(session.getAttribute("id"))) {
                                continue;
                            }
                            out.println("<li><a href='member.jsp?id=" + students.getString("users.id") + "'>" + students.getString("users.username") + "</a></li>");
                        }
                    } else {
                        out.println("<b>This subject have no students yet</b>");
                    }
                %>  
            </ol>
            <h3 class="side-title">Messages</h3>
                <%
                    if (session.getAttribute("role").equals("0")) {
                        if (messages.next()) {
                            if ((!messages.getString("role").equals("0") || messages.getString("users.id").equals(session.getAttribute("id")))) {
                                out.println(messages.getString("users.username") + ": " + messages.getString("subject_messages.content") + "<br>");
                            }
                            while(messages.next()) {
                                if ((!messages.getString("role").equals("0") || messages.getString("users.id").equals(session.getAttribute("id")))) {
                                    out.println(messages.getString("users.username") + ": " + messages.getString("subject_messages.content") + "<br>");
                                }
                            }
                        } else {
                            out.println("<b>This subject have no messages yet</b><br>");
                        }
                    } else {
                        if (messages.next()) {
                            
                            out.println(messages.getString("users.username") + ": " + messages.getString("subject_messages.content") + "<br>");
                            
                            while(messages.next()) {
                                out.println(messages.getString("users.username") + ": " + messages.getString("subject_messages.content") + "<br>");
                            }
                        } else {
                            out.println("<b>This subject have no messages yet</b><br>");
                        }
                    }
                %>
                
                
                    <input id="message" name="message" required /><label id="sent"></label>
                    <input id="to" name="to" value="<%=sub_id%>" hidden/>
                    <input id="to-name" name="toName" value="<%=sub_name%>" hidden/>
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
        sendMessageToSubject(to, toName, content, label);
    </script>
</html>
<%

} catch (Exception ex) {
    ex.printStackTrace();
}
%>

