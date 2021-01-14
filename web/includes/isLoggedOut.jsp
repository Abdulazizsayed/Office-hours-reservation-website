<%
if (session.getAttribute("id") != null) {
    if (session.getAttribute("role").equals("0")) {
        response.sendRedirect("student/home.jsp");
    } else {
        response.sendRedirect("instructor/home.jsp");
    }
}
%>
