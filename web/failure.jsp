<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="3;<%=request.getParameter("page")%>">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation - Failure</title>
    </head>
    <body>
        <h1>Failed operation!</h1>
        <p>
        <%
            if (request.getParameter("reason") != null) {
                out.print(String.join(" ", request.getParameter("reason").split("-")));
            }
        %>
        </p>
    </body>
</html>
