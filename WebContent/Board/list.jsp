<!-- drop table board;
CREATE TABLE board (
    num          NUMBER PRIMARY KEY,
    writer       VARCHAR2(20),
    passwd       VARCHAR2(20),
    subject      VARCHAR2(50),
    email        VARCHAR2(50),
    content      VARCHAR2(2000),
    reg_date     TIMESTAMP,
    readcount   NUMBER,
    ref          NUMBER,
    re_step      NUMBER,
    re_level     NUMBER
);
create sequence board_seq maxvalue 100000;
 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %> 
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file = "color.jsp" %>   

<%
   int pageSize = 10;   //한 화면에 나타나는 글 수
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-d HH:mm");   //작성일 형식
   
   String pageNum = request.getParameter("pageNum");
   
   if(pageNum == null)   //pageNum 값이 없을 경우
      pageNum = "1";
   
   int currentPage = Integer.parseInt(pageNum);      //pageNum을 정수형으로 바꿔서 currentPage에 저장
   int startRow = (currentPage - 1) * pageSize + 1;   //시작 페이지
   int endRow = startRow + pageSize - 1;            //마지막 페이지
   int count = 0;
   int number = 0;
   
   List articleList = null;   
   BoardDBBean dbPro = BoardDBBean.getInstance();      //BoardDBBean 객체 반환.
   count = dbPro.getArticleCount();               //getArticleCount 메소드 호출. count에는 총 글의 개수가 저장됨.
   
   //맨 마지막 페이지의 마지막 글을 삭제하여 마지막 페이지가 없어졌을 때 필요
   if (count < startRow)
   {
      currentPage = currentPage - 1;   //글이 삭제되어 글이 없어진 페이지를 없애고 그 전 페이지로 가는 작업.
      startRow = (currentPage - 1) * pageSize + 1;
      endRow = startRow + pageSize - 1;
   }
   
   if(count > 0){  
      articleList = dbPro.getArticles(startRow, endRow);
   }
   number = count - (currentPage - 1) * pageSize;   // number : 일련번호를 역순으로 만들어 놓은 것.
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body bgcolor="<%=bodyback_c %>">
   <center>
      <b> 글목록 </b>
      <table width="600">
         <tr>
            <td align="right" bgcolor="<%=value_c %>">
               <a href="writeForm.jsp"> 글쓰기 </a>
            </td>
         </tr>
      </table>
<%
   if (count == 0)   //글의 개수가 0일 경우. 빈 테이블일 경우
   {
%>   
      <table width="600" border="1" cellpadding="0" cellspacing="0">
         <tr>
            <td align="center">게시판에 저장된 글이 없습니다.</td>
         </tr>
      </table>
<%       
   }
   else
   {
%>
   <table border="1" width="600" cellpadding="0" cellspacing="0"
      align="center">
         <tr height="30" bgcolor="<%=value_c %>">
            <td align="center" width="50"> 번 호 </td>
            <td align="center" width="250"> 제 목 </td>
            <td align="center" width="100"> 작성자 </td>
            <td align="center" width="150"> 작성일 </td>
            <td align="center" width="50"> 조 회 </td>
         </tr>
<%
   for(int i=0; i<articleList.size(); i++)
   {
      BoardDataBean article = (BoardDataBean)articleList.get(i);
%>
      <tr height="30">
         <td align="center" width="50"> <%=number %></td>   <!-- 글번호 -->
         <td width="250">
<%
            int wid=0;
            if (article.getRe_level() > 0 )   // 답글의 경우 들여쓰기 효과를 주는 작업. 원글일 경우 Re_level()이 0이다.
            {
               for(int level = 0; level < article.getRe_level(); level++)
                     
               {
%>               
               &nbsp;
<%                  
               }
%>            
            <img src="image/re.gif">   <!-- 답글의 경우 re 이미지 출력 -->
<%   
            }
            else   //원글일 경우 공백을 하나 준다.
            {
%>
            &nbsp;
<%            
   }
%>            <!-- 제목을 추가하는 작업. 제목을 누르면 상세보기 효과. num으로 전달받음. 파라미터(num, pageNum, number) -->
            <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>&number=<%=number%>">
             <%=article.getSubject() %></a> <!-- get 메소드로 Subject 읽어옴 -->
<%
            if(article.getReadcount() >= 20)   //글 조회수가 20 이상일 경우 작업
            {
%>            
               <img src="image/hot.gif"border="0" height="16">
<%                  
            }
%>
            </td>
            <td align="center" width="100">
               <a href="mailto:<%=article.getEmail() %>"><%=article.getWriter() %></a>
            </td>
            
            <td align="center" width="150">
               <%=sdf.format(article.getReg_date()) %>
            </td>
            
            <td align="center" width="50"><%=article.getReadcount() %></td>   <!-- 글 조회수 출력 -->
         </tr>
<%
         number--;
      }
%>
      </table>
      <br>
<%
   }
   //페이지 링크 만드는 작업
   if(count > 0)   //글이 존재할 경우
   {
      int pageCount = ((count-1) / pageSize)+1;   //총 페이지 개수 카운드. 올림효과.
      int startPage = 1;
      int i;   
      
      if(currentPage%10 != 0)   //10의 배수인지 확인. 
         startPage = (int)(currentPage/10)*10+1;
      else
         startPage = currentPage - 9;
      
      int pageBlock = 10;   //페이지를 10개씩 관리하겠다는 의미.
      
      if (startPage > 10)   //페이지가 10개를 넘어갈 경우 이전 버튼이 만들어진다.
      {
%>   
      <a href="list.jsp?pageNum= <%=startPage-10 %>">[이전]</a>
<%
      }
      
      for(i=startPage; (i<=startPage+9) && (i<=pageCount) ; i++)   //실제 페이지수보다 작거나 같을 때까지 반복.
      {
%>         
         <a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
<%         
      }
      
      if(i < pageCount)   //다음 버튼을 만드는 작업.
      {
%>
         <a href="list.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%
      }
   }
%>
   </center>
</body>
</html>