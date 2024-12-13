<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Library Management</h1>
        <div class="row mt-4">
            <!-- Card: Total Books -->
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-header">Total Books</div>
                    <div class="card-body">
                        <h5 class="card-title">${totalBooks}</h5>
                        <a href="<%=request.getContextPath()%>/books" class="btn btn-light">View Books</a>
                    </div>
                </div>
            </div>
            
            <!-- Card: Total Borrowers -->
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-header">Total Borrowers</div>
                    <div class="card-body">
                        <h5 class="card-title">${totalBorrowers}</h5>
                        <a href="<%=request.getContextPath()%>/users" class="btn btn-light">View Borrowers</a>
                    </div>
                </div>
            </div>
            
            <!-- Card: Total Loans -->
            <div class="col-md-4">
                <div class="card text-white bg-warning mb-3">
                    <div class="card-header">Total Loans</div>
                    <div class="card-body">
                        <h5 class="card-title">${totalLoans}</h5>
                        <a href="<%=request.getContextPath()%>/borrowings" class="btn btn-light">View Loans</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-12">
                <h2>Quick Actions</h2>
                <a href="<%=request.getContextPath()%>/books?action=new" class="btn btn-primary">Add New Book</a>
                <a href="<%=request.getContextPath()%>/users?action=new" class="btn btn-success">Add New Borrower</a>
                <a href="<%=request.getContextPath()%>/borrowings?action=new" class="btn btn-warning">Create New Loan</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>