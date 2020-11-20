<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="test" begin="1" end="10" step="2">
 <b>${test }</b>&nbsp;
</c:forEach>
<br>
<c:forTokens var="alphabet" items="a,b,c,d,e,f,g,h,i,j,k,l,m,n" delims=",">
<b>${alphabet }</b>&nbsp;
</c:forTokens>
<br>
<c:set var="data" value="이동준;정대윤;송상엽"></c:set>
<c:forTokens var="vardata" items="${data}" delims=";">
<b>${vardata }</b>&nbsp;
</c:forTokens>
<%
ArrayList<String> list = new ArrayList<String>();
list.add("mbc");
list.add("kbs");
list.add("sbs");
request.setAttribute("list", list);
%>
<br>
<c:forEach var="name" items="${list}">
 <b> <c:out value="${name}"></c:out></b><br>
</c:forEach>
</body>
</html>