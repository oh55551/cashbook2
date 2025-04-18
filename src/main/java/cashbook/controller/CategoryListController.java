package cashbook.controller;

import java.io.IOException;

import java.util.ArrayList;

import dto.Category;
import dto.Paging;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CategoryDao;
import dto.*;
import Util.LoginUtil;

@WebServlet("/CategoryListController")
public class CategoryListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 if (!LoginUtil.checkLogin(request, response)) {
	            return; // 로그인 안 된 경우, 로그인 폼으로 이동함
	        }
		 
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		CategoryDao categoryDao = new CategoryDao();
		Paging p = new Paging();
		p.setCurrentPage(currentPage);
		p.setRowPerPage(10);

		ArrayList<Category> list = new ArrayList<>();
		try {
			list = categoryDao.selectCategoryList(p);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e); // 예외를 JSP까지 전달
		}

		request.setAttribute("list", list);
		request.setAttribute("paging", p);
		request.getRequestDispatcher("/WEB-INF/view/categoryList.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// POST 방식으로 호출될 일은 없지만 혹시 모르니 남겨둠
		doGet(request, response);
	}
}