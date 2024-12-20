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
        .btn-edit {
            color: #0d6efd;
            border-color: #0d6efd;
        }
        .btn-edit:hover {
            background-color: #0d6efd;
            color: white;
        }
        .btn-delete {
            color: #dc3545;
            border-color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #dc3545;
            color: white;
        }
        .table th {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fas fa-book-reader"></i> Library Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
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
                                        <button class="btn btn-sm btn-edit" onclick="editBorrowing(${borrowing.id}, '${borrowing.bookTitle}', '${borrowing.userName}', '${borrowing.borrowDate}', '${borrowing.returnDate}', '${borrowing.status}')">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-delete" onclick="deleteBorrowing(${borrowing.id}, '${borrowing.bookTitle}')">
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
    <div class="modal fade" id="addBorrowingModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Borrowing</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="dashboard" method="post" id="addBorrowingForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="addBorrowing">
                        <div class="mb-3">
                            <label for="bookId" class="form-label">Book</label>
                            <select class="form-select" id="bookId" name="bookId" required>
                                <c:forEach var="book" items="${availableBooks}">
                                    <option value="${book.id}">${book.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="userId" class="form-label">User</label>
                            <select class="form-select" id="userId" name="userId" required>
                                <c:forEach var="user" items="${users}">
                                    <option value="${user.id}">${user.fullName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="borrowDate" class="form-label">Borrow Date</label>
                            <input type="date" class="form-control" id="borrowDate" name="borrowDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="returnDate" class="form-label">Return Date</label>
                            <input type="date" class="form-control" id="returnDate" name="returnDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="Borrowed">Borrowed</option>
                                <option value="Returned">Returned</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Borrowing</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Borrowing Modal -->
    <div class="modal fade" id="editBorrowingModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Borrowing</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="dashboard" method="post" id="editBorrowingForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updateBorrowing">
                        <input type="hidden" name="id" id="editBorrowingId">
                        <div class="mb-3">
                            <label for="editBookTitle" class="form-label">Book Title</label>
                            <input type="text" class="form-control" id="editBookTitle" name="bookTitle" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editUserName" class="form-label">User Name</label>
                            <input type="text" class="form-control" id="editUserName" name="userName" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editBorrowDate" class="form-label">Borrow Date</label>
                            <input type="date" class="form-control" id="editBorrowDate" name="borrowDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="editReturnDate" class="form-label">Return Date</label>
                            <input type="date" class="form-control" id="editReturnDate" name="returnDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="editStatus" class="form-label">Status</label>
                            <select class="form-select" id="editStatus" name="status" required>
                                <option value="Borrowed">Borrowed</option>
                                <option value="Returned">Returned</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Borrowing</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Borrowing Modal -->
    <div class="modal fade" id="deleteBorrowingModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Borrowing</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="dashboard" method="post" id="deleteBorrowingForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="deleteBorrowing">
                        <input type="hidden" name="id" id="deleteBorrowingId">
                        <p>Are you sure you want to delete the borrowing for "<span id="deleteBorrowingBook"></span>"?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editBorrowing(id, bookTitle, userName, borrowDate, returnDate, status) {
            document.getElementById('editBorrowingId').value = id;
            document.getElementById('editBookTitle').value = bookTitle;
            document.getElementById('editUserName').value = userName;
            document.getElementById('editBorrowDate').value = borrowDate;
            document.getElementById('editReturnDate').value = returnDate;
            document.getElementById('editStatus').value = status;
            new bootstrap.Modal(document.getElementById('editBorrowingModal')).show();
        }

        function deleteBorrowing(id, bookTitle) {
            document.getElementById('deleteBorrowingId').value = id;
            document.getElementById('deleteBorrowingBook').textContent = bookTitle;
            new bootstrap.Modal(document.getElementById('deleteBorrowingModal')).show();
        }
    </script>
</body>
</html>