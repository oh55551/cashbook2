<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<div class="top-nav">
<hr>
	<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-sm btn-outline-secondary">로그아웃</a>
	<a href="<%=request.getContextPath()%>/UpdatePwController" class="btn btn-sm btn-outline-secondary">비밀번호변경</a>
<hr>
</div>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Google Font: Poppins -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap" rel="stylesheet">
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
</head>
<body>
	<h4 class="text-center mb-4 menu-title">MENU</h4>
	<ul>
<div class="d-flex flex-column align-items-center">
	<a href="<%=request.getContextPath()%>/MonthListController" class="btn btn-outline-secondary mb-2">달력</a>
	<a href="<%=request.getContextPath()%>/CategoryListController" class="btn btn-outline-secondary mb-2">카테고리</a>
	<a href="<%=request.getContextPath()%>/SummaryListController" class="btn btn-outline-secondary mb-2">통계</a>
</div>
	</ul>
</body>
</html>