<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book List - Library Management System</title>
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
                        <a class="nav-link active" href="dashboard?action=books">Books</a>
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Book List</h1>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                <i class="fas fa-plus"></i> Add New Book
            </button>
        </div>
        
        <div class="card">
            <div class="card-body">
                <form action="dashboard" method="get" class="mb-4">
                    <input type="hidden" name="action" value="books">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search books..." name="search" value="${param.search}">
                        <button class="btn btn-outline-secondary" type="submit">Search</button>
                    </div>
                </form>

                <c:if test="${empty books}">
                    <div class="alert alert-info" role="alert">
                        No books found. Please try a different search term.
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Published Year</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>${book.title}</td>
                                    <td>${book.author}</td>
                                    <td>${book.publishedYear}</td>
                                    <td><span class="badge bg-${book.status == 'Available' ? 'success' : 'warning'}">${book.status}</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editBookModal${book.id}">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteBookModal${book.id}">
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

    <!-- Add Book Modal -->
    <div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBookModalLabel">Add New Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="dashboard" method="post">
                        <input type="hidden" name="action" value="addBook">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="author" class="form-label">Author</label>
                            <input type="text" class="form-control" id="author" name="author" required>
                        </div>
                        <div class="mb-3">
                            <label for="publishedYear" class="form-label">Published Year</label>
                            <input type="number" class="form-control" id="publishedYear" name="publishedYear" required>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="Available">Available</option>
                                <option value="Borrowed">Borrowed</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Book</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Book Modal -->
    <c:forEach var="book" items="${books}">
        <div class="modal fade" id="editBookModal${book.id}" tabindex="-1" aria-labelledby="editBookModalLabel${book.id}" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editBookModalLabel${book.id}">Edit Book</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="dashboard" method="post">
                            <input type="hidden" name="action" value="updateBook">
                            <input type="hidden" name="id" value="${book.id}">
                            <div class="mb-3">
                                <label for="title${book.id}" class="form-label">Title</label>
                                <input type="text" class="form-control" id="title${book.id}" name="title" value="${book.title}" required>
                            </div>
                            <div class="mb-3">
                                <label for="author${book.id}" class="form-label">Author</label>
                                <input type="text" class="form-control" id="author${book.id}" name="author" value="${book.author}" required>
                            </div>
                            <div class="mb-3">
                                <label for="publishedYear${book.id}" class="form-label">Published Year</label>
                                <input type="number" class="form-control" id="publishedYear${book.id}" name="publishedYear" value="${book.publishedYear}" required>
                            </div>
                            <div class="mb-3">
                                <label for="status${book.id}" class="form-label">Status</label>
                                <select class="form-select" id="status${book.id}" name="status" required>
                                    <option value="Available" ${book.status == 'Available' ? 'selected' : ''}>Available</option>
                                    <option value="Borrowed" ${book.status == 'Borrowed' ? 'selected' : ''}>Borrowed</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Book</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- Delete Book Modal -->
    <c:forEach var="book" items="${books}">
        <div class="modal fade" id="deleteBookModal${book.id}" tabindex="-1" aria-labelledby="deleteBookModalLabel${book.id}" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteBookModalLabel${book.id}">Delete Book</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the book "${book.title}"?</p>
                        <form action="dashboard" method="post">
                            <input type="hidden" name="action" value="deleteBook">
                            <input type="hidden" name="id" value="${book.id}">
                            <button type="submit" class="btn btn-danger">Delete Book</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

