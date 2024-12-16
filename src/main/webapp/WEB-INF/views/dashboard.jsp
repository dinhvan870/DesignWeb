<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management Dashboard</title>
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
            transition: transform 0.3s;
            height: 100%;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-header {
            background-color: #007bff;
            color: white;
            border-radius: 10px 10px 0 0;
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
                        <a class="nav-link active" href="dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=books">Books</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=users">Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=borrowings">Borrowings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard?action=clients">Clients</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h1 class="mb-4">Dashboard</h1>
        
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4 mb-4">
            <div class="col">
                <div class="card text-center h-100">
                    <div class="card-header">
                        <i class="fas fa-book fa-3x"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Total Books</h5>
                        <p class="card-text display-4">${totalBooks}</p>
                        <a href="dashboard?action=books" class="btn btn-primary">View All Books</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center h-100">
                    <div class="card-header">
                        <i class="fas fa-users fa-3x"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Total Users</h5>
                        <p class="card-text display-4">${totalUsers}</p>
                        <a href="dashboard?action=users" class="btn btn-primary">View All Users</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center h-100">
                    <div class="card-header">
                        <i class="fas fa-handshake fa-3x"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Total Borrowings</h5>
                        <p class="card-text display-4">${totalBorrowings}</p>
                        <a href="dashboard?action=borrowings" class="btn btn-primary">View All Borrowings</a>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-center h-100">
                    <div class="card-header">
                        <i class="fas fa-user-friends fa-3x"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Total Clients</h5>
                        <p class="card-text display-4">${totalClients}</p>
                        <a href="dashboard?action=clients" class="btn btn-primary">View All Clients</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-lg-2 g-4">
            <div class="col">
                <div class="card h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-book"></i> Recent Books</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${recentBooks}" varStatus="loop">
                                        <c:if test="${loop.index < 5}">
                                            <tr>
                                                <td>${book.title}</td>
                                                <td>${book.author}</td>
                                                <td><span class="badge bg-${book.status == 'Available' ? 'success' : 'warning'}">${book.status}</span></td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-handshake"></i> Recent Borrowings</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Book</th>
                                        <th>User</th>
                                        <th>Borrow Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="borrowing" items="${recentBorrowings}" varStatus="loop">
                                        <c:if test="${loop.index < 5}">
                                            <tr>
                                                <td>${borrowing.bookTitle}</td>
                                                <td>${borrowing.userName}</td>
                                                <td>${borrowing.borrowDate}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

