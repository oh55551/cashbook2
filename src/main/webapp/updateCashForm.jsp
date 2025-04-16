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
	
	
	String cashDate = request.getParameter("cashDate");
	int cashNo = Integer.parseInt(request.getParameter("cash_no"));
	CashDao cashDao = new CashDao();
	HashMap<String, Object> m = cashDao.cashOneByNo(cashNo);

	String kind = request.getParameter("kind");
	ArrayList<Category> list = null;
	if(kind!=null){ // insertCashForm.jsp 에서 kind가 선택 후 재요청
		// DB : 선택된 kind의 title 목록
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListByKind(kind);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
<form method="post" action="/cashbook/updateCashAction.jsp?cashDate=<%=cashDate%>">
<table class="table table-bordered table-hover">
	<input type="hidden" name="cashDate" value="<%= cashDate %>">
		<tr>
			<th>구분</th>
			<td>
				<select name="kind" class="form-select" onchange="this.form.action='/cashbook/updateCashForm.jsp'; this.form.submit();">
					<option value="수입" <%= "수입".equals(kind) ? "selected" : "" %>>수입</option>
					<option value="지출" <%= "지출".equals(kind) ? "selected" : "" %>>지출</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>캐시번호</th>
			<td>
				<input type="hidden" name="cash_no" value="<%= m.get("cash_no") %>">
				<%= m.get("cash_no") %>
			</td>
		</tr>
		<tr>
			<th>카테고리번호</th>
			<td><input type="text" name="category_no" value="<%= m.get("category_no") %>" class="form-control" readonly></td>
		</tr>
		<tr>
			<th>분류</th>
			<td>
				<select name="title" class="form-select">
				<%
					if (list != null) {
						for (Category c : list) {
							String selected = c.getTitle().equals(m.get("title")) ? "selected" : "";
				%>
							<option value="<%= c.getTitle() %>" <%= selected %>><%= c.getTitle() %></option>
				<%
						}
					}
				%>
				</select>
			</td>
		</tr>
		<tr>
			<th>총액</th>
			<td><input type="number" name="amount" value="<%= m.get("amount") %>" class="form-control"></td>
		</tr>
		<tr>
			<th>메모</th>
			<td><input type="text" name="memo" value="<%= m.get("memo") %>" class="form-control"></td>
		</tr>
		<tr>
			<th>색상</th>
			<td><input type="color" name="color" value="<%= m.get("color") %>" class="form-control form-control-color"></td>
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
			<td colspan="2" class="text-center">
			</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-sm btn-primary">수정하기</button>
</form>
</body>
</html>