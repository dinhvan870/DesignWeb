package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Xóa phiên làm việc (session)
        HttpSession session = request.getSession(false); // Lấy session hiện tại
        if (session != null) {
            session.invalidate(); // Hủy session
        }

        // Chuyển hướng người dùng đến trang đăng nhập hoặc trang chủ
        response.sendRedirect(request.getContextPath() + "/login");
    }
}

