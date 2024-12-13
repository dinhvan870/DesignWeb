package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;

@WebServlet("/books")
public class BookListServlet extends HttpServlet {

    private static final long serialVersionUID = 3849460806986054510L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	System.out.println("123");
            List<Book> books = bookDAO.getAllBooks();
        	System.out.println("456");
            request.setAttribute("books", books);
        	System.out.println("45");
            request.getRequestDispatcher("booklist.jsp").forward(request, response);
        	System.out.println("4568");
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}