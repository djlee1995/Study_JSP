<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file = "color.jsp" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
int number = Integer.parseInt(request.getParameter("number"));

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

try{
	BoardDBBean dbpro = BoardDBBean.getInstance();
	BoardDataBean article = dbpro.getArticle(num);
	
	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level = article.getRe_level();

%>
<body bgcolor="<%=bodyback_c%>">
<center>
	<b>글 내용 보기</b>
	<form>
		<table width="555" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c%>" align="center">
		<tr height="30" align="center" width="125">
			<td bgcolor="<%=value_c%>">글번호 </td>
			<td><%=number %></td>
			<td bgcolor="<%=value_c%>">조회수 </td>
			<td width="100"><%=article.getReadcount()%></td>
		</tr>
		<tr height="30" align="center" width="125">
			<td bgcolor="<%=value_c%>">작성자 </td>
			<td><%=article.getWriter() %></td>
			<td bgcolor="<%=value_c%>">조회수 </td>
			<td width="100"><%=sdf.format(article.getReg_date())%></td>
		</tr>
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c%>">글제목 </td>
			<td><%=number %></td>
			<td align="left" colspan="3">&nbsp; <%=article.getSubject() %> </td>
		</tr>
		<tr>
			<td align="center" width="125"  bgcolor="<%=value_c%>">글내용 </td>
			<td align="left" colspan="3">
				<pre><%=article.getContent()%></pre> 
			</td>
		</tr>
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c%>" align="center"> 
				<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
				&nbsp;&nbsp;
				<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
				&nbsp;&nbsp;
				<input type="button" value="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
				&nbsp;&nbsp;
				<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
				
			</td>
		</tr>
		</table>
	</form>
</center>
</body>
<%
}
catch(Exception ex){
	
}
%>
</html>