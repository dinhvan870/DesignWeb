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

@WebServlet("/list-books")
public class BookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<html>");
            out.println("<head>");
            // Tham chiếu file CSS hoặc framework CSS (vd: Bootstrap)
            out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>");
            out.println("</head>");
            out.println("<body class='container mt-5'>");

            out.println("<h1 class='text-primary'>Danh sách Sách</h1>");

            // Kết nối cơ sở dữ liệu
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();

                // Truy vấn danh sách sách
                ResultSet rs = stmt.executeQuery("SELECT id, title, author, published_year, status FROM Books");

                // Hiển thị danh sách sách trong bảng HTML
                out.println("<table class='table table-striped table-bordered mt-3'>");
                out.println("<thead class='table-primary'>");
                out.println("<tr><th>ID</th><th>Title</th><th>Author</th><th>Published Year</th><th>Status</th></tr>");
                out.println("</thead>");
                out.println("<tbody>");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    int publishedYear = rs.getInt("published_year");
                    String status = rs.getString("status");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + title + "</td>");
                    out.println("<td>" + author + "</td>");
                    out.println("<td>" + publishedYear + "</td>");
                    out.println("<td>" + status + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody>");
                out.println("</table>");
            } else {
                out.println("<p class='text-danger'>Không thể kết nối đến cơ sở dữ liệu.</p>");
            }

            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
