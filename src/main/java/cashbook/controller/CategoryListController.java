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

@WebServlet("/CategoryListController")
public class CategoryListController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage=1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		CategoryDao categoryDao = new CategoryDao();
		Paging p = new Paging();
		p.setCurrentPage(currentPage);
		p.setRowPerPage(10);
		ArrayList<Category> list = categoryDao.selectCategoryList(p);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}
