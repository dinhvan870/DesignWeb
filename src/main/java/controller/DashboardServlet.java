package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.BookDAO;
import dao.BorrowingDAO;
import dao.ClientDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import model.Borrowing;
import model.Client;
import model.User;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private UserDAO userDAO;
    private BorrowingDAO borrowingDAO;
    private ClientDAO clientDAO;

    public void init() {
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
        borrowingDAO = new BorrowingDAO();
        clientDAO = new ClientDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }

        try {
            switch (action) {
                case "dashboard":
                    showDashboard(request, response);
                    break;
                case "books":
                    listBooks(request, response);
                    break;
                case "users":
                    listUsers(request, response);
                    break;
                case "borrowings":
                    listBorrowings(request, response);
                    break;
                case "clients":
                    listClients(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error fetching data", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "addBook":
                    addBook(request, response);
                    break;
                case "updateBook":
                    updateBook(request, response);
                    break;
                case "deleteBook":
                    deleteBook(request, response);
                    break;
                case "addUser":
                    addUser(request, response);
                    break;
                case "updateUser":
                    updateUser(request, response);
                    break;
                case "deleteUser":
                    deleteUser(request, response);
                    break;
                case "addBorrowing":
                    addBorrowing(request, response);
                    break;
                case "updateBorrowing":
                    updateBorrowing(request, response);
                    break;
                case "deleteBorrowing":
                    deleteBorrowing(request, response);
                    break;
                case "addClient":
                    addClient(request, response);
                    break;
                case "updateClient":
                    updateClient(request, response);
                    break;
                case "deleteClient":
                    deleteClient(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing request", e);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Book> books = bookDAO.getAllBooks();
        List<User> users = userDAO.getAllUsers();
        List<Borrowing> borrowings = borrowingDAO.getAllBorrowings();
        List<Client> clients = clientDAO.getAllClients();

        request.setAttribute("totalBooks", books.size());
        request.setAttribute("totalUsers", users.size());
        request.setAttribute("totalBorrowings", borrowings.size());
        request.setAttribute("totalClients", clients.size());

        request.setAttribute("recentBooks", books.subList(0, Math.min(books.size(), 5)));
        request.setAttribute("recentUsers", users.subList(0, Math.min(users.size(), 5)));
        request.setAttribute("recentBorrowings", borrowings.subList(0, Math.min(borrowings.size(), 5)));
        request.setAttribute("recentClients", clients.subList(0, Math.min(clients.size(), 5)));

        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Book> books = bookDAO.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/WEB-INF/views/book-list.jsp").forward(request, response);
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/user-list.jsp").forward(request, response);
    }

    private void listBorrowings(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Borrowing> borrowings = borrowingDAO.getAllBorrowings();
        request.setAttribute("borrowings", borrowings);
        request.getRequestDispatcher("/WEB-INF/views/borrowing-list.jsp").forward(request, response);
    }

    private void listClients(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Client> clients = clientDAO.getAllClients();
        request.setAttribute("clients", clients);
        request.getRequestDispatcher("/WEB-INF/views/client-list.jsp").forward(request, response);
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int publishedYear = Integer.parseInt(request.getParameter("publishedYear"));
        String status = request.getParameter("status");
        Book newBook = new Book(0, title, author, publishedYear, status);
        bookDAO.addBook(newBook);
        response.sendRedirect("dashboard?action=books");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int publishedYear = Integer.parseInt(request.getParameter("publishedYear"));
        String status = request.getParameter("status");
        Book book = new Book(id, title, author, publishedYear, status);
        bookDAO.updateBook(book);
        response.sendRedirect("dashboard?action=books");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookDAO.deleteBook(id);
        response.sendRedirect("dashboard?action=books");
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        User newUser = new User(0, username, password, fullName, role, null);
        userDAO.addUser(newUser);
        response.sendRedirect("dashboard?action=users");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        User user = new User(id, username, password, fullName, role, null);
        userDAO.updateUser(user);
        response.sendRedirect("dashboard?action=users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect("dashboard?action=users");
    }

    private void addBorrowing(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        java.sql.Date borrowDate = java.sql.Date.valueOf(request.getParameter("borrowDate"));
        java.sql.Date returnDate = java.sql.Date.valueOf(request.getParameter("returnDate"));
        String status = request.getParameter("status");
        Borrowing newBorrowing = new Borrowing(0, bookId, userId, borrowDate, returnDate, status, null, null);
        borrowingDAO.addBorrowing(newBorrowing);
        response.sendRedirect("dashboard?action=borrowings");
    }

    private void updateBorrowing(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        java.sql.Date borrowDate = java.sql.Date.valueOf(request.getParameter("borrowDate"));
        java.sql.Date returnDate = java.sql.Date.valueOf(request.getParameter("returnDate"));
        String status = request.getParameter("status");
        Borrowing borrowing = new Borrowing(id, bookId, userId, borrowDate, returnDate, status, null, null);
        borrowingDAO.updateBorrowing(borrowing);
        response.sendRedirect("dashboard?action=borrowings");
    }

    private void deleteBorrowing(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        borrowingDAO.deleteBorrowing(id);
        response.sendRedirect("dashboard?action=borrowings");
    }

    private void addClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        java.sql.Date birthDate = java.sql.Date.valueOf(request.getParameter("birthDate"));
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String gender = request.getParameter("gender");
        String occupation = request.getParameter("occupation");
        String deliveryMethod = request.getParameter("deliveryMethod");
        Client newClient = new Client(0, email, fullName, birthDate, address, city, gender, occupation, deliveryMethod);
        clientDAO.addClient(newClient);
        response.sendRedirect("dashboard?action=clients");
    }

    private void updateClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        java.sql.Date birthDate = java.sql.Date.valueOf(request.getParameter("birthDate"));
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String gender = request.getParameter("gender");
        String occupation = request.getParameter("occupation");
        String deliveryMethod = request.getParameter("deliveryMethod");
        Client client = new Client(id, email, fullName, birthDate, address, city, gender, occupation, deliveryMethod);
        clientDAO.updateClient(client);
        response.sendRedirect("dashboard?action=clients");
    }

    private void deleteClient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        clientDAO.deleteClient(id);
        response.sendRedirect("dashboard?action=clients");
    }
}

