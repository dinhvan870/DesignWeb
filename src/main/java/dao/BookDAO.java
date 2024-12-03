package dao;

import model.Book;
import database.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/LibraryDB"; // Thay với tên schema
    private static final String USER = "root";  // Thay bằng user của bạn
    private static final String PASSWORD = "12345678";  // Thay bằng password của bạn

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String query = "SELECT * FROM Books";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                int publishedYear = resultSet.getInt("published_year");
                String status = resultSet.getString("status");

                books.add(new Book(id, title, author, publishedYear, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
}