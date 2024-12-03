package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import database.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/list-borrowings")
public class BorrowingsListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Basic CSS styling
            out.println("<html><head><style>");
            out.println("body { font-family: Arial, sans-serif; }");
            out.println("h1 { color: #007bff; }");
            out.println("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
            out.println("table, th, td { border: 1px solid #ddd; padding: 8px; }");
            out.println("th { background-color: #007bff; color: white; text-align: center; }");
            out.println("tr:nth-child(even) { background-color: #f2f2f2; }");
            out.println("</style></head><body>");

            out.println("<h1>Danh sách Mượn Sách</h1>");

            // Kết nối cơ sở dữ liệu
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();

                // Truy vấn danh sách mượn sách
                String query = """
                    SELECT b.id, bk.title AS book_title, u.username AS user_name, 
                           b.borrow_date, b.return_date, b.status
                    FROM Borrowings b
                    JOIN Books bk ON b.book_id = bk.id
                    JOIN Users u ON b.user_id = u.id
                """;
                ResultSet rs = stmt.executeQuery(query);

                // Hiển thị danh sách mượn sách trong bảng HTML
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Book Title</th><th>User Name</th><th>Borrow Date</th><th>Return Date</th><th>Status</th></tr>");

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String bookTitle = rs.getString("book_title");
                    String userName = rs.getString("user_name");
                    String borrowDate = rs.getString("borrow_date");
                    String returnDate = rs.getString("return_date") != null ? rs.getString("return_date") : "N/A";
                    String status = rs.getString("status");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + bookTitle + "</td>");
                    out.println("<td>" + userName + "</td>");
                    out.println("<td>" + borrowDate + "</td>");
                    out.println("<td>" + returnDate + "</td>");
                    out.println("<td>" + status + "</td>");
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
