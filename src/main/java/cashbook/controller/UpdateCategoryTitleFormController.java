package cashbook.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CategoryDao;

import java.io.IOException;

import Util.LoginUtil;

@WebServlet("/UpdateCategoryTitleFormController")
public class UpdateCategoryTitleFormController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!LoginUtil.checkLogin(request, response)) {
			return;
		}
		
	    int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	    CategoryDao categoryDao = new CategoryDao();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
