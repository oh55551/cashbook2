<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	}
	String adminId = request.getParameter("adminId");
	String currentPw = request.getParameter("currentPw");
	String newPw = request.getParameter("newPw");
	
	System.out.println("adminId: " + adminId);
	System.out.println("currentPw: " + currentPw);
	System.out.println("newPw: " + newPw);
	
	AdminDao adminDao = new AdminDao();
	int row= adminDao.updateAdminPw(adminId, currentPw, newPw);
	
	if(row==1){
		System.out.println("비밀번호 변경완료");
		response.sendRedirect("/cashbook/loginForm.jsp");
	}else{
		System.out.println("회원정보를 확인하세요");	
		response.sendRedirect("/cashbook/updateAdminPwForm.jsp");
		return;
	}
%>