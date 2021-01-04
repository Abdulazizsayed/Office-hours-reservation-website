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
            <input id="username" name="username" /><label id="usernameError"></label>
            <br>
            <label for="email">Email:  </label>
            <input id="email" name="email" type="email" /><label id="emailError"></label>
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
        <a href="index.html">Or sign in</a>
    </body>
    <script src="javascript/custom.js"></script>
    <script>
        signup();
    </script>
</html>
