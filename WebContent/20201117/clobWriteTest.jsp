<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<% 
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   StringBuffer sb = null;
   
   String driver="oracle.jdbc.driver.OracleDriver";
   String url="jdbc:oracle:thin:@localhost:1522:ORCL";

   String sql ="INSERT INTO clobtable (num, content) VALUES(1,EMPTY_CLOB())";
   String sql2 ="SELECT content FROM clobtable WHERE NUM=1 FOR UPDATE";
   
   try{
      
      Class.forName(driver);
      conn=DriverManager.getConnection(url,"scott","123456");
      
      conn.setAutoCommit(false);
      
      sb=new StringBuffer();
      for(int i=0;i<=10000; i++){
         sb.append("홍길동");
      }
      
      pstmt=conn.prepareStatement(sql);
      pstmt.executeUpdate();
      pstmt.close();
      
      pstmt = conn.prepareStatement(sql2);
      rs=pstmt.executeQuery();
      if(rs.next()){
         oracle.sql.CLOB clob=(oracle.sql.CLOB)(rs).getClob("content");
         BufferedWriter bw = new BufferedWriter(clob.getCharacterOutputStream());
         bw.write(sb.toString());
         bw.close();
      }
      pstmt.close();
      
      conn.commit();
      conn.setAutoCommit(true);
      out.println("데이터를 저장했습니다.");
      
      rs.close();
      pstmt.close();
      conn.close();
      
   }catch(Exception e){
      out.println("<h3>데이터 가져오기에 실패하였습니다.</h3>");
      e.printStackTrace();
   }

%>