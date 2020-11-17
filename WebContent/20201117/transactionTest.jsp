<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
	Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
StringBuffer sb = null;

String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1522:ORCL";

String sql = "INSERT INTO student (num, name) VALUES(12,'홍길동')";
String sql2 = "SELECT * FROM student WHERE NUM=11";

try{
	Context init = new InitialContext();
	  DataSource ds = (DataSource)
	    init.lookup("java:comp/env/jdbc/OracleDB");
	  conn = ds.getConnection();
	  conn.setAutoCommit(false);
	  
	  pstmt=conn.prepareStatement(sql);
	  pstmt.executeUpdate();
	  pstmt.close();
	  
	  pstmt=conn.prepareStatement(sql2);
	  rs=pstmt.executeQuery();
	  if(!rs.next()){
		  conn.rollback();
		  out.println("<h3>데이터 삽입에 문제가 발생하여 롤백하였습니다.</h3>");
	  }else{
		  conn.commit();
		  out.println("<h3>데이터 삽입이 모두 완료되었습니다.</h3>");	  
	  }
	  pstmt.close();
	  conn.setAutoCommit(true);
}catch(Exception e){
	  out.println("<h3>데이터 삽입에 실패했습니다.</h3>");
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