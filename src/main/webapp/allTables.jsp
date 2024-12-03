<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Bảng và Dữ liệu</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Danh sách Bảng và Dữ liệu</h1>

        <c:forEach var="table" items="${tables}">
            <h2 class="mt-4">${table}</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <c:forEach var="column" items="${tableData[table][0].keySet()}">
                            <th>${column}</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${tableData[table]}">
                        <tr>
                            <c:forEach var="column" items="${row.values()}">
                                <td>${column}</td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:forEach>
    </div>
</body>
</html>
