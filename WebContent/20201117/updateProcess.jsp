
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
request.setCharacterEncoding("utf-8");
String id = null;
if ((session.getAttribute("id") == null) || (!((String) session.getAttribute("id")).equals("admin"))) {
	out.println("<script>");
	out.println("location.href='loginForm.jsp'");
	out.println("</script>");
}

String update_id = request.getParameter("id");
String update_pass = request.getParameter("pass");
String update_name = request.getParameter("name");
int update_age = Integer.parseInt(request.getParameter("age"));
String update_gender = request.getParameter("gender");
String update_email = request.getParameter("email");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	pstmt = conn.prepareStatement("Update member Set password = ? ,name =? ,age =? ,gender =? ,email =? Where id =?");
	pstmt.setString(1, update_pass);
	pstmt.setString(2, update_name);
	pstmt.setInt(3, update_age);
	pstmt.setString(4, update_gender);
	pstmt.setString(5, update_email);
	pstmt.setString(6, update_id);
	int result=pstmt.executeUpdate();
	
	if(result!=0){
		out.println("<script>");
		out.println("alert('수정성공');");
		out.println("location.href='member_list.jsp'");
		out.println("</script>");
	}else{
		out.println("<script>");
		out.println("location.href='member_list.jsp'");
		out.println("</script>");
	}
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

		
</body>
</html>