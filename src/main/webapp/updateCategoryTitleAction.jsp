<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String newTitle = request.getParameter("newTitle");
	
	CategoryDao categoryDao = new CategoryDao();
	Category category = new Category();
	
	 int row = categoryDao.updateCategoryTitle(categoryNo, newTitle);
	    if (row == 0) {
	        // 중복된 title일 경우 다시 입력 폼으로
			response.sendRedirect("/cashbook/updateCategoryTitleForm.jsp?categoryNo=" + categoryNo);
	    	return;
	    } else {
	        // 정상 등록된 경우
	        response.sendRedirect("/cashbook/categoryList.jsp");
	    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>