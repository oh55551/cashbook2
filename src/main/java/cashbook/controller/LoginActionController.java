package cashbook.controller;


import java.io.IOException;

import dto.Admin;
import model.AdminDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginActionController")
public class LoginActionController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        String adminPw = request.getParameter("adminPw");

        AdminDao adminDao = new AdminDao();
        Admin loginAdmin = null;
        try {
            loginAdmin = adminDao.loginAdmin(adminId, adminPw);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (loginAdmin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginAdmin", loginAdmin);
            response.sendRedirect(request.getContextPath() + "/IndexController");
        } else {
            response.sendRedirect(request.getContextPath() + "/LoginFormController?error=fail");
        }
    }
}
