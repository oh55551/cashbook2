<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	AdminDao adminDao = new AdminDao();
	Admin admin = null;
	admin = adminDao.loginAdmin(adminId, adminPw);
	
	if(admin!=null){
		session.setAttribute("loginAdmin", admin);
		response.sendRedirect("/cashbook/index.jsp");
	}else{
		System.out.println("아이디 혹은 비밀번호가 일치하지않습니다."); 
		response.sendRedirect("/cashbook/loginForm.jsp");
	}
	
%>