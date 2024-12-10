<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notification Board</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	background-color: #cfd0d2;
	background-blend-mode: multiply;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
}

@media ( max-width : 991px) {
	.sidebar {
		background-color: rgba(255, 182, 193, 0.15);
		backdrop-filter: blur(10px);
	}
}

.navbar-toggler {
	color: black;
}

.navbar {
	background-color: #e4c1c7;
}

a:hover {
	background-color: white;
	color: white;
}

.navbar-photo {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
}
/* Specific styles for the notification modal */
/* #offcanvasRight .offcanvas-body {
            display: flex;
            flex-direction: column;
        }
        */
        #offcanvasRight .notification-item {
           
            margin-top:0px;
        }
#offcanvasRight .notification-item img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}

.message {
	margin-left:15%;
}

.time {
	margin-left: 10%;
	margin-top:3px;
}
.btn-accept{
	background-color:purple;
}

#offcanvasRight .menu-buttons {
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 100%;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg fixed-top">
		<div class="container">
			<!-- Logo -->
			<b><a class="navbar-brand fs-4" href="home" style="color: #f94ca4;">FINDYOU</a></b>
			<!-- Toggle Btn -->
			<button class="navbar-toggler shadow-none border-0" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!-- SideBar -->
			<div class="sidebar offcanvas offcanvas-start" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<!-- sidebar Header -->
				<div class="offcanvas-header text-black border-bottom">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">FINDYOU</h5>
					<button type="button" class="btn-close btn-close-white shadow-none"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<!-- sidebar body -->
				<div
					class="offcanvas-body d-flex flex-column flex-lg-row p-4 p-lg-0">
					<ul
						class="navbar-nav justify-content-center align-items-center fs-5 flex-grow-1 pe-3">
						<li class="nav-item"><a class="text-black nav-link active"
							aria-current="page" href="home">Home</a></li>
						<li class="nav-item mx-2"><a class="text-black nav-link"
							href="user?mode=PROFILE&id=${sessionScope.user.id }">Profile</a></li>
						<li class="nav-item mx-2"><a class="text-black nav-link"
							href="user?mode=MATCH&id=${sessionScope.user.id }">Matches</a></li>
					</ul>
					<!-- Login / Sign Up -->
					<div
						class="d-flex flex-column flex-lg-row justify-content-center align-items-center gap-3 ">
						<a><img alt=""
							src="${pageContext.request.contextPath}/template/user/images/${sessionScope.user.photo}"
							class="navbar-photo"></a>
						<p>${sessionScope.user.name}</p>
						<p>
							<a class="text-black nav-link" href="#notifications"
								type="button" data-bs-toggle="offcanvas"
								data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
								<i class="fa-solid fa-bell"></i> <c:if test="${unseenCount > 0}">
									<span class="badge bg-danger">${unseenCount}</span>
								</c:if>
							</a>
						</p>
						<a href="login?mode=LOGOUT"
							class="text-black text-decoration-none px-3 py-1 rounded-4"
							style="background: linear-gradient(109.6deg, rgb(245, 239, 249) 30.1%, rgb(207, 211, 236) 100.2%);"><i
							class="bi bi-box-arrow-right"></i> LogOut</a>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvasRightLabel">Notifications</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">

			<c:forEach var="noti" items="${notis}">
				<div class="notification-item">
					<img alt=""
						src="${pageContext.request.contextPath}/template/user/images/${noti.sender.photo}"
						class="navbar-photo"> ${noti.sender.name}<small class="time" data-created-at="${noti.createdAt}">${noti.createdAt}</small>
						
					<div class ="message">
					
						<small class=""> ${noti.message} </small>
						
						<c:if test="${noti.type == 'flip'}">
						<a href="user?mode=ACCEPT&id=${noti.sender.id }"
							class="btn btn-accept btn-sm">Accept</a>
							<a href="user?mode=VIEW&id=${noti.sender.id }"
							class="btn btn-success btn-sm">View</a>
						</c:if>
						
						<c:if test="${noti.type == 'view'}">
						
						<a href="user?mode=VIEW&id=${noti.sender.id }"
							class="btn btn-success btn-sm">View</a>
						
						</c:if>
						
						<c:if test="${noti.type == 'accept'}">
						
						<a href="user?mode=ACCEPT&id=${noti.sender.id }"
							class="btn btn-success btn-sm">View</a>
						
						</c:if>
						  
					</div>
				</div>

			</c:forEach>
			<div class="menu-buttons mt-5">
				<a class="btn btn-primary w-100 mb-0 rounded-0"
					href="../feedbacks/create_feedback.php"><i
					class="fa-solid fa-message"></i> Feedback Us</a> <a
					class="btn btn-secondary w-100 mb-0 rounded-0"
					href="../users/logout.php"><i
					class="fa-solid fa-right-from-bracket"></i> Sign Out</a>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<script> document.addEventListener("DOMContentLoaded", function() { const timeElements = document.querySelectorAll(".time"); timeElements.forEach(function(element) { const createdAt = new Date(element.getAttribute("data-created-at")); const now = new Date();
 const diff = Math.floor((now - createdAt) / 1000); // Difference in seconds let timeAgo = ""; if (diff < 60) { timeAgo = diff + " s ago";
 } else if (diff < 3600) { timeAgo = Math.floor(diff / 60) + " min ago"; } else if (diff < 86400) { timeAgo = Math.floor(diff / 3600) + " hr ago"; } else { timeAgo = Math.floor(diff / 86400) + " days ago"; } element.textContent = timeAgo; }); }); </script>
</body>
</html>
