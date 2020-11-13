<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<%
   String id = (String)session.getAttribute("id");
System.out.println("id2=" + id);
%>
<body>
<%
   if(id == null){
%>   
   <a href="login.jsp" target="rightFrame"/>로그인</a>
<%
   }else{
%>         
   <%=id  %> 님 환영합니다.
<%
   }
%>
</body>
</html>