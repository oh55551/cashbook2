<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Category" %>
<%@ page import="model.CategoryDao" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
    CategoryDao categoryDao = new CategoryDao();
    categoryDao.deleteCategory(categoryNo);
    response.sendRedirect("/cashbook/categoryList.jsp");
%>
