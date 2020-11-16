<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="com.oreilly.servlet.ServletUtils" %>
<%
	String fileName = request.getParameter("file_name");

	String savePath = "upload";
	ServletContext context = getServletContext();
	String sDownloadPath = context.getRealPath(savePath);
	String sFilePath = sDownloadPath+"\\"+fileName;
	System.out.println("sFilePath: "+ sFilePath);
	
	byte b[] = new byte[4096];
	File oFile = new File(sFilePath);
	
	FileInputStream in = new FileInputStream(sFilePath);
	
	String sMimeType = getServletContext().getMimeType(sFilePath);
	System.out.println("sMimeType>>>"+ sMimeType);
	//octet-stream은 8비트로 된 일련의 데이터를 뜻 합니다. 지정되지 않은 파일 형식을 의미합니다.	
	if(sMimeType == null)
		sMimeType = "application/octet-stream";
	//한글 업로드(이 부분이 한글 파일명이 꺠지는 것을 방지해줍니다.)
	String sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
	//사용자가 다운로드 받을 때 보여줄 파일 이름을 넣는다.
	response.setHeader("Content-Disposition", "attachment; filename="+sEncoding);
	//서버에 발생하는 예외문제 해결 : response.getOutputStream()로 인해 발생
	//jsp에서 servlet으로 변환될때 내부적으로 out 객체가 생성되기 떄문에 기존 out 객체 초기화 함
	out.clear();
	out = pageContext.popBody();//초기화 후 이 문장까지 수행할것.
	
	ServletOutputStream out2 = response.getOutputStream();
	int numRead;
	//바이트 배열 b의 0번부터 numRead번 까지 브라우저로 출력
	while((numRead = in.read(b,0,b.length))!= -1){
		out2.write(b,0,numRead);
	}
	out2.flush();
	out2.close();
	in.close();
%>
