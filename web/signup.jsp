<%@include file="isLoggedOut.jsp" %>
<html>
    <head>
        <title>Reservation - Signup</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <form action="signup" method="POST">
            <label for="username">Username: </label>
            <input id="username" name="username" minlength="3" maxlength="20" required /><label id="usernameError"></label>
            <br>
            <label for="email">Email:  </label>
            <input id="email" name="email" type="email" required /><label id="emailError"></label>
            <br>
            <label>Role:  </label>
            <select name="role">
                <option value="0">Student</option>
                <option value="1">TA</option>
                <option value="2">Doctor</option>
            </select>
            <br>
            <input id="submitBtn" type="submit" value="Sign up" />
        </form>
        <a href="index.jsp">Or sign in</a>
    </body>
    <script src="javascript/custom.js"></script> <!-- Possible error -->
    <script>
        signup();
    </script>
</html>
