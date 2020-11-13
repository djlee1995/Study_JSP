<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="join" class="test.JoinBean"></jsp:useBean>
<jsp:setProperty property="*" name="join"/>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<table border="1">
	<tr>
		<td bgcolor="yellow"><font size="2">아이디:</font></td>
		<td bgcolor="yellow"><jsp:getProperty name="join" property="id" /></td>
	</tr>
	<tr>
		<td bgcolor="yellow"><font size="2">비밀번호:</font></td>
		<td bgcolor="yellow"><jsp:getProperty name="join" property="pass"/></td>
	</tr>
	<tr>
		<td bgcolor="yellow"><font size="2">이름:</font></td>
		<td bgcolor="yellow"><jsp:getProperty name="join" property="name"/></td>
	</tr>
	<tr>
		<td bgcolor="yellow"><font size="2">성별:</font></td>
		<td bgcolor="yellow"><%=join.gender()%></td>
	</tr>
	<tr>
		<td bgcolor="yellow"><font size="2">나이:</font></td>
		<td bgcolor="yellow"><jsp:getProperty name="join" property="age"/></td>
	</tr>
	<tr>
		<td bgcolor="yellow"><font size="2">이메일주소:</font></td>
		<td bgcolor="yellow"><jsp:getProperty name="join" property="email"/></td>
	</tr>

</table>
</center>
</body>
</html>