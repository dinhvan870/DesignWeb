package controller;

import java.awt.print.Book;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.xdevapi.Client;

import database.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Borrowing;
import model.User;

@WebServlet("/multi-table-display")
public class MultiTableServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> books = new ArrayList<>();
        List<User> users = new ArrayList<>();
        List<Client> clients = new ArrayList<>();
        List<Borrowing> borrowings = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // Lấy dữ liệu từ bảng Books
            String sqlBooks = "SELECT id, title, author, published_year, status FROM Books";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlBooks)) {
                while (rs.next()) {
                    books.add(new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("publishedYear"),
                        rs.getString("status")
                    ));
                }
            }

            // Lấy dữ liệu từ bảng Users
            String sqlUsers = "SELECT id, username, full_name, role, created_at FROM Users";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlUsers)) {
                while (rs.next()) {
                    users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at")
                    ));
                }
            }

            // Lấy dữ liệu từ bảng Clients
            String sqlClients = "SELECT id, email, full_name, birth_date, address, city, gender, occupation, delivery_method FROM Clients";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlClients)) {
                while (rs.next()) {
                    clients.add(new Client(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("full_name"),
                        rs.getDate("birth_date"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("gender"),
                        rs.getString("occupation"),
                        rs.getString("delivery_method")
                    ));
                }
            }

            // Lấy dữ liệu từ bảng Borrowings
            String sqlBorrowings = "SELECT b.id, b.book_id, bk.title AS book_title, b.user_id, u.username AS user_name, b.borrow_date, b.return_date, b.status " +
                                   "FROM Borrowings b " +
                                   "JOIN Books bk ON b.book_id = bk.id " +
                                   "JOIN Users u ON b.user_id = u.id";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sqlBorrowings)) {
                while (rs.next()) {
                    borrowings.add(new Borrowing(
                        rs.getInt("id"),
                        rs.getInt("book_id"),
                        rs.getString("book_title"),
                        rs.getInt("user_id"),
                        rs.getString("user_name"),
                        rs.getDate("borrow_date"),
                        rs.getDate("return_date"),
                        rs.getString("status")
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Đưa dữ liệu vào request
        request.setAttribute("books", books);
        request.setAttribute("users", users);
        request.setAttribute("clients", clients);
        request.setAttribute("borrowings", borrowings);

        // Chuyển sang JSP
        request.getRequestDispatcher("multi-table.jsp").forward(request, response);
    }
}
