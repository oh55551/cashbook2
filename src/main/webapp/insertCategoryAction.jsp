<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.*" %>
<%
	Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	}
    // 폼에서 넘어온 값 받기
    String kind = request.getParameter("kind");
    String title = request.getParameter("title");
    
    //날짜랑 시간가져오기
    String createdate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    
    //디버깅
    System.out.println("kind: " + kind);
    System.out.println("title: " + title);
    
    // DTO에 값 담기
    Category category = new Category();
    category.setKind(kind);
    category.setTitle(title);
    category.setCreatedate(createdate);

    // DB에 저장
    CategoryDao categoryDao = new CategoryDao();
    
 	// 여기서 'result'에 0 또는 pk가 들어옴
    int result = categoryDao.insertCategory(category); 
    if (result == 0) {
        // 중복된 title일 경우 다시 입력 폼으로
    	response.sendRedirect("/cashbook/insertCategoryForm.jsp");
    	return;
    } else {
        // 정상 등록된 경우
        response.sendRedirect("/cashbook/categoryList.jsp");
    }
%>