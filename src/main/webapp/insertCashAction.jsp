<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String cashDate = request.getParameter("cashDate");
	String kind = request.getParameter("kind");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	
	 Cash cash = new Cash();
	    cash.setCategory_no(categoryNo);
	    cash.setCash_date(cashDate);
	    cash.setAmount(amount);
	    cash.setMemo(memo);
	    cash.setColor(color);

	    // DAO 호출하여 insert 실행
	    CashDao cashDao = new CashDao();
	    int row = cashDao.insertCash(cash);

	    response.sendRedirect("/cashbook/monthList.jsp");
%>