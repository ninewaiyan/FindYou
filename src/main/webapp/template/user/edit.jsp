<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: linear-gradient(to right, #FF9A8B, #FFB6C1);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: #333;
}

.container {
	background: #ffffff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
	max-width: 900px;
	margin: 0 auto;
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
	background-color: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	color: #fff;
	font-size: 16px;
	opacity: 0;
	transition: opacity 0.3s ease;
	border-radius: 50%;
}

.profile-image-wrapper:hover .overlay {
	opacity: 1;
}

.form-control {
	border-radius: 8px;
	box-shadow: none;
}

.btn-primary {
	background-color: #FF6F61;
	border: none;
	border-radius: 8px;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #FF9A8B;
}

.alert {
	border-radius: 8px;
}

.form-label {
	font-weight: bold;
}

.mb-3 {
	margin-bottom: 1.5rem;
}

.text-center {
	margin-bottom: 20px;
}

textarea.form-control {
	height: 150px;
}

input[type="file"] {
	display: none;
}

.row .col-md-6 {
	margin-bottom: 20px;
}

@media ( max-width : 767px) {
	.row .col-md-6 {
		margin-bottom: 20px;
		width: 100%;
	}
	.profile-image-wrapper {
		width: 120px;
		height: 120px;
		margin: 0 auto 15px;
	}
}
</style>
</head>
<body>

	<div class="container mt-5">
		<h2 class="text-center mb-4">Edit Profile</h2>
		<div class="profile-image-wrapper">
			<img id="profile-image"
				src="${pageContext.request.contextPath}/template/user/images/${user.photo}"
				alt="Profile Image">
			<div class="overlay" onclick="triggerFileInput()">Update Photo</div>
		</div>

		<!-- Success or Error Messages -->
		<c:if test="${not empty ok}">
			<c:choose>
				<c:when test="${ok}">
					<div class="alert alert-success">${message}</div>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger">${message}</div>
				</c:otherwise>
			</c:choose>
		</c:if>

		<!-- Profile Form -->
		<form action="user" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mode" value="UPDATE">
			<input type="hidden" name="id" value="${user.id}">
			<input type="hidden" name="old_photo" value="${user.photo}">
			
			
			 <input type="file" id="image-upload" name="photo" accept="image/*"
				class="form-control" onchange="previewImage(event)">

			<!-- Form Fields in Two Columns -->
			<div class="row">
				<!-- First Column (Left side) -->
				<div class="col-md-6">
					<!-- Name Field -->
					<div class="mb-3">
						<label for="name" class="form-label">Name:</label> <input
							type="text" class="form-control" id="name" name="name"
							value="${user.name}" required>
					</div>

					<!-- Date of Birth -->
					<div class="mb-3">
						<label for="birthday" class="form-label">Date of Birth:</label> <input
							type="date" class="form-control" id="birthday" name="birthday"
							value="${user.birthday}">
					</div>


					<!-- Bio Field -->
					<div class="mb-3">
						<label for="bio" class="form-label">Bio:</label> <input
							type="text" class="form-control" value="${user.bio}" id="bio"
							name="bio">
					</div>





					<!-- Facebook Link -->
					<div class="mb-3">
						<label for="fbLink" class="form-label">Facebook Profile
							Link:</label> <input type="text" class="form-control" id="fbLink"
							name="fbLink" value="${user.fbLink}">
					</div>

					<!-- TikTok Link -->
					<div class="mb-3">
						<label for="ttLink" class="form-label">TikTok Link:</label> <input
							type="text" class="form-control" id="ttLink" name="ttLink"
							value="${user.ttLink}">
					</div>
				</div>




				<!-- Second Column (Right side) -->
				<div class="col-md-6">

					<!-- Gender Dropdown -->
					<div class="mb-3">
						<label for="phone" class="form-label">Phone Number</label> 
						<input
							type="phone" class="form-control" id="" name="phone"
							value="${user.phone}">
						
					</div>




					<!-- Hobby Field -->
					<div class="mb-3">
						<label for="hobby" class="form-label">Hobby:</label> <input
							type="text" class="form-control" id="hobby" name="hobby"
							value="${user.hobby}">
					</div>

					<!-- Batch Dropdown -->
					<div class="mb-3">
						<label for="batch" class="form-label">Batch:</label> <select
							class="form-select" id="batch" name="batch_id">
							<c:forEach var="batch" items="${batches}">
								<option value="${batch.id}"
									<c:if test="${batch.id == user.batch_id}">selected</c:if>>${batch.batch}</option>
							</c:forEach>
						</select>
					</div>

					<!-- Instagram Link -->
					<div class="mb-3">
						<label for="igLink" class="form-label">Instagram Link:</label> <input
							type="text" class="form-control" id="igLink" name="igLink"
							value="${user.igLink}">
					</div>


					<!-- Telegram Link -->
					<div class="mb-3">
						<label for="tgLink" class="form-label">Telegram Link:</label> <input
							type="text" class="form-control" id="tgLink" name="tgLink"
							value="${user.tgLink}">
					</div>
				</div>
			</div>

			<!-- Description Field -->
			<div class="mb-3">
				<label for="description" class="form-label">Description:</label>
				<textarea class="form-control" id="description" name="description">${user.description}</textarea>
			</div>

			<!-- Submit Button -->
			<button type="submit" class="btn btn-primary w-100">Update
				Profile</button>
		</form>
	</div>

	<!-- Scripts -->
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
