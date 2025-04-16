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

	// dateList.jsp -> 수입/지출 입력(String cashDate) -> 
	String cashDate = request.getParameter("cashDate");
	// insertCastForm.jsp -> kind 선택(String kind)
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
<h1>내역 추가</h1>
	<form action="/cashbook/insertCashForm.jsp" method="post">
		<input type="hidden" name="cashDate" value="<%=cashDate%>">
			항목
		<select name="kind" class="form-select">
			<option value="">::선택::</option>
			<% if ("수입".equals(kind)) { 
			%>
			    <option value="수입" selected>수입</option>
			<% 
				} else { 
			%>
			    <option value="수입">수입</option>
			<%
				}
				if ("지출".equals(kind)) { 
			%>
			    <option value="지출" selected>지출</option>
			<% 
				} else { 
			%>
			    <option value="지출">지출</option>
			<% 
				} 
			%>
		</select>
		<button type="submit" class="btn btn-sm btn-primary">수입/지출 선택</button>
	</form>
	
	<hr>
	
	<form method="post" action="/cashbook/insertCashAction.jsp">
		cashDate : <br>
		<input type="text" name="cashDate" value="<%=cashDate%>" class="form-text" readonly><br>
		category : 
		<select name="categoryNo" class="form-select">
			<%
				if(list !=null){
					for(Category c : list){
			%>
						<option value="<%=c.getCategory_no()%>"><%=c.getTitle() %></option>
			<%	
					}
				}
			%>
		</select>
		<div class="mb-1">
			<label class="form-label">금액</label>
			<input type="number" name="amount" class="form-control">
		</div>
		<div class="mb-1">
			<label class="form-label">메모</label>
			<input type="text" name="memo" class="form-control">
		</div>
		<div class="mb-1">
			<label class="form-label">색상</label>
			<input type="color" name="color" class="form-control form-control-color">
		</div>
		<button type="submit" class="btn btn-sm btn-primary">수입/지출 입력</button>
	</form>
</body>
</html>