<%--
  Created by IntelliJ IDEA.
  User: sowmya
  Date: 1/7/17
  Time: 6:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>logout</title>
</head>
<body>
<%
    session.setAttribute("userid", null);
    session.invalidate();
    response.sendRedirect("Home.jsp");
%>
</body>
</html>
