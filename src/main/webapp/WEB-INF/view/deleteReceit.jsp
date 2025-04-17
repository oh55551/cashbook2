<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	

	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	
	ReceitDao receitDao = new ReceitDao();
	receitDao.deleteImage(cash_no);
	
	response.sendRedirect("/cashbook2/cashOne.jsp?cash_no=" + cash_no);

%>