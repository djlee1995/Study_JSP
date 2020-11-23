<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file = "color.jsp" %>

<%
   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-d HH:mm");
   
   // 최초 page없으며 null
   String pageNum = request.getParameter("pageNum");
   
   // null = 1 , 1 page
   if(pageNum == null)
      pageNum = "1";
   
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage -1) * pageSize + 1;  // 
   int endRow = startRow + pageSize - 1;
   int count = 0;
   int number = 0;
   
   List articleList = null;
   BoardDBBean dbPro = BoardDBBean.getInstance();
   // count : 총 글의 개수
   count = dbPro.getArticleCount();
   
   // 맨 마지막 페이지의 마지막 글을 삭제하여 마지막 페이지가 없어졌을때 처리
   // 2페이지 첫번째 글을 삭제하면  count는 10 < startRow = 11 이므로
   if(count < startRow){
      currentPage = currentPage - 1; // 페이지 1개 없애기
      startRow = (currentPage - 1) * pageSize + 1;
      endRow = startRow + pageSize - 1;
   }
   if(count > 0){ 
      articleList = dbPro.getArticles(startRow, endRow);   
   } 
   // 게시판의 행 번호. 역순으로 정렬하면 가장 마지막 행이 최신글
   number = count - (currentPage - 1) * pageSize;
%>

<html>
<head> <title>게시판</title></head>

<body bgcolor="<%=bodyback_c%>">
   <b>글 목록</b>
   <!-- 글쓰기 버튼 -->
   <table width="600">
      <tr>
         <td align="right" bgcolor="<%=value_c %>>">
            <a href="writeForm.jsp">글쓰기</a>
         </td>
      </tr>
   </table>
   
<%
   if(count == 0)
   {
%>
      <!-- 게시판 글 없음 -->
      <table width="600" border="1" cellpadding="0" cellspacing="0">
         <tr>
            <td align="center">게시판에 지정된 글이 없습니다.</td>
         </tr>
      </table>
<% 
   }
   else
   { 
%>

   <!-- table : 게시판 리스트 -->
   <table width="600" border="1" cellpadding="0" cellspacing="0" align="center">
   <!--<tr> : 게시판 column  -->
    <tr height="30" bgcolor="<%=value_c%>">
       <td align="center" width="50">번호</td>
       <td align="center" width="50">제목</td>
       <td align="center" width="50">작성자</td>
       <td align="center" width="50">작성일</td>
       <td align="center" width="50">조회</td>
    </tr>
<%
   // 게시판 row 반복문으로 생성.
   for(int i = 0; i < articleList.size(); i++)
   {
         BoardDataBean article = (BoardDataBean)articleList.get(i);
%> 
         <!-- <tr> : row  -->
         <tr height="30">
            <!-- <td> 1 :  번호   -->
            <td align="center" width="50"> <%=number %> </td>
            <!-- <td> 2 :  제목 & 답변  -->
            <td width="250">
<%
            int wid = 0;
            if(article.getRe_level() > 0 ) // 답글이면 들여쓰기.
            {
               //wid = 1 * (article.getRe_level());
               for(int level = 0; level < article.getRe_level(); level++)
               {
%>
                  &nbsp;
<%
               } // end for
%>
               <img src="image/re.gif" /> 
            <%
            } // end if
            else
            { // 원글 들여쓰기 처리
            %>
               &nbsp;
<%
            } // end else
%>
            <!--<a> : subject  -->
            <a href="content.jsp?num=<%=article.getNum()%>&pagenum=<%=currentPage%>&number=<%=number%>"><%=article.getSubject() %></a>
            <script> console.log("article.getSubject() >> "+ <%=article.getSubject() %></script>
<%
            if(article.getReadcount() >= 20) // readCount >= 20 :  hot 아이콘 추가.
            {
%>
               <img src="image/hot.gif" border="0" height="16" />
<%
            }
%>
            </td>
            <!-- <td> : writer -->
            <td align="center" width="100">
               <a href="mailto:<%=article.getEmail() %>"> <%=article.getWriter() %> </a>
            </td>
            <!-- <td> : date -->
            <td align="center" width="150">
               <%=sdf.format(article.getReg_date()) %>
            </td>
            <!-- <td> : 조회수 -->
            <td align="center" width="50" ><%=article.getReadcount() %> </td>
         </tr>
<%
         number--;
      } //end first for
%>
      </table>
      <br />
      
<%
        } // else

         if(count > 0)
         {
            // ex) 글 개수 10이면 9 / 10 + 1 = 1 , +1 은 올림 효과
            int pageCount = ((count - 1) / pageSize) + 1;
            int startPage = 1;
            int i;
            
            if(currentPage%10 != 0)
               startPage = (int)(currentPage/10)*10 + 1;
            else
               startPage = currentPage - 9;
            
            int pageBlock = 10;
            
            if(startPage > 10)
            {
%>
               <a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%
            } 
         // 페이지 <a> 생성
         for(i = startPage; (i <= startPage + 9) && (i <= pageCount); i++)
         {
%>
            <a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%
         } // end for
   
         if(i < pageCount)
         {
%>
            <a href="list.jsp?pageNum=<%=startPage+10%>">[댜음]</a>
<%
         }
         }
%>      
</body>
</html>
























