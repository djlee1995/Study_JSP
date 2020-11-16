
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(request.getParameter("id")==null||request.getParameter("id")==""){
	out.print("<script>");
	out.print("location.href='sessionLogin.jsp'");
	out.print("</script>");
}
else
	session.setAttribute("id", request.getParameter("id")); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<h3>로그인 되었습니다.</h3>
<h3>로그인 아이디: <%=(String)session.getAttribute("id")%></h3>
<a href="sessionLogout.jsp">로그아웃 페이지로 이동</a>
</center>
</body>
</html>