<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Refresh" content="3;<%=request.getParameter("page")%>">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>Reservation - Success</title>
    </head>
    <body>
        <center>
            <h1>Successful operation!</h1>
            <img src="images/success.png" width="500px">
            <p>
            <%
                if (request.getParameter("content") != null) {
                    out.print(String.join(" ", request.getParameter("content").split("-")));
                }
            %>
            </p>
        </center>
    </body>
</html>
