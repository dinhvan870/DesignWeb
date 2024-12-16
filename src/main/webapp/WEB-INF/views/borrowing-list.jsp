<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrowing List - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .table {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-book-reader"></i> Library Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=books">Books</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=users">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard?action=borrowings">Borrowings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=clients">Clients</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Borrowing List</h1>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBorrowingModal">
                <i class="fas fa-plus"></i> Add New Borrowing
            </button>
        </div>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Book Title</th>
                                <th>User Name</th>
                                <th>Borrow Date</th>
                                <th>Return Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="borrowing" items="${borrowings}">
                                <tr>
                                    <td>${borrowing.id}</td>
                                    <td>${borrowing.bookTitle}</td>
                                    <td>${borrowing.userName}</td>
                                    <td><fmt:formatDate value="${borrowing.borrowDate}" pattern="yyyy-MM-dd" /></td>
                                    <td><fmt:formatDate value="${borrowing.returnDate}" pattern="yyyy-MM-dd" /></td>
                                    <td><span class="badge bg-${borrowing.status == 'Returned' ? 'success' : 'warning'}">${borrowing.status}</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editBorrowingModal${borrowing.id}">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteBorrowingModal${borrowing.id}">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Borrowing Modal -->
    <div class="modal fade" id="addBorrowingModal" tabindex="-1" aria-labelledby="addBorrowingModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBorrowingModalLabel">Add New Borrowing</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="bookId" class="form-label">Book</label>
                            <select class="form-select" id="bookId" required>
                                <c:forEach var="book" items="${availableBooks}">
                                    <option value="${book.id}">${book.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="userId" class="form-label">User</label>
                            <select class="form-select" id="userId" required>
                                <c:forEach var="user" items="${users}">
                                    <option value="${user.id}">${user.fullName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="borrowDate" class="form-label">Borrow Date</label>
                            <input type="date" class="form-control" id="borrowDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="returnDate" class="form-label">Return Date</label>
                            <input type="date" class="form-control" id="returnDate" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Add Borrowing</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit and Delete modals would be similar to the Add Borrowing modal, but with pre-filled data and different actions -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

