<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSTL Test</title>
</head>
<body>
    <c:set var="testVar" value="Hello, JSTL!" />
    <p>Output: <c:out value="${testVar}" /></p>
</body>
</html>
