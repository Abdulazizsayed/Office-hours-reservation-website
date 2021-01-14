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
    String sub_id = request.getParameter("id");
    String sub_name = request.getParameter("name");
    Queries q = new Queries(con, "user_subject");
    ResultSet staff = q.selectWithMultipleTables("users.*", "subject_id = " + sub_id + " AND user_id = users.id AND role IN (1,2)", "users");
    ResultSet students = q.selectWithMultipleTables("users.*", "subject_id = " + sub_id + " AND user_id = users.id AND role = 0", "users");
    
    Queries q1 = new Queries(con, "subject_messages");
    ResultSet messages = q1.selectWithMultipleTables("message.*, users.*", "to = " + sub_id + " AND from = users.id", "users");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Profile</title>
    </head>
    <body>
        <div class="container">
            <h2 class="title"><%=sub_name%></h2>
            <h3 class="side-title">Staff members</h3>
            <ol>
                <%
                    if (staff.next()) {
                        if (!staff.getString("id").equals(session.getAttribute("id"))) {
                            out.println("<li><a href='staffMember.jsp?id=" + staff.getString("users.id") + "'>" + staff.getString("users.name") + "</a></li>");
                        }
                        while(staff.next()) {
                            if (staff.getString("id").equals(session.getAttribute("id"))) {
                                continue;
                            }
                            out.println("<li><a href='staffMember.jsp?id=" + staff.getString("users.id") + "'>" + staff.getString("users.name") + "</a></li>");
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
                        if (staff.getString("id").equals(session.getAttribute("id"))) {
                            out.println("<li><a href='student.jsp?id=" + students.getString("users.id") + "'>" + students.getString("users.name") + "</a></li>");
                        }
                        while(students.next()) {
                            if (staff.getString("id").equals(session.getAttribute("id"))) {
                                continue;
                            }
                            out.println("<li><a href='student.jsp?id=" + students.getString("users.id") + "'>" + students.getString("users.name") + "</a></li>");
                        }
                    } else {
                        out.println("<b>This subject have no students yet</b>");
                    }
                %>
            </ol>
        </div>
    </body>
</html>
    <%
    
} catch (Exception ex) {
    ex.printStackTrace();
}
%>

