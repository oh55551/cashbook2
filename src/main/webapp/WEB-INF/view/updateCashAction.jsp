<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 파라미터 받아오기
	int cashNo = Integer.parseInt(request.getParameter("cash_no"));
	int categoryNo = Integer.parseInt(request.getParameter("category_no"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	String cashDate = request.getParameter("cashDate");
	
	// Cash 객체 세팅
	Cash c = new Cash();
	c.setCash_no(cashNo);
	c.setCategory_no(categoryNo);
	c.setAmount(amount);
	c.setMemo(memo);
	c.setColor(color);
	
	// DAO 호출
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCash(c, kind, title);
	
	response.sendRedirect("/cashbook2/cashOne.jsp?cash_no=" + cashNo);
%>
