package cashbook.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AdminDao;
import dto.Admin;

@WebServlet("/UpdatePwController")
public class UpdatePwController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");

        if (loginAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/LoginFormController");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/updatePwForm.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");

        if (loginAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/LoginFormController");
            return;
        }

        String adminId = request.getParameter("adminId");
        String currentPw = request.getParameter("currentPw");
        String newPw = request.getParameter("newPw");

        AdminDao adminDao = new AdminDao();
        int row = 0;

        try {
            row = adminDao.updateAdminPw(adminId, currentPw, newPw);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (row == 1) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/LoginFormController");
        } else {
            response.sendRedirect(request.getContextPath() + "/UpdatePwController?error=fail");
        }
    }
}
