package model;

import java.sql.Date;

public class Borrowing {
    private int id;
    private int bookId;
    private String bookTitle;
    private int userId;
    private String userName;
    private Date borrowDate;
    private Date returnDate;
    private String status;

    public Borrowing(int id, int bookId, String bookTitle, int userId, String userName, Date borrowDate, Date returnDate, String status) {
        this.id = id;
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.userId = userId;
        this.userName = userName;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
    }

    // Getters và Setters
}
