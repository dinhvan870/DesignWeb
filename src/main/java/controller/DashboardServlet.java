package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.BookDAO;
import dao.BorrowingDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 127898480115568294L;
    private BookDAO bookDAO;
    private UserDAO userDAO;
    private BorrowingDAO borrowingDAO;

    public void init() {
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
        borrowingDAO = new BorrowingDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Book> books = bookDAO.getAllBooks();
            	
            	int totalBorrowers = userDAO.getTotalUsers();
            	int totalLoans = borrowingDAO.getTotalBorrowings();

//            	request.setAttribute("books", books);
            	request.setAttribute("totalBorrowers", totalBorrowers);
            	request.setAttribute("totalLoans", totalLoans);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error fetching dashboard data", e);
        }
    }
}