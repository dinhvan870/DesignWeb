package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import database.DBConnection;
import model.Client;
import model.User;


public class UserDAO {
    
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        }
        return users;
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM Users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        }
        return null;
    }

  

    public void addUser(User user) throws SQLException {
        String sql = "INSERT INTO Users (username, password, full_name, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getFullName());
            pstmt.setString(4, user.getRole());
            pstmt.executeUpdate();
        }
    }

    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE Users SET username = ?, full_name = ?, role = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getFullName());
            pstmt.setString(3, user.getRole());
            pstmt.setInt(4, user.getId());
            pstmt.executeUpdate();
        }
    }

    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM Users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }


    
    public User authenticateUser(String username, String password) throws SQLException {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        }
        return null;
    }
    
  

    public static Client getClientByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM Clients WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Client(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("full_name"),
                        rs.getDate("birth_date"),
                        rs.getString("address"),
                        rs.getString("city"),
                        rs.getString("gender"),
                        rs.getString("occupation"),
                        rs.getString("delivery_method")
                    );
                }
            }
        }
        return null;
    }

    public static boolean updateClient(Client client) throws SQLException {
        String sql = "UPDATE Clients SET email=?, full_name=?, birth_date=?, address=?, city=?, gender=?, occupation=?, delivery_method=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, client.getEmail());
            pstmt.setString(2, client.getFullName());
            pstmt.setDate(3, client.getBirthDate());
            pstmt.setString(4, client.getAddress());
            pstmt.setString(5, client.getCity());
            pstmt.setString(6, client.getGender());
            pstmt.setString(7, client.getOccupation());
            pstmt.setString(8, client.getDeliveryMethod());
            pstmt.setInt(9, client.getId());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("full_name"),
            rs.getString("role"),
            rs.getTimestamp("created_at")
        );
    }
}

