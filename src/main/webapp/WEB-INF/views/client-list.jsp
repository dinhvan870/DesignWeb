<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client List - Library Management System</title>
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
                        <a class="nav-link" href="dashboard?action=borrowings">Borrowings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard?action=clients">Clients</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Client List</h1>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addClientModal">
                <i class="fas fa-plus"></i> Add New Client
            </button>
        </div>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Birth Date</th>
                                <th>City</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="client" items="${clients}">
                                <tr>
                                    <td>${client.id}</td>
                                    <td>${client.fullName}</td>
                                    <td>${client.email}</td>
                                    <td><fmt:formatDate value="${client.birthDate}" pattern="yyyy-MM-dd" /></td>
                                    <td>${client.city}</td>
                                    <td>
                                        <button class="btn btn-sm btn-edit" onclick="editClient(${client.id}, '${client.fullName}', '${client.email}', '${client.birthDate}', '${client.city}')">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-delete" onclick="deleteClient(${client.id}, '${client.fullName}')">
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

    <!-- Add Client Modal -->
    <div class="modal fade" id="addClientModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Client</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="dashboard" method="post" id="addClientForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="addClient">
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="birthDate" class="form-label">Birth Date</label>
                            <input type="date" class="form-control" id="birthDate" name="birthDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="city" class="form-label">City</label>
                            <input type="text" class="form-control" id="city" name="city" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Client</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Client Modal -->
    <div class="modal fade" id="editClientModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Client</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="dashboard" method="post" id="editClientForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updateClient">
                        <input type="hidden" name="id" id="editClientId">
                        <div class="mb-3">
                            <label for="editFullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="editFullName" name="fullName" required>
                        </div>
                        <div class="mb-3">
                            <label for="editEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="editBirthDate" class="form-label">Birth Date</label>
                            <input type="date" class="form-control" id="editBirthDate" name="birthDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="editCity" class="form-label">City</label>
                            <input type="text" class="form-control" id="editCity" name="city" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Client</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Client Modal -->
    <div class="modal fade" id="deleteClientModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Client</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="dashboard" method="post" id="deleteClientForm">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="deleteClient">
                        <input type="hidden" name="id" id="deleteClientId">
                        <p>Are you sure you want to delete the client "<span id="deleteClientName"></span>"?</p>
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
        function editClient(id, fullName, email, birthDate, city) {
            document.getElementById('editClientId').value = id;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editEmail').value = email;
            document.getElementById('editBirthDate').value = birthDate;
            document.getElementById('editCity').value = city;
            new bootstrap.Modal(document.getElementById('editClientModal')).show();
        }

        function deleteClient(id, fullName) {
            document.getElementById('deleteClientId').value = id;
            document.getElementById('deleteClientName').textContent = fullName;
            new bootstrap.Modal(document.getElementById('deleteClientModal')).show();
        }
    </script>
</body>
</html>