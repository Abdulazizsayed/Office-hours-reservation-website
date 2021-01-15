<%
if (session.getAttribute("id") == null) {
    response.sendRedirect("index.jsp");
}
%>
