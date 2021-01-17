<%@include file="isLoggedOut.jsp" %>
<html>
    <head>
        <title>Reservation | Sign up</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/signDesign.css">
    </head>
    <body>
        <div class = "form">
            <form action="signup" method="POST">
                <label class = "signlbl">Sign Up</label><br>
                <label class = "usrlbls" for="username">Username: </label>
                <input id="usernames" name="username" minlength="3" maxlength="20" required /><label id="usernameError"></label>
                <br>
                <label class = "emaillbl" for="email">Email:  </label>
                <input id="email" name="email" type="email" required /><label id="emailError"></label>
                <br>
                <label class = "role ">Role:  </label>
                <select  class = "dropmenu" name="role">
                    <option value="0">Student</option>
                    <option value="1">TA</option>
                    <option value="2">Doctor</option>
                </select>
                <br>
                <input id="submitBtn" type="submit" value="Sign up" />
            </form>
            <div class = "hamesh1"></div>
            <label id = "or">OR</label>
            <div class = "hamesh2"></div>
            <span id = "signuplink"><a href="index.jsp">sign In</a></span>
        </div>
    </body>
    <script src="javascript/custom.js"></script> <!-- Possible error -->
    <script>
        signup();
    </script>
</html>
