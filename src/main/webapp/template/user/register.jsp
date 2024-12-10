<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Form</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #cfd0d2;
	color:#333333;
	font-family: 'Arial', sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.container {
	background:#e4c1c7;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 500px;
	width: 100%;
}

.profile-image-wrapper {
	position: relative;
	width: 150px;
	height: 150px;
	margin: 0 auto 20px;
	border-radius: 50%;
	overflow: hidden;
	cursor: pointer;
}

.profile-image-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: opacity 0.3s ease;
}

.profile-image-wrapper .overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
	color: white;
	opacity: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 18px;
	transition: opacity 0.3s ease;
	border-radius: 50%;
}

.profile-image-wrapper:hover .overlay {
	opacity: 1;
}

#image-upload {
	display: none;
}

.btn-primary {
	background-color: #ff758c;
	border: none;
}

.btn-primary:hover {
	background-color: #ff7eb3;
}
</style>
</head>
<body>
	<div class="container mt-5">
		<h3 class="text-center">Register</h3>
		<div class="profile-image-wrapper">
			<img id="profile-image"
				src="${pageContext.request.contextPath}/template/user/images/upload.png"
				alt="Profile Image">
			<div class="overlay" onclick="triggerFileInput()">Update
				Profile</div>
		</div>
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
		<form action="user" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mode" value="REGISTER"> <input
				type="file" id="image-upload" name="photo" accept="image/*"
				class="form-control" onchange="previewImage(event)" required>
			<div class="mb-1">
				<label for="name" class="form-label">Name:</label> <input
					type="text" class="form-control" id="name" name="name" value="${name}"required>
			</div>
			<div class="mb-1">
				<label for="email" class="form-label">Email:</label> <input
					type="email" class="form-control" id="email" name="email" value="${email}"required>
			</div>
			<div class="mb-1">
				<label for="password" class="form-label">Password:</label> <input
					type="password" class="form-control" id="password" name="password"
					required>
			</div>
			<div class="mb-1">
				<label for="gender" class="form-label">Gender:</label> <select
					class="form-select" id="gender" name="gender" required>
					<option value="Male">Male</option>
					<option value="Female">Female</option>
					<option value="Other">Other</option>
				</select>
			</div>
			
			<div class="mb-1">
				<label for="batch" class="form-label">Batch:</label> <select
					class="form-select" id="batch" name="batch_id" required>
					<c:forEach var="batch" items="${batches}">
						<option value="${batch.id}">${batch.batch }</option>
					</c:forEach>
				</select>
			</div>
			<button type="submit" class="btn w-100" style="background: linear-gradient(109.6deg, rgb(245, 239, 249) 30.1%, rgb(207, 211, 236) 100.2%);">Register</button>
			<div class="col-md-3">
			<a href="login" class="text-dark">Login</a>
			</div>
		</form>
	</div>
	<script>
		function triggerFileInput() {
			document.getElementById('image-upload').click();
		}
		function previewImage(event) {
			const file = event.target.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('profile-image').src = e.target.result;
				}
				reader.readAsDataURL(file);
			}
		}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
