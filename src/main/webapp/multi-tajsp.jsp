<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Multi-Table Display</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Multi-Table Data</h1>

        <h2>Books</h2>
        <table class="table table-bordered">
            <thead>
                <tr><th>ID</th><th>Title</th><th>Author</th><th>Published Year</th><th>Status</th></tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.publishedYear}</td>
                        <td>${book.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2>Users</h2>
        <table class="table table-bordered">
            <thead>
                <tr><th>ID</th><th>Username</th><th>Full Name</th><th>Role</th><th>Created At</th></tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.fullName}</td>
                        <td>${user.role}</td>
                        <td>${user.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2>Clients</h2>
        <table class="table table-bordered">
            <thead>
                <tr><th>ID</th><th>Email</th><th>Full Name</th><th>Birth Date</th><th>City</th><th>Gender</th></tr>
            </thead>
            <tbody>
                <c:forEach var="client" items="${clients}">
                    <tr>
                        <td>${client.id}</td>
                        <td>${client.email}</td>
                        <td>${client.fullName}</td>
                        <td>${client.birthDate}</td>
                        <td>${client.city}</td>
                        <td>${client.gender}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2>Borrowings</h2>
        <table class="table table-bordered">
            <thead>
                <tr><th>ID</th><th>Book Title</th><th>User Name</th><th>Borrow Date</
