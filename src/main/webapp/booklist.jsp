<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Sách</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: auto;
        }
        th, td {
            border: 1px solid black;
            text-align: center;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">Danh sách Sách</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Tác giả</th>
                <th>Năm xuất bản</th>
                <th>Trạng thái</th>
            </tr>
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
</body>
</html>
