<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	int cashNo = Integer.parseInt(request.getParameter("cash_no"));
	Part part = request.getPart("imageFile");	//파일 받은 API  
	String createdate = request.getParameter("createdate");
	String originalName = part.getSubmittedFileName(); //one.png
	System.out.println("originalName: "+originalName);
	
	//1) 중복되지 않는 새로운 파일이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", "");
	System.out.println("uuid str:" + filename);
	
	//2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 점의 위치(one.png 같은거에서)의 인덱스값 반환
	System.out.println("dotLastPos:"+dotLastPos);
	String ext = originalName.substring(dotLastPos);
	
	if(!ext.equals(".png")){
		response.sendRedirect("/cashbook2/insertreceitForm.jsp?msg=ErrorNotPng");
		return;
	}
	
	filename= filename+ext;
	System.out.println("filename" + filename);	
	
	Receit r = new Receit();
	r.setCash_no(cashNo);
	r.setFilename(filename);
	r.setCreatedate(createdate);
	
	//3) 파일 저장
	//빈파일 생성
	//File emptyFile = new File("c:/upload/a.png");
	String path = request.getServletContext().getRealPath("upload"); // 톰캣 안에 poll 프로젝트안 upload폴더의 실제 물리적주소
	System.out.println("path :"+path);
	File emptyFile = new File(path, filename);
	// 파일보낼 inputstream설정
	InputStream is = part.getInputStream(); //파트안의 스트림(이미지파일의 바이너리파일)
	// 파일받을 outputstream설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); //inputStream binary -> 반복 -> outputstream
	
	
	
	// 4) db의 저장
	ReceitDao receitDao = new ReceitDao();
	receitDao.insertImage(r);
	response.sendRedirect("/cashbook2/cashOne.jsp?cash_no=" + cashNo);
%>