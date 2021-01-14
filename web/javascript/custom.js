let submitBtn = document.getElementById("submitBtn");
let usernameEl = document.getElementById("username") || "";
let emailEl = document.getElementById("email") || "";

function sendMessageToSubject (to, toName, content, label) {
    submitBtn.addEventListener("click", function(){
        let xml = new XMLHttpRequest();
        xml.open("GET", "sendMessageToSubject?content=" + content.value + "&to=" + to + "&toName=" + toName, true);
        xml.send();
        xml.onreadystatechange = function () {
            if (xml.readyState == 4 && xml.status == 200) {
                let res = xml.responseText.toString();
                if (res.trim()) {
                    label.innerHTML = "Sent";
                } else {
                    label.innerHTML = "Message not sent! try again";
                }
                return false;
            }
        };
    });
}

function login () {
    usernameEl.onblur = function () {
        let errorLabel = document.getElementById("usernameError");
        let usernameText = usernameEl.value;
        checkUsernameForLogin(usernameText, errorLabel);
    }
}

function signup () {
    usernameEl.onblur = function () {
        let errorLabel = document.getElementById("usernameError");
        let usernameText = usernameEl.value;
        checkUsernameForSignup(usernameText, errorLabel);
    }
    
    emailEl.onblur = function () {
        let errorLabel = document.getElementById("emailError");
        let emailText = emailEl.value;
        checkEmail(emailText, errorLabel);
    }
}

function checkUsernameForLogin (username, errorLabel) {
    let xml = new XMLHttpRequest();
    xml.open("GET", "checkUsername?username=" + username, true);
    xml.send();
    xml.onreadystatechange = function () {
        if (xml.readyState == 4 && xml.status == 200) {
            let res = xml.responseText.toString();
            if (res.trim()) {
                submitBtn.disabled = false;
                errorLabel.innerHTML = "";
            } else {
                submitBtn.disabled = true;
                errorLabel.innerHTML = "Username not found!";
            }
            return false;
        }
    };
}

function checkUsernameForSignup (username, errorLabel) {
    let xml = new XMLHttpRequest();
    xml.open("GET", "checkUsername?username=" + username, true);
    xml.send();
    xml.onreadystatechange = function () {
        if (xml.readyState == 4 && xml.status == 200) {
            let res = xml.responseText.toString();
            if (res.trim()) {
                submitBtn.disabled = true;
                errorLabel.innerHTML = "Username used before!";
            } else {
                submitBtn.disabled = false;
                errorLabel.innerHTML = "";
            }
            return false;
        }
    };
}

function checkEmail (email, errorLabel) {
    let xml = new XMLHttpRequest();
    xml.open("GET", "checkEmail?email=" + email, true);
    xml.send();
    xml.onreadystatechange = function () {
        if (xml.readyState == 4 && xml.status == 200) {
            let res = xml.responseText.toString();
            if (res.trim()) {
                submitBtn.disabled = true;
                errorLabel.innerHTML = "Email used before!";
            } else {
                submitBtn.disabled = false;
                errorLabel.innerHTML = "";
            }
            return false;
        }
    };
}
