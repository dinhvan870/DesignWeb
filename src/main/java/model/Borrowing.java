package model;

import java.sql.Date;

public class Borrowing {
    private int id;
    private int bookId;
    private int userId;
    private Date borrowDate;
    private Date returnDate;
    private String status;
    private String bookTitle;
    private String userName;

    public Borrowing() {}

    public Borrowing(int id, int bookId, int userId, Date borrowDate, Date returnDate, String status, String bookTitle, String userName) {
        this.id = id;
        this.bookId = bookId;
        this.userId = userId;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
        this.bookTitle = bookTitle;
        this.userName = userName;
    }

    // Getter methods
    public int getId() { return id; }
    public int getBookId() { return bookId; }
    public int getUserId() { return userId; }
    public Date getBorrowDate() { return borrowDate; }
    public Date getReturnDate() { return returnDate; }
    public String getStatus() { return status; }
    public String getBookTitle() { return bookTitle; }
    public String getUserName() { return userName; }

    // Setter methods
    public void setId(int id) { this.id = id; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setBorrowDate(Date borrowDate) { this.borrowDate = borrowDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    public void setStatus(String status) { this.status = status; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    public void setUserName(String userName) { this.userName = userName; }
}

