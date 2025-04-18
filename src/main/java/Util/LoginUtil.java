package Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dto.Admin;
import java.io.IOException;

public class LoginUtil {
    public static boolean checkLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Admin loginAdmin = (Admin) session.getAttribute("loginAdmin");
        
        if (loginAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/LoginFormController");
            return false;
        }
        return true;
    }
}