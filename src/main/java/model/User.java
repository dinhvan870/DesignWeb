package model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String username;
    private String fullName;
    private String role;
    private Timestamp createdAt;

    public User(int id, String username, String fullName, String role, Timestamp createdAt) {
        this.id = id;
        this.username = username;
        this.fullName = fullName;
        this.role = role;
        this.createdAt = createdAt;
    }

    // Getters và Setters (nếu cần)
}
