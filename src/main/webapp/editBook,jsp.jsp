<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container my-5">
        <h1 class="text-center">Edit Book</h1>
        <form action="/books/update" method="post" class="mt-4">
            <input type="hidden" name="id" value="${book.id}">
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" id="title" name="title" class="form-control" value="${book.title}" required>
            </div>
            <div class="mb-3">
                <label for="author" class="form-label">Author</label>
                <input type="text" id="author" name="author" class="form-control" value="${book.author}" required>
            </div>
            <div class="mb-3">
                <label for="published_year" class="form-label">Published Year</label>
                <input type="number" id="published_year" name="published_year" class="form-control" value="${book.publishedYear}" required>
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select id="status" name="status" class="form-select">
                    <option value="Available" <c:if test="${book.status == 'Available'}">selected</c:if>>Available</option>
                    <option value="Borrowed" <c:if test="${book.status == 'Borrowed'}">selected</c:if>>Borrowed</option>
                </select>
            </div>
            <div class="d-flex justify-content-between">
                <a href="/books" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">Update</button>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
