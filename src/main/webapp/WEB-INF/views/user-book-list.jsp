<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            background: linear-gradient(145deg, #ffffff, #f5f7fa);
        }
        .profile-header {
            background: linear-gradient(145deg, #007bff, #0056b3);
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
        }
        .profile-info {
            padding: 20px;
        }
        .info-item {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .info-label {
            font-weight: 600;
            color: #6c757d;
        }
        .books-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .table {
            margin-bottom: 0;
        }
        .borrow-btn {
            transition: all 0.3s ease;
        }
        .borrow-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-book-reader"></i> Library Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/user">Dashboard</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="profile-card">
                    <div class="profile-header">
                        <h4 class="mb-0"><i class="fas fa-user-circle"></i> User Profile</h4>
                    </div>
                    <div class="profile-info">
                        <div class="info-item">
                            <div class="info-label">Full Name</div>
                            <div>${client.fullName}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <div>${client.email}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Address</div>
                            <div>${client.address}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">City</div>
                            <div>${client.city}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Gender</div>
                            <div>${client.gender}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Occupation</div>
                            <div>${client.occupation}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Delivery Method</div>
                            <div>${client.deliveryMethod}</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <div class="books-card">
                    <div class="card-body">
                        <h4 class="mb-4"><i class="fas fa-books"></i> Available Books</h4>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Published Year</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${books}">
                                        <tr>
                                            <td>${book.title}</td>
                                            <td>${book.author}</td>
                                            <td>${book.publishedYear}</td>
                                            <td>
                                                <button class="btn btn-sm btn-primary borrow-btn" data-book-id="${book.id}">
                                                    <i class="fas fa-book"></i> Borrow
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
        </div>
    </div>

    <div class="toast-container"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const borrowButtons = document.querySelectorAll('.borrow-btn');
            
            function showToast(message, type = 'success') {
                const toastContainer = document.querySelector('.toast-container');
                var toastHtml = `
                    <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header bg-success text-white">
                            <strong class="me-auto">Library System</strong>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                        </div>
                        <div class="toast-body">
                            Undefined message
                        </div>
                    </div>
                `;
                toastHtml = toastHtml.replace(/Undefined message/g, message);
                toastHtml = toastHtml.replace(/bg-success/g, 'bg-'+type);
                toastContainer.innerHTML = toastHtml;

                setTimeout(() => {
                    const toast = document.querySelector('.toast');
                    if (toast) {
                        toast.remove();
                    }
                }, 3000);
            }

            borrowButtons.forEach(button => {
                button.addEventListener('click', function() {
                	const bookId = this.getAttribute('data-book-id');

                    const row = this.closest('tr');
                    const formData = new FormData();
                    formData.append('bookId', bookId);
                    formData.append('action', 'borrow');

                    fetch(`${pageContext.request.contextPath}/user?action=borrow`, {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.text())
                    .then(data => {
                    	
                        showToast(data);
                        row.remove(); // Remove the book from the list
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showToast('An error occurred. Please try again.', 'danger');
                    });
                });
            });
        });
    </script>
</body>
</html>