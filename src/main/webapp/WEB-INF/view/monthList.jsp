<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<div class="top-nav">
    <hr>
    <a href="<%=request.getContextPath()%>/IndexController" class="btn btn-sm">홈화면으로</a>
  	<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-sm btn-outline-secondary">로그아웃</a>
    <a href="<%=request.getContextPath()%>/CategoryListController" class="btn btn-sm">카테고리</a>
    <a href="<%=request.getContextPath()%>/SummaryListController" class="btn btn-sm">통계</a>
    <hr>
</div>
<%
	Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");
	if (loginAdmin == null) {
  	  response.sendRedirect("/cashbook2/loginForm.jsp");
  	  return;
	}
	
	CalendarSet calendarSet = new CalendarSet();
	
	// 현재 날짜
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH); // 0~11
	
	//다음달 or 이전달 누르면 값 받아와서 그걸로 적용시키기
	if (request.getParameter("year") != null) {
	    year = Integer.parseInt(request.getParameter("year"));
	}
	if (request.getParameter("month") != null) {
	    month = Integer.parseInt(request.getParameter("month"));
	}

	//Calendar불러오기 -> parameter로 값불러온 후 다시 여기에 집어넣어서 꺼내기
	Map<String, Integer> cal = CalendarSet.getCalendar(year, month);
		year = cal.get("year");
		month = cal.get("month");
		int startBlank = cal.get("startBlank");
		int lastDate = cal.get("lastDate");
		int endBlank = cal.get("endBlank");
		int totalCell = cal.get("totalCell");
		
	CashDao cashDao = new CashDao();
	HashMap<Integer, ArrayList<HashMap<String, Object>>> cashMap = cashDao.selectCashListMonth(year, month);
	
		
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
        background-color: #f0f8ff; /* 연하늘색 배경 */
        font-family: 'Segoe UI', sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 40px;
    }

    .top-nav {
        text-align: center;
        width: 100%;
    }

    .top-nav a {
        margin: 0 10px;
        background-color: #cce6ff;
        color: #003366;
        border: none;
        padding: 6px 12px;
        border-radius: 8px;
        transition: background-color 0.2s;
    }

    .top-nav a:hover {
        background-color: #99ccff;
        color: #002244;
    }

    hr {
        width: 80%;
        border-top: 2px solid #b3d9ff;
    }

    h3 {
        color: #004080;
        margin-bottom: 20px;
    }

    table.calendar {
        width: 80%;
        table-layout: fixed;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    table.calendar th {
        background-color: #e6f2ff;
        color: #004080;
        height: 50px;
        text-align: center;
    }

    table.calendar td {
        height: 100px;
        vertical-align: top;
        padding: 5px;
        word-wrap: break-word;
        text-align: left;
    }

    .calendar a {
        color: #004080;
        font-weight: bold;
        text-decoration: none;
    }

    .calendar a:hover {
        text-decoration: underline;
    }

    .date-number {
        font-weight: bold;
        margin-bottom: 5px;
    }

    .cash-entry {
        font-size: 12px;
        margin-bottom: 2px;
    }

    .mb-3 {
        margin-top: 20px;
    }

    .mb-3 a {
        background-color: #cce6ff;
        color: #003366;
        border: none;
        padding: 8px 14px;
        border-radius: 8px;
        transition: background-color 0.2s;
    }

    .mb-3 a:hover {
        background-color: #99ccff;
        color: #002244;
    }
</style>
<body>

<h3 class="mt-3"><%= year %>년 <%= month + 1 %>월</h3>

	<table class="table table-bordered calendar" style="table-layout: fixed;">
		<tr>
			<th style="color:red">일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th style="color:blue">토</th>
		</tr>
		<tr>
	<%
		for (int i = 1; i <= totalCell; i++) {
	%>
		<td>
	<%
			if (i <= startBlank || i > (startBlank + lastDate)) {
	%>
				&nbsp;
	<%
			} else {
			int day = i - startBlank;
	%>
			<div>
			<strong>
			<a href="/cashbook2/dateList.jsp?year=<%= year %>&month=<%= month + 1 %>&day=<%= day %>">
			<%= day %>
			</strong>
			</div>
	<%
			ArrayList<HashMap<String, Object>> dayList = cashMap.get(day);
			if (dayList != null) {
				for (HashMap<String, Object> cash : dayList) {
	%>
					<div style="font-size: 12px; color: <%= cash.get("color") %>;">
						[<%= cash.get("category_title") %>] <%= cash.get("amount") %>원
					</div>
	<%
				}
			}
		}
	%>
		</td>
	<%
			if (i % 7 == 0) {
	%>
		</tr><tr> <!-- 줄바꿈 -->
	<%
			}
		}
	%>
		</tr>
	</table>
<div class="mb-3">
	<a href="/cashbook2/monthList.jsp?year=<%= year %>&month=<%= month - 1 %>" class="btn btn-sm btn-outline-secondary">이전달</a>
	<a href="/cashbook2/monthList.jsp?year=<%= year %>&month=<%= month + 1 %>" class="btn btn-sm btn-outline-secondary">다음달</a>
</div>
</body>
</html>