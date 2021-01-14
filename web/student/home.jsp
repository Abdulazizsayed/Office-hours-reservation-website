<%@include file="../includes/isLoggedIn.jsp" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/style.css">
        <title>Reservation - Home</title>
    </head>
    <body>
        <div class="container">
                <a class="profile" href="../profile.jsp">Profile</a>
                <a class="logout" href="../logout">Logout</a>
            <center>
                <div class="home-links">
                    <h1>Hello <%=session.getAttribute("name")%></h1>
                    <a href="../subjects.jsp">My subjects</a>
                    <a href="#">Test</a>
                    <a href="#">Test</a>
                    <a href="#">Test</a>
                    <a href="#">Test</a>
                </div>
            </center>
        </div>
    </body>
</html>
