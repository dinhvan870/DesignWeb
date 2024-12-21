<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --info-color: #36b9cc;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
        }
        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', sans-serif;
        }
        .navbar {
            background-color: white !important;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15) !important;
        }
        .navbar-brand {
            color: var(--primary-color) !important;
            font-weight: 700;
            font-size: 1.5rem;
        }
        .nav-link {
            color: var(--secondary-color) !important;
            font-weight: 700;
        }
        .nav-link:hover, .nav-link.active {
            color: var(--primary-color) !important;
        }
        .card {
            border: none;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15) !important;
        }
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
        }
        .card-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 0;
        }
        .stats-card {
            border-left: 0.25rem solid;
            transition: all 0.3s ease-in-out;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .stats-card.primary {
            border-left-color: var(--primary-color);
        }
        .stats-card.success {
            border-left-color: var(--success-color);
        }
        .stats-card.info {
            border-left-color: var(--info-color);
        }
        .stats-card.warning {
            border-left-color: var(--warning-color);
        }
        .stats-icon {
            font-size: 2rem;
            opacity: 0.4;
        }
        .table {
            color: var(--secondary-color);
        }
        .table thead th {
            background-color: #f8f9fc;
            color: var(--primary-color);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.8rem;
            border-top: none;
        }
        .badge {
            font-weight: 600;
            font-size: 0.75rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fas fa-book-reader me-2"></i>Library Management</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
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

    <div class="container-fluid mt-4">
        <h1 class="h3 mb-4 text-gray-800">Dashboard</h1>
        
        <div class="row">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stats-card primary h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Books</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalBooks}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-book fa-2x text-gray-300 stats-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stats-card success h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Users</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalUsers}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-users fa-2x text-gray-300 stats-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stats-card info h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Borrowings</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalBorrowings}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-handshake fa-2x text-gray-300 stats-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card stats-card warning h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Clients</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">${totalClients}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-user-circle fa-2x text-gray-300 stats-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="card-title m-0 font-weight-bold"><i class="fas fa-chart-pie me-2"></i>Book Status Distribution</h6>
                    </div>
                    <div class="card-body">
                        <canvas id="bookStatusChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="card-title m-0 font-weight-bold"><i class="fas fa-chart-bar me-2"></i>Monthly Borrowings</h6>
                    </div>
                    <div class="card-body">
                        <canvas id="monthlyBorrowingsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="card-title m-0 font-weight-bold"><i class="fas fa-book me-2"></i>Recent Books</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${recentBooks}">
                                        <tr>
                                            <td>${book.title}</td>
                                            <td>${book.author}</td>
                                            <td>
                                                <span class="badge bg-${book.status == 'Available' ? 'success' : 'warning'}">
                                                    ${book.status}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="card-title m-0 font-weight-bold"><i class="fas fa-handshake me-2"></i>Recent Borrowings</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>Book</th>
                                        <th>User</th>
                                        <th>Borrow Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="borrowing" items="${recentBorrowings}">
                                        <tr>
                                            <td>${borrowing.bookTitle}</td>
                                            <td>${borrowing.userName}</td>
                                            <td>${borrowing.borrowDate}</td>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Book Status Distribution Chart
        var ctxPie = document.getElementById('bookStatusChart').getContext('2d');
        var myPieChart = new Chart(ctxPie, {
            type: 'pie',
            data: {
                labels: ['Available', 'Borrowed'],
                datasets: [{
                    data: [${availableBooks}, ${borrowedBooks}],
                    backgroundColor: ['#1cc88a', '#f6c23e'],
                    hoverBackgroundColor: ['#17a673', '#f4b619'],
                    hoverBorderColor: "rgba(234, 236, 244, 1)",
                }],
            },
            options: {
                maintainAspectRatio: false,
                tooltips: {
                    backgroundColor: "rgb(255,255,255)",
                    bodyFontColor: "#858796",
                    borderColor: '#dddfeb',
                    borderWidth: 1,
                    xPadding: 15,
                    yPadding: 15,
                    displayColors: false,
                    caretPadding: 10,
                },
                legend: {
                    display: false
                },
                cutoutPercentage: 80,
            },
        });

        // Monthly Borrowings Chart
        var ctxBar = document.getElementById("monthlyBorrowingsChart").getContext('2d');
        var myBarChart = new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                datasets: [{
                    label: "Borrowings",
                    backgroundColor: "#4e73df",
                    hoverBackgroundColor: "#2e59d9",
                    border
                    
                    </script>