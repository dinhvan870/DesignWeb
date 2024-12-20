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
import jakarta.servlet.http.HttpSession;
import model.Book;
import model.Client;
import model.User;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if ("/logout".equals(pathInfo)) {
            handleLogout(request, response);
            return;
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Book> availableBooks = bookDAO.getAvailableBooks();
            request.setAttribute("books", availableBooks);
            
            Client client = UserDAO.getClientByUserId(user.getId());
            request.setAttribute("client", client);
            
            request.getRequestDispatcher("/WEB-INF/views/user-book-list.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving data", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("borrow".equals(action)) {
            handleBorrow(request, response);
        }
    }

    private void handleBorrow(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            boolean success = BorrowingDAO.addBorrowing(bookId, user.getId());
            if (success) {
                response.getWriter().write("Book borrowed successfully! You can pick it up from the library.");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Error borrowing book");
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error borrowing book");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}