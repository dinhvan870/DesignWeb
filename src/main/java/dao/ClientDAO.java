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

public class ClientDAO {
    
    public List<Client> getAllClients() throws SQLException {
        List<Client> clients = new ArrayList<>();
        String sql = "SELECT * FROM Clients";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                clients.add(extractClientFromResultSet(rs));
            }
        }
        return clients;
    }

    public Client getClientById(int id) throws SQLException {
        String sql = "SELECT * FROM Clients WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractClientFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public void addClient(Client client) throws SQLException {
        String sql = "INSERT INTO Clients (email, full_name, birth_date, address, city, gender, occupation, delivery_method) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
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
            pstmt.executeUpdate();
        }
    }

    public void updateClient(Client client) throws SQLException {
        String sql = "UPDATE Clients SET email = ?, full_name = ?, birth_date = ?, address = ?, city = ?, gender = ?, occupation = ?, delivery_method = ? WHERE id = ?";
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
            pstmt.executeUpdate();
        }
    }

    public void deleteClient(int id) throws SQLException {
        String sql = "DELETE FROM Clients WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    private Client extractClientFromResultSet(ResultSet rs) throws SQLException {
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
