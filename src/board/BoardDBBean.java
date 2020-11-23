package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
   
   
   private static BoardDBBean instance = new BoardDBBean();
   
   public static BoardDBBean getInstance() { // private static BoardDBBean �̹Ƿ� �޼���� ��ü ������� �޼���
      return instance;
   }
   private BoardDBBean() {    // default constructor
   }
   
   private Connection getConnection() throws Exception { // ���� ��ü�� ���� �޼���. 
      
      Context initCtx = new InitialContext();
      Context envCtx = (Context)initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");
      
      return ds.getConnection();
   }
   
   private void close(ResultSet rs, PreparedStatement pstmt, Connection conn) { // ���� ��ü close�� ���� �޼���
      
      if( rs != null) {
         
         try { rs.close(); }catch(Exception e){  }// ����� => ���� �߻��ϸ� �ƹ��͵� ���ϰڴ�. 
      }
      if( pstmt != null) {
         
         try { pstmt.close(); }catch(Exception e){ } // ����� => ���� �߻��ϸ� �ƹ��͵� ���ϰڴ�. 
      }
      if( conn != null) {
         
         try { conn.close(); }catch(Exception e){ } // ����� => ���� �߻��ϸ� �ƹ��͵� ���ϰڴ�. 
      }
      
   } // end close
   
   public void insertArticle(BoardDataBean article) throws Exception{
      // article�� �� �����Ͱ� ����ȴ�. 
      // �� �۾���, ��� ���⸦ �� �޼��忡�� ��� ó��.
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      // ��۾����϶� ��ȿ�� ������
      int num = article.getNum();
      int ref = article.getRef();
      int readcount = article.getNum();
      int re_step = article.getRef();
      int re_level = article.getNum();
      int number = 0;
      
      String sql = "";
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select max(num) from board"); // max(num) : 
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            number = rs.getInt(1) + 1; // ������ ���� �����Ҷ�(max(num)) ���� ����ϴ� ���� ��ȣ�� ���� �� ������ + 1 
         }else {
            number = 1; // �Խ��ǿ� ���� ������ 1�� ��.
         }
         
         if( num != 0) { // ��� ���� ���� �۾�.
            sql = "update board set re_step = re_step + 1 where" + " ref = ? and re_step = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ref);
            pstmt.setInt(2,  re_step);
            pstmt.executeUpdate();
            re_step = re_step + 1;
            re_level = re_level + 1;
         }
         else {
            // ���� ���� �۾�.
            ref = number;
            re_step = 0;
            re_level = 0;
         }
         
         sql = "insert into board(num, writer, passwd, subject, email, content, reg_date, readcount, ";
         sql += "ref, re_step, re_level) values(board_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, article.getWriter());
         pstmt.setString(2, article.getPasswd());
         pstmt.setString(3, article.getSubject());
         pstmt.setString(4, article.getEmail());
         pstmt.setString(5, article.getContent());
         pstmt.setTimestamp(6, article.getReg_date());
         pstmt.setInt(7, article.getReadcount());
         pstmt.setInt(8, ref);
         pstmt.setInt(9, re_step);
         pstmt.setInt(10, re_level);
         
         pstmt.executeUpdate();
      }
      catch(Exception ex) {
         System.out.println("�۾��� �����Դϴ� >>" + ex.getMessage());
         ex.printStackTrace();
      }
      finally {
         close(rs, pstmt, conn);
      }      
   }
   
   public int getArticleCount() throws Exception {
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int count = 0;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select count(*) from board");
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            count = rs.getInt(1);
         }
      }
      catch(Exception ex) {
         ex.printStackTrace();
      }
      finally {
         close(rs, pstmt, conn);
      }      
      return count;
   }
   
   public List getArticles(int start, int end) throws Exception{
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List articleList = null;
      String sql = null;
      
      try {
         
         conn = getConnection();
         
         sql = "select * from ";
         sql += "(select rownum rnum, num, writer, passwd, ";
         sql += "subject, email, content, reg_date, ";
         sql += "readcount, ref, re_step, re_level from ";
         sql += "(select * from board order by ref desc, re_step asc)) ";
         sql += "where rnum >= ? and rnum <= ?";
         
         System.out.println("getArticles�� sql >>> " + sql);
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            articleList = new ArrayList();
            
            do
            {
               BoardDataBean article = new BoardDataBean();
               article.setNum(rs.getInt("num"));
               article.setWriter(rs.getString("writer"));
               article.setPasswd(rs.getString("passwd"));
               article.setSubject(rs.getString("subject"));
               article.setEmail(rs.getString("email"));
               article.setContent(rs.getString("content"));
               article.setReg_date(rs.getTimestamp("reg_date"));
               article.setReadcount(rs.getInt("readcount"));
               article.setRef(rs.getInt("ref"));
               article.setRe_step(rs.getInt("re_step"));
               article.setRe_level(rs.getInt("re_level"));
               
               articleList.add(article);
               
            } // end do
            while(rs.next());
         }
      } // end try
      catch(Exception ex) {
         ex.printStackTrace();
      }
      finally {
         close(rs, pstmt, conn);
      }
      return articleList;
   }
   
   public BoardDataBean getArticle(int num) throws Exception{
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      BoardDataBean article = null;
      
      try {
         conn =  getConnection();
         
         pstmt = conn.prepareStatement("select * from board where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            
            article = new BoardDataBean();
            
            article.setNum(rs.getInt("num"));
            article.setWriter(rs.getString("writer"));
            article.setPasswd(rs.getString("passwd"));
            article.setSubject(rs.getString("subject"));
            article.setEmail(rs.getString("email"));
            article.setContent(rs.getString("content"));
            article.setReg_date(rs.getTimestamp("reg_date"));
            article.setReadcount(rs.getInt("readcount")+1);
            article.setRef(rs.getInt("ref"));
            article.setRe_step(rs.getInt("re_step"));
            article.setRe_level(rs.getInt("re_level"));
            
            String updateArticle_sql = "update board set readcount = ? where num = ?";
            pstmt = conn.prepareStatement(updateArticle_sql);
            pstmt.setInt(1, rs.getInt("readcount")+1);
            pstmt.setInt(2, num);
            pstmt.executeUpdate();
            
         }
      }
      catch(Exception ex) {
         ex.printStackTrace();
      }// end try-catch
      finally {
         close(rs, pstmt, conn);
      }
      return article;
      
   } //end BoardDataBean getArticle(int num) method
   
   public BoardDataBean updateGetArticle(int num) throws Exception{
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      BoardDataBean article = null;
      
      try {
         conn =  getConnection();
         
         pstmt = conn.prepareStatement("select * from board where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            
            article = new BoardDataBean();
            
            article.setNum(rs.getInt("num"));
            article.setWriter(rs.getString("writer"));
            article.setPasswd(rs.getString("passwd"));
            article.setSubject(rs.getString("subject"));
            article.setEmail(rs.getString("email"));
            article.setContent(rs.getString("content"));
            
         }
      }
      catch(Exception ex) {
         ex.printStackTrace();
      }// end try-catch
      finally {
         close(rs, pstmt, conn);
      }
      return article;
      
   } // end BoardDataBean updateGetArticle(int num) 
   
   public int updateArticle(BoardDataBean article) throws Exception{
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String dbpasswd = "";
      String updateArticle_sql = "";
      int x = -1;
      
      try {
         conn =  getConnection();
         
         pstmt = conn.prepareStatement("select passwd from board where num = ?");
         pstmt.setInt(1, article.getNum());
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            
            dbpasswd = rs.getString("passwd");
            
            if(dbpasswd.equals(article.getPasswd())) {
               
               updateArticle_sql = "update board set writer = ?, passwd = ?, ";
               updateArticle_sql += "subject = ?, email = ?, content = ? where num = ?";
               
               pstmt = conn.prepareStatement(updateArticle_sql);
               pstmt.setString(1, article.getWriter());
               pstmt.setString(2, article.getPasswd());
               pstmt.setString(3, article.getSubject());
               pstmt.setString(4, article.getEmail());
               pstmt.setString(5, article.getContent());
               pstmt.setInt(6, article.getNum());
               pstmt.executeUpdate();
               x=1;
               
            }else {
               x = 0;
            }
         }
      }
      catch(Exception ex) {
         ex.printStackTrace();
      }
      finally{
         close(rs, pstmt, conn);
      }
      return x;
   } // end int updateArticle(BoardDataBean article)
   
   public int deleteArticle(int num, String passwd) throws Exception{
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String dbpasswd = "";
      int x = -1;
      
      try {
         conn = getConnection();
         
         pstmt = conn.prepareStatement("select passwd from board where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            dbpasswd = rs.getString("passwd");
            
            if(dbpasswd.equals(passwd)) {
               
               pstmt = conn.prepareStatement("delete from board where num = ?");
               pstmt.setInt(1, num);
               pstmt.executeUpdate();
               
               x = 1;
            }
            else {  x = 0; }
         }
      }
      catch(Exception ex) {
         ex.printStackTrace();
      }
      finally {
         close(rs, pstmt, conn);
      }
      return x;
   } // end int deleteArticle(int num, String passwd)
   
} // end BoardDBBean class

