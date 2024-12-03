package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import database.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/list-users")
public class UserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // CSS styling
            out.println("<html><head><style>");
            out.println("body { font-family: Arial, sans-serif; }");
            out.println("h1 { color: #007bff; }");
            out.println("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
            out.println("table, th, td { border: 1px solid #ddd; padding: 8px; }");
            out.println("th { background-color: #007bff; color: white; text-align: center; }");
            out.println("tr:nth-child(even) { background-color: #f2f2f2; }");
            out.println("</style></head><body>");

            out.println("<h1>Danh sách Người dùng</h1>");

            // Kết nối cơ sở dữ liệu
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();

                // Truy vấn danh sách người dùng
                ResultSet rs = stmt.executeQuery("SELECT id, username, password, full_name, role, created_at FROM Users");
                
                // Hiển thị danh sách người dùng trong bảng HTML
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Username</th><th>Password</th><th>Full Name</th><th>Role</th><th>Created At</th></tr>");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String fullName = rs.getString("full_name");
                    String role = rs.getString("role");
                    String createdAt = rs.getString("created_at");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + username + "</td>");
                    out.println("<td>" + password + "</td>");
                    out.println("<td>" + fullName + "</td>");
                    out.println("<td>" + role + "</td>");
                    out.println("<td>" + createdAt + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("<p>Không thể kết nối đến cơ sở dữ liệu.</p>");
            }

            out.println("</body></html>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
