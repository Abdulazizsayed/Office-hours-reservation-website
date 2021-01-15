<%@include file="isLoggedIn.jsp" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
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
                    <a href="#">Test</a>
                    <a href="#">Test</a>
                    <form action="searchUser.jsp" method="POST">
                        <label for="username">Enter username: </label>
                        <input id="username" name="username" minlength="3" maxlength="20" required />
                        <br>
                        <button id="submitBtn" type="submit">Search</button>
                    </form>
                </div>
            </center>
        </div>
    </body>
</html>
