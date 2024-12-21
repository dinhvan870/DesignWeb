package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import database.DBConnection;
import model.Borrowing;

public class BorrowingDAO {
    
    public List<Borrowing> getAllBorrowings() throws SQLException {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT b.*, bo.title as book_title, u.username as user_name " +
                     "FROM Borrowings b " +
                     "JOIN Books bo ON b.book_id = bo.id " +
                     "JOIN Users u ON b.user_id = u.id";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                borrowings.add(extractBorrowingFromResultSet(rs));
            }
        }
        return borrowings;
    }

    public Borrowing getBorrowingById(int id) throws SQLException {
        String sql = "SELECT b.*, bo.title as book_title, u.username as user_name " +
                     "FROM Borrowings b " +
                     "JOIN Books bo ON b.book_id = bo.id " +
                     "JOIN Users u ON b.user_id = u.id " +
                     "WHERE b.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractBorrowingFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public void addBorrowing(Borrowing borrowing) throws SQLException {
        String sql = "INSERT INTO Borrowings (book_id, user_id, borrow_date, return_date, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, borrowing.getBookId());
            pstmt.setInt(2, borrowing.getUserId());
            pstmt.setDate(3, borrowing.getBorrowDate());
            pstmt.setDate(4, borrowing.getReturnDate());
            pstmt.setString(5, borrowing.getStatus());
            pstmt.executeUpdate();
        }
    }

    public void updateBorrowing(Borrowing borrowing) throws SQLException {
        String sql = "UPDATE Borrowings SET book_id = ?, user_id = ?, borrow_date = ?, return_date = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, borrowing.getBookId());
            pstmt.setInt(2, borrowing.getUserId());
            pstmt.setDate(3, borrowing.getBorrowDate());
            pstmt.setDate(4, borrowing.getReturnDate());
            pstmt.setString(5, borrowing.getStatus());
            pstmt.setInt(6, borrowing.getId());
            pstmt.executeUpdate();
        }
    }

    public void deleteBorrowing(int id) throws SQLException {
        String sql = "DELETE FROM Borrowings WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }
    
    
    public static boolean addBorrowing(int bookId, int userId) throws SQLException {
        String sql = "INSERT INTO Borrowings (book_id, user_id, borrow_date, status) VALUES (?, ?, ?, 'Borrowed')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            pstmt.setInt(2, userId);
            pstmt.setDate(3, Date.valueOf(LocalDate.now()));
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                // Update book status
                String updateBookSql = "UPDATE Books SET status = 'Borrowed' WHERE id = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateBookSql)) {
                    updateStmt.setInt(1, bookId);
                    updateStmt.executeUpdate();
                }
                return true;
            }
            return false;
        }
    }

    private Borrowing extractBorrowingFromResultSet(ResultSet rs) throws SQLException {
        Borrowing borrowing = new Borrowing();
        borrowing.setId(rs.getInt("id"));
        borrowing.setBookId(rs.getInt("book_id"));
        borrowing.setUserId(rs.getInt("user_id"));
        borrowing.setBorrowDate(rs.getDate("borrow_date"));
        borrowing.setReturnDate(rs.getDate("return_date"));
        borrowing.setStatus(rs.getString("status"));
        borrowing.setBookTitle(rs.getString("book_title"));
        borrowing.setUserName(rs.getString("user_name"));
        return borrowing;
    }
    
    public void deleteAllBorrowingByUserId(int userId) throws SQLException {
        String sql = "DELETE FROM Borrowings WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        }
    }
}
