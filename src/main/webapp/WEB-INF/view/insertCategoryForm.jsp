<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<div class="top-nav">
    <hr>
    <a href="/cashbook2/index.jsp" class="btn btn-sm">홈화면으로</a>
    <a href="/cashbook2/logout.jsp" class="btn btn-sm">로그아웃</a>
    <a href="/cashbook2/categoryList.jsp" class="btn btn-sm">카테고리</a>
    <a href="/cashbook2/monthList.jsp" class="btn btn-sm">달력</a>
    <a href="/cashbook2/summaryList.jsp" class="btn btn-sm">통계</a>
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
</head>
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
<body>
	<h1>카테고리 추가</h1>
	<form action="insertCategoryAction.jsp">
	<table class="table table-bordered table-hover">
		<tr>
			<th>Kind</th>
			<td>
			 <select name="kind" class="form-select">
				<option value="수입">수입</option>
                <option value="지출">지출</option>
            </td>
		</tr>
		<tr>
			<th>Title</th>
			<td>
				<input type="text" name="title" class="form-control">
            </td>
		</tr>
	</table>
	<button type="submit" class="btn btn-sm btn-primary">추가하기</button>
	</form>
</body>
</html>