<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>쿠키, URL/URI, 요청방식에 관련된 정보 예제</h1>
<table border="1">
	<tr>
		<td>쿠키정보</td>
<%
Cookie[] cookie = request.getCookies();
if(cookie==null){
%>
		<td>쿠키가 존재하지 않습니다.</td>
<%
} else{
	for(int i=0; i<cookie.length; i++){
	%>
	<td><%=cookie[i].getName()%>(<%=cookie[i].getValue() %>)
	&nbsp;&nbsp;</td>
	<% 
	}
}%>
	</tr>
	<tr>
		<td>서버 도메인명</td>
		<td><%=request.getServerName() %></td>
	</tr>
	<tr>
		<td>서버 포트번호</td>
		<td><%=request.getServerPort() %></td>
	</tr>
	<tr>
		<td>요청URL</td>
		<td><%=request.getRequestURI() %></td>
	</tr>
	<tr>
		<td>요청쿼리</td>
		<td><%=request.getQueryString() %></td>
	</tr>
	<tr>
		<td>클라이언트 호스트명</td>
		<td><%=request.getRemoteHost() %></td>
	</tr>
	<tr>
		<td>클라이언트 IP주소</td>
		<td><%=request.getRemoteAddr() %></td>
	</tr>
	<tr>
		<td>프로토콜</td>
		<td><%=request.getProtocol() %></td>
	</tr>
	<tr>
		<td>요청방식</td>
		<td><%=request.getRequestURI() %></td>
	</tr>
	<tr>
		<td>컨텍스트 경로</td>
		<td><%=request.getContextPath() %></td>
	</tr>
	
	
			
</table>
</body>
</html>