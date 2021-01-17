<%@include file="isLoggedOut.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation - login</title>
        <link rel="stylesheet" href="css/signDesign.css">
    </head>
    <body>
        <div class = "form">
            <form action="validate" method="POST">
                <label class = "loglbl">Log In</label><br>
                <label class = "usrlbl" for="username">Username </label><br>
                <input id="username" name="username" minlength="3" maxlength="20" required /> <br><label id="usernameError"></label>
                <br>
                <label class = "psslbl" for="password">Password </label><br>
                <input id="password" name="password" type="password"  minlength="3" maxlength="100" required />
                <br>
                <button id="submitBtn" type="submit">Login</button>
            </form>
            <div class = "hamesh1"></div>
            <label id = "or">OR</label>
            <div class = "hamesh2"></div>
            <span id = "signuplink"><a href="signup.jsp">sign up</a></span>
        </div>
        
    </body>
    <script src="javascript/custom.js"></script> <!-- Possible error -->
    <script>
        login();
    </script>
</html>
