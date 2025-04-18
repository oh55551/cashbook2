package cashbook.controller;

import java.io.IOException;

import Util.LoginUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/IndexController")
public class IndexController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		if (!LoginUtil.checkLogin(request, response)) {
			return;
		}

		request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
	}
}
