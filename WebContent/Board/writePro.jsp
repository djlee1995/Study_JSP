<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDBBean" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	article.setReg_date(new Timestamp(System.currentTimeMillis()));

	BoardDBBean dbpro = BoardDBBean.getInstance();
	dbpro.insertArticle(article);
	
	response.sendRedirect("list.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>