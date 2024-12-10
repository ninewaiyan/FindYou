<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #cfd0d2;
            color: #fff;
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #cfd0d2;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.8);
            border: none;
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #ff758c;
            border: none;
        }
        .btn-primary:hover {
            background-color: #ff7eb3;
        }
        .form-label {
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Login</h2>
        <c:if test="${not empty ok}">
			<c:choose>
				<c:when test="${ok}">
					<div class="alert alert-success">
						${message}</div>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger">${message}</div>
				</c:otherwise>
			</c:choose>
		</c:if>
        <form action="login" method="post">
            <div class="mb-3">
            	<input type="hidden" name="mode" value="LOGIN">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" id="email" name="email" value="${email}" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" name="password" value="${password}" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
            <a href="user" class="text-dark">Register</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
