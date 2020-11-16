<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.awt.*" %>
<%@ page import ="java.awt.image.*" %>
<%@ page import="java.awt.image.renderable.ParameterBlock"%>
<%@ page import = "javax.media.jai.*" %>
<%@ page import ="javax.imageio.ImageIO" %>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%
	String imagePath = request.getRealPath("/image");
	System.out.println("imagePath = "+imagePath);
	
	int size = 20*1024*1024;
	String filename="";
	
	try{
	 MultipartRequest multi = new MultipartRequest(request,imagePath,size,"utf-8"
			 ,new DefaultFileRenamePolicy());
	 Enumeration files = multi.getFileNames();
	 String file = (String)files.nextElement();
	 filename = multi.getFilesystemName(file);
	}catch(Exception e){
		e.printStackTrace();
	}
	//RenderableImageOp나, 이미지를 처리하는 것 외의 클래스에 의해 필요하게 되는 소스 및
	//파라미터 (Object)에 대한 모든 정보를 캡슐화함
	ParameterBlock pb = new ParameterBlock();
	pb.add(imagePath+"/"+filename);
	//PlanerImage 클래스를 상속하며, 이미지에 방금 수행된 연산의 정보를 포함하고 있다.
	RenderedOp rOp = JAI.create("fileload", pb);
	//BufferedImage 객체를 얻어온다.
	BufferedImage bi = rOp.getAsBufferedImage();
	BufferedImage thumb = new BufferedImage(100,100,BufferedImage.TYPE_INT_RGB);
	//그래픽스 객체 생성
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0, 100, 100, null);
	
	File file = new File(imagePath+"/sm_"+filename);
	//jpg 이미지 저장
	ImageIO.write(thumb, "jpg", file);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 썸네일 예제</title>
</head>
<body>
-원본 이미지- <br>
<img src="../image/<%=filename%>"> <p>
-썸네일 이미지- <br>
<img src="../image/sm_<%=filename%>">
</body>
</html>