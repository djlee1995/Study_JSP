<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table align="center" border="1" width="400">
		<tr>
			<td>이름</td>
			<td><%=request.getParameter("id")%></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><%=request.getParameter("pw")%></td>
		</tr>
		<tr>
			<td>주민번호</td>
			<td><%=request.getParameter("jumin1")%>-<%=request.getParameter("jumin2")%></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<%
					if (request.getParameter("gender").equals("남자")) {
				%>남자 <%
					} else {
				%>여자<%
					}
				%>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=request.getParameter("tel1")%>-<%=request.getParameter("tel2")%>-<%=request.getParameter("tel3")%></td>
		</tr>

		<tr>
			<td>이메일</td>
			<td><%=request.getParameter("email1")%>@<%=request.getParameter("email2")%></td>
		</tr>
		<tr>
			<td>취미</td>
			<td>
				<%
					String[] hobby = request.getParameterValues("hobby");
				for (int i = 0; i < hobby.length; i++) {
				%> <%=hobby[i]%>&nbsp; <%
 	}
 %>
			</td>
		</tr>
		<tr>
			<td>자기소개</td>
			<td><%=request.getParameter("intro")%></td>
		</tr>
	</table>
</body>
</html>