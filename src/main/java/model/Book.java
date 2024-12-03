package model;

public class Book {
    private int id;
    private String title;
    private String author;
    private int publishedYear;
    private String status;

    public Book(int id, String title, String author, int publishedYear, String status) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.publishedYear = publishedYear;
        this.status = status;
    }

}
