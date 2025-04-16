<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<div class="top-nav">
    <hr>
    <a href="/cashbook/index.jsp" class="btn btn-sm">홈화면으로</a>
    <a href="/cashbook/logout.jsp" class="btn btn-sm">로그아웃</a>
    <a href="/cashbook/categoryList.jsp" class="btn btn-sm">카테고리</a>
    <a href="/cashbook/monthList.jsp" class="btn btn-sm">달력</a>
    <a href="/cashbook/summaryList.jsp" class="btn btn-sm">통계</a>
    <hr>
</div>
<%
	Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
		  response.sendRedirect("/cashbook/loginForm.jsp");
		  return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cash_no"));
	CashDao cashDao = new CashDao();
	HashMap<String, Object> m = cashDao.cashOneByNo(cashNo);
	ReceitDao receitDao = new ReceitDao();
	Receit receit = receitDao.selectReceitByCashNo(cashNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
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
<body>
	<table class="table table-bordered table-hover">
		<tr>
			<th>구분</th>
			<td><%= m.get("kind") %></td>
		</tr>
		<tr>
			<th>캐시번호</th>
			<td><%= m.get("cash_no") %></td>
		</tr>
		<tr>
			<th>카테고리번호</th>
			<td><%= m.get("category_no") %></td>
		</tr>
		<tr>
			<th>분류</th>
			<td><%= m.get("title") %></td>
		</tr>
		<tr>
			<th>총액</th>
			<td><%= m.get("amount") %></td>
		</tr>
		<tr>
			<th>메모</th>
			<td><%= m.get("memo") %></td>
		</tr>
		<tr>
			<th>색상</th>
			<td><%= m.get("color") %></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%= m.get("createdate") %></td>
		</tr>
		<tr>
			<th>업데이트</th>
			<td><%= m.get("updatedate") %></td>
		</tr>
		<tr>
			<th>영수증</th>
			<td><% 
				if (receit != null) { 
			%>
				<img src="<%= request.getContextPath() + "/upload/" + receit.getFilename() %>" 
				     style="max-width: 200px; border: 1px solid #ddd; padding: 5px;">
			<% 
				} else { 
			%>
				<p>영수증 이미지가 등록되지 않았습니다.</p>
			<% 
				} 
			%>
			</td>
		</tr>
	</table>
	<form action="/cashbook/insertReceitForm.jsp">
	<input type="hidden" name="cash_no" value="<%= cashNo %>">
	<button type="submit" class="btn btn-sm btn-primary">영수증 등록</button>
	</form>
	<form action="/cashbook/deleteReceit.jsp">
	<input type="hidden" name="cash_no" value="<%= cashNo %>">
	<button type="submit" class="btn btn-sm btn-primary">영수증 삭제</button>
	</form>
	

	
</body>
</html>