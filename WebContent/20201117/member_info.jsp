<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
	String id = null;
if ((session.getAttribute("id") == null) || (!((String) session.getAttribute("id")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginForm.jsp'");
	out.println("</script>");
}
String info_id = request.getParameter("id");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	pstmt = conn.prepareStatement("select * from member where id =?");
	pstmt.setString(1, info_id);
	rs = pstmt.executeQuery();
	rs.next();
} catch (Exception e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<table border="1" width=300>
			<tr align="center">
				<td colspan="2">회원 정보</td>
			</tr>
			<tr align="center">
				<td>아이디:</td>
				<td><%=rs.getString("id")%></td>
			</tr>
			<tr align="center">
				<td>비밀번호:</td>
				<td><%=rs.getString("password")%></td>
			</tr>
			<tr align="center">
				<td>이름:</td>
				<td><%=rs.getString("name")%></td>
			</tr>
			<tr align="center">
				<td>나이:</td>
				<td><%=rs.getInt("age")%></td>
			</tr>
			<tr align="center">
				<td>성별:</td>
				<td><%=rs.getString("gender")%></td>
			</tr>
			<tr align="center">
				<td>이메일:</td>
				<td><%=rs.getString("email")%></td>
			</tr>

		</table>
	</center>
</body>
</html>