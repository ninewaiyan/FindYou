<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>Details</title>
<style>
body {
	background-color: #f8f9fa;
}

.container1 {
	margin: 80px auto;
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.flip-card {
	background-color: transparent;
	width: 100%;
	height: 300px;
	perspective: 1000px;
	margin-bottom: 20px;
}

.flip-card-inner {
	position: relative;
	width: 100%;
	height: 100%;
	text-align: center;
	transition: transform 0.6s;
	transform-style: preserve-3d;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.flip-card:hover .flip-card-inner {
	transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
	position: absolute;
	width: 100%;
	height: 100%;
	backface-visibility: hidden;
	border-radius: 10px;
}

.flip-card-front {
	background-color: #ffffff;
	color: black;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.flip-card-front img {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.flip-card-back {
	background-color: #ff4b5c;
	color: white;
	transform: rotateY(180deg);
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.profile-info {
	text-align: center;
}

.profile-info h2 {
	font-size: 2rem;
	color: #333;
}

.profile-info p {
	font-size: 1rem;
	color: #777;
}

.btn-heart {
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #ff455;
	color: white;
	border: none;
	border-radius: 50%;
	width: 50px;
	height: 50px;
	cursor: pointer;
	transition: transform 0.2s;
}

.btn-heart:hover {
	transform: scale(1.1);
}

.btn-heart:active {
	transform: scale(0.95);
}

.old-photos {
	margin-top: 40px;
}

.old-photos h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

.card {
	border: none;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s;
}

.card:hover {
	transform: scale(1.05);
}

.card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}

.card-body {
	text-align: center;
	padding: 10px;
}

.bi {
	color: red;
}

.card-body p {
	margin: 0;
	color: #555;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<c:import url="../common/nav.jsp" />
		<div class="container1">
			<div class="row">
				<div class="col-md-12 mt-5">
					<div class="flip-card">
						<div class="flip-card-inner">
							<div class="flip-card-front">
								<img
									src="${pageContext.request.contextPath}/template/user/images/${user.photo}"
									alt="Profile Photo">
								<h2>${user.name}</h2>
							</div>
							<div class="flip-card-back">
								<h2>${user.name}</h2>
								<p>${user.batch },${user.gender }</p>
								<p class="text-center">
									Age: <span id="age"></span>
								</p>
								<p>${user.description}</p>
								<button
									onclick="Toggle(); window.location.href='user?mode=FLIP&id=${user.id}';"
									class="btn-heart">
									<i class="bi bi-heart-fill"></i>
								</button>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="old-photos">
		<h2>Old Profile Photos</h2>
		<div class="container">
			<div class="row">
				<c:forEach var="photo" items="${userPhotos}">
					<div class="col-md-3 mb-4">
						<div class="card">
							<img
								src="${pageContext.request.contextPath}/template/user/images/${photo.photo}"
								alt="Old Profile Photo">
							<div class="card-body">
								<p>${user.name}</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script>
		var btnh = document.querySelector('.btn-heart');
		function Toggle() {
			if (btnh.style.color == "red") {
				btnh.style.color = "white";
			} else {
				btnh.style.color = "red";
			}
		}
	</script>
	
	<script>
		function calculateAge(birthday) {
			const birthDate = new Date(birthday);
			const today = new Date();
			let age = today.getFullYear() - birthDate.getFullYear();
			const monthDiff = today.getMonth() - birthDate.getMonth();
			if (monthDiff < 0
					|| (monthDiff === 0 && today.getDate() < birthDate
							.getDate())) {
				age--;
			}
			return age;
		}

		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							const birthday = "${user.birthday}";
							if (birthday) {
								document.getElementById("age").textContent = calculateAge(birthday);
							}
						});
	</script>
</body>
</html>
