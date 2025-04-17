<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	//cashDate가 yyyy-mm-dd꼴이므로 분리
	String cashDate = request.getParameter("cashDate");
	String[] parts = cashDate.split("-");
	String stringYear = parts[0];
	String stringMonth = parts[1];
	String stringDay = parts[2];
	int year=Integer.parseInt(stringYear);
	int month=Integer.parseInt(stringMonth);
	int day=Integer.parseInt(stringDay);
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	
	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCash(cash_no);
	
	if(row==1){
		response.sendRedirect("/cashbook2/dateList.jsp?year=" + year + "&month=" + (month) + "&day=" + day);
	}
%>