<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="isLoggedIn.jsp" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="3;<%=request.getParameter("page")%>">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Failure</title>
    </head>
    <body>
        <center>
            <h1>Failed operation!</h1>
            <img src="images/fail.png" width="500px">
            <p>
            <%
                if (request.getParameter("reason") != null) {
                    out.print(String.join(" ", request.getParameter("reason").split("-")));
                }
            %>
            </p>
        </center>
    </body>
</html>
