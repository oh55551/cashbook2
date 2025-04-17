<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<div class="top-nav">
    <hr>
    <a href="/cashbook2/index.jsp" class="btn btn-sm">홈화면으로</a>
    <a href="/cashbook2/logout.jsp" class="btn btn-sm">로그아웃</a>
    <a href="/cashbook2/categoryList.jsp" class="btn btn-sm">카테고리</a>
    <a href="/cashbook2/monthList.jsp" class="btn btn-sm">달력</a>
    <a href="/cashbook2/summaryList.jsp" class="btn btn-sm">통계</a>
    <hr>
</div>

<%
	Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
		  response.sendRedirect("/cashbook2/loginForm.jsp");
		  return;
	}
%>

<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body {
        background-color: #f0f8ff; /* 연한 하늘색 배경 */
        font-family: 'Segoe UI', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        padding: 40px;
    }

    table {
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        width: 80%;
        text-align: center;
    }

    th {
        background-color: #e6f2ff; /* 연하늘색 */
        color: #004080;
        text-align: center;
    }

    td {
        vertical-align: middle;
    }

    a.btn, button {
        margin: 4px;
        background-color: #cce6ff;
        color: #003366;
        border: none;
        padding: 6px 12px;
        border-radius: 8px;
        transition: background-color 0.2s;
    }

    a.btn:hover, button:hover {
        background-color: #99ccff;
        color: #002244;
    }

    form {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    hr {
        width: 80%;
        border-top: 2px solid #b3d9ff;
    }

    .top-nav a {
        margin: 0 10px;
    }
</style>
<html>
    <head>
        <meta charset="UTF-8">
        <title>영수증 등록</title>
    </head>
    <body>
    <%
   	 	int cashNo = Integer.parseInt(request.getParameter("cash_no"));
    	if(request.getParameter("msg") != null) { // insertReceitAction png파일 아니라서 redirect
    %>
    		<div><%=request.getParameter("msg")%></div>
    <%		
    	}
    %>
    <form action="/cashbook2/insertReceitAction.jsp" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="cash_no" value="<%= cashNo %>">
		<div>이미지 : <input type="file" name="imageFile"></div>
		 <input type="hidden" name="createdate">
		<button type="submit" class="btn btn-sm btn-primary">영수증 등록</button>
    </form>
    </body>
</html>
