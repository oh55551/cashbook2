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
	
	//날짜받아오기
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("day");
	
	//한자리수 월,일을 두자리수로만들어주기
	if (month.length() == 1){
		month = "0" + month;
	}
	if (date.length() == 1){
		date = "0" + date;
	}
	String cashDate = year + "-" + month + "-" + date;
	
	//DB불러오기
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(cashDate);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
	<table class="table table-bordered table-hover">
		<tr>
			<th>구분</th>
			<th>분류</th>
			<th>금액</th>
			<th>작성일시</th>
			<th>영수증 유무</th>			
			<th>상세보기</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
	<%
		for (HashMap<String, Object> c : list) {
			int cashNo = (Integer) c.get("cash_no");
	        boolean hasReceit = cashDao.hasReceit(cashNo); 
	%>
		<tr>
			<td><%=c.get("kind") %></td>
			<td><%=c.get("title") %></td>
			<td><%=c.get("amount") %> 원</td>
			<td><%=c.get("createdate") %></td>
			<td><%= hasReceit ? "✅" : "❌" %></td>
			<td><a href="/cashbook/cashOne.jsp?cash_no=<%=c.get("cash_no")%>">상세보기</a></td>
			<td><a href="/cashbook/updateCashForm.jsp?cash_no=<%=c.get("cash_no")%>&cashDate=<%=cashDate%>">수정</td>
			<td><a href="/cashbook/deleteCash.jsp?cashDate=<%=cashDate%>&cash_no=<%=c.get("cash_no")%>">삭제</a></td>
		</tr>
	<%
		}
	%>
	</table>
	<a href="/cashbook/insertCashForm.jsp?cashDate=<%=cashDate %>" class="btn btn-sm btn-primary">내역 추가</a>
</body>
</html>