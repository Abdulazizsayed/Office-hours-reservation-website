<%@include file="isLoggedOut.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation - login</title>
    </head>
    <body>
        <form action="validate" method="POST">
            <label for="username">Username: </label>
            <input id="username" name="username" minlength="3" maxlength="20" required /> <label id="usernameError"></label>
            <br>
            <label for="password">Password: </label>
            <input id="password" name="password" type="password"  minlength="3" maxlength="100" required />
            <br>
            <button id="submitBtn" type="submit">Login</button>
        </form>
        <a href="signup.jsp">Or sign up</a>
    </body>
    <script src="javascript/custom.js"></script> <!-- Possible error -->
    <script>
        login();
    </script>
</html>
