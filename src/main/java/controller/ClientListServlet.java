package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;

import database.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/list-clients")
public class ClientListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // CSS Styling
            out.println("<html><head><style>");
            out.println("body { font-family: Arial, sans-serif; }");
            out.println("h1 { color: #007bff; }");
            out.println("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
            out.println("table, th, td { border: 1px solid #ddd; padding: 8px; }");
            out.println("th { background-color: #007bff; color: white; text-align: center; }");
            out.println("tr:nth-child(even) { background-color: #f2f2f2; }");
            out.println("</style></head><body>");

            out.println("<h1>Danh sách Khách hàng</h1>");

            // Kết nối cơ sở dữ liệu
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                Statement stmt = conn.createStatement();

                // Truy vấn danh sách khách hàng
                String query = "SELECT id, email, full_name, birth_date, address, city, gender, occupation, delivery_method FROM Clients";
                ResultSet rs = stmt.executeQuery(query);

                // Hiển thị danh sách khách hàng trong bảng HTML
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Email</th><th>Full Name</th><th>Birth Date</th><th>Address</th><th>City</th><th>Gender</th><th>Occupation</th><th>Delivery Method</th></tr>");
                
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String email = rs.getString("email");
                    String fullName = rs.getString("full_name");
                    Date birthDate = rs.getDate("birth_date");
                    String address = rs.getString("address");
                    String city = rs.getString("city");
                    String gender = rs.getString("gender");
                    String occupation = rs.getString("occupation");
                    String deliveryMethod = rs.getString("delivery_method");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + fullName + "</td>");
                    out.println("<td>" + (birthDate != null ? birthDate.toString() : "N/A") + "</td>");
                    out.println("<td>" + address + "</td>");
                    out.println("<td>" + city + "</td>");
                    out.println("<td>" + gender + "</td>");
                    out.println("<td>" + occupation + "</td>");
                    out.println("<td>" + deliveryMethod + "</td>");
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
