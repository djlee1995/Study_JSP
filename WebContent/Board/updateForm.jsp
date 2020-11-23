<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="board.*"%>
<%@ include file="color.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

try
{
	BoardDBBean dbpro = BoardDBBean.getInstance();
	BoardDataBean article = dbpro.updateGetArticle(num);

%>
</head>
<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>글수정</b> <br>
		<form method="post" name="writeform"
			action="updatePro.jsp?pageNum=<%=pageNum%>">
			<table width="400" border="1" cellspacing="0" cellpadding="0"
				bgcolor="<%=bodyback_c%>" align="center">
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
					<td align="left" width="330"><input type="text" size="0"
						maxlength="10" name="writer" value="<%=article.getWriter()%>">
						<input type="hidden" name="num" value="<%=article.getNum()%>">
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="50" name="subject" value="<%=article.getSubject()%>">
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">Email</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="30" name="email" value="<%=article.getEmail()%>">
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
					<td align="left" width="330">
					<textarea rows="13" cols="40" name="content">
					<%=article.getContent()%>
					</textarea>
					</td>
				</tr>
				<tr>
					<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
					<td align="left" width="330"><input type="password" size="8"
						maxlength="12" name="passwd"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="<%=value_c%>" align="center"><input
						type="submit" value="글수정"> <input type="reset"
						value="다시작성"> <input type="button" value="목록보기"
						onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">

					</td>
				</tr>
			</table>
		</form>

	</center>
</body>
<%
}catch(Exception e){}
%>
</html>