<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDBBean" %>    
<%@ page import="java.sql.Timestamp" %>  

<% request.setCharacterEncoding("utf-8"); %>

<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
   String passwd = request.getParameter("passwd");
   
   BoardDBBean dbPro = BoardDBBean.getInstance();
   int check = dbPro.deleteArticle(num, passwd);
   
   if(check == 1){

%>

   <script language="JavaScript">
   <!--
      location.href="list.jsp?pageNum=<%=pageNum%>";
   -->
   </script>
<%
   }else{
%>
   <script language="JavaScript">
   <!--
      alert("비밀번호가 맞지않습니다.");
      history.go(-1);
   -->
   </script>
<%
   }
%>







