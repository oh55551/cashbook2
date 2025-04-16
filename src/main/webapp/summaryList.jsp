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
	
	String yearParam = request.getParameter("year");
	int year = 0;
	    if (yearParam != null && !yearParam.equals("")) {
	        year = Integer.parseInt(yearParam);
	    }
	String monthParam = request.getParameter("month");
	int month=0;
		if (monthParam != null && !monthParam.equals("")){
			month = Integer.parseInt(monthParam);	
		}
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.cashAmount();
	ArrayList<HashMap<String, Object>> listByYear = cashDao.cashAmountByYear(year);
	ArrayList<HashMap<String, Object>> listByMonth = cashDao.cashAmountByMonth(month);
	ArrayList<HashMap<String, Object>> listBySelect = cashDao.cashAmountBySelect(year, month);
	
	

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
			<form method="get" action="summaryList.jsp">
    			<select name="year">
     			   <option value="">전체</option>
     			   <option value="2025">2025</option>
     			   <option value="2024">2024</option>
     			   <option value="2023">2023</option>
     			   <option value="2022">2022</option>
     			   <option value="2021">2021</option>
     			   <option value="2020">2020</option>
   				</select>&nbsp;
   				<select name="month">
      			   <option value="">전체</option>
       			   <option value="1">1월</option>
       			   <option value="2">2월</option>
       			   <option value="3">3월</option>
       			   <option value="4">4월</option>
       			   <option value="5">5월</option>
       			   <option value="6">6월</option>
       			   <option value="7">7월</option>
       			   <option value="8">8월</option>
       			   <option value="9">9월</option>
       			   <option value="10">10월</option>
       			   <option value="11">11월</option>
       			   <option value="12">12월</option>
    		    </select>&nbsp;
   				   <button type="submit" class="btn btn-sm btn-primary">조회</button>
			</form>
		</tr>
		
		<!-- 전체 리스트 -->
		<%
			if(year==0 && month==0){
		%>
		<tr>
			<th colspan="4">총 수입/지출</th>
		</tr>
		<tr>
			<th>종류</th>
			<th>수량</th>
			<th>총액</th>
		</tr>
		<%
			for (HashMap<String, Object> m : list) {
		%>
		<tr>
			<td><%=m.get("kind") %></td>
			<td><%=m.get("cnt") %></td>
			<td><%=m.get("sumAmount") %></td>
		</tr>
		<%
			}
		%>
		
		<!-- 년도별 리스트 -->
		<%
		}
			if(year>0 && month==0){
		%>
		<tr>
			<th colspan="4"><%=year %>년 수입/지출</th>
		</tr>
		<tr>
			<th>종류</th>
			<th>수량</th>
			<th>총액</th>
		</tr>
		<%
				for (HashMap<String, Object> m2 : listByYear) {
		%>
		<tr>
			<td><%=m2.get("kind") %></td>
			<td><%=m2.get("cnt") %></td>
			<td><%=m2.get("sumAmount") %></td>
		</tr>
		<%
			}
		}
		%>
		
		<!-- 월별 리스트 -->
		<%
			if(month>0 && year==0){
		%>
		<tr>
			<th colspan="4"><%=month %>월 수입/지출</th>
		</tr>
		<tr>
			<th>종류</th>
			<th>수량</th>
			<th>총액</th>
		</tr>
		<%
				for (HashMap<String, Object> m3 : listByMonth) {
		%>
		<tr>
			<td><%=m3.get("kind") %></td>
			<td><%=m3.get("cnt") %></td>
			<td><%=m3.get("sumAmount") %></td>
		</tr>
		<%
			}
		}
		%>
		
		<!-- 년도+월별 리스트 -->
		<%
			if(month>0 && year>0){
		%>
		<tr>
			<th colspan="4"><%=year%>년 <%=month %>월 수입/지출</th>
		</tr>
		<tr>
			<th>종류</th>
			<th>수량</th>
			<th>총액</th>
		</tr>
		<%
				for (HashMap<String, Object> m4 : listBySelect) {
		%>
		<tr>
			<td><%=m4.get("kind") %></td>
			<td><%=m4.get("cnt") %></td>
			<td><%=m4.get("sumAmount") %></td>
		</tr>
		<%
			}
		}
		%>
		
	</table>
</body>
</html>