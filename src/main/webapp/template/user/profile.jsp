<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
        rel="stylesheet" 
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
        crossorigin="anonymous">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <title>Profile</title>
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
    .profile-photo {
      text-align: center;
      margin-bottom: 20px;
    }
    .profile-photo img {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
    .social-links a {
      margin: 0 10px;
      color: #ff4b5c;
      font-size: 1.5rem;
    }
    .btn-heart, .btn-edit {
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #ff4b5c;
      color: white;
      border: none;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      cursor: pointer;
      transition: transform 0.2s;
      margin: 10px;
    }
    .btn-heart:hover, .btn-edit:hover {
      transform: scale(1.1);
    }
    .btn-heart:active, .btn-edit:active {
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
    .card-body p {
      margin: 0;
      color: #555;
    }
  </style>
</head>
<body>
  <div class="container-fluid">
    <c:import url="../common/nav.jsp"/>
    <div class="container1">
      <div class="profile-photo">
        <img src="${pageContext.request.contextPath}/template/user/images/${user.photo}" alt="Profile Photo">
      </div>
      <div class="profile-info">
        <h2>${user.name}</h2>
        <c:if test="${user.birthday != null}">
			<p class="text-center">
				Age: <span id="age"></span>
			</p>

        <p><strong>Birthday:</strong> ${user.birthday}</p>
		</c:if>
        
        
        <h3>About Me</h3>
        <p>${user.bio}</p>
        <p>${user.description}</p>
        <p><strong>Hobby:</strong> ${user.hobby}</p>
        <c:if test="${user.phone != null}">
          <p><strong>Phone:</strong> ${user.phone}</p>
        </c:if>
        <div class="social-links">
        <c:if test="${user.fbLink != null}">
         <a href="${user.fbLink}" target="_blank"><i class="bi bi-facebook"></i></a>
        </c:if>
         <c:if test="${user.tgLink != null}">
          <a href="${user.tgLink}" target="_blank"><i class="bi bi-telegram"></i></a>
        </c:if>
         <c:if test="${user.ttLink != null}">
         <a href="${user.ttLink}" target="_blank"><i class="bi bi-tiktok"></i></a>
        </c:if>
         <c:if test="${user.igLink != null}">
         <a href="${user.igLink}" target="_blank"><i class="bi bi-instagram"></i></a>
        </c:if>
        
        
        </div>
        <div class="d-flex justify-content-center">
          <button onclick="Toggle(); window.location.href='anotherPage.jsp';" class="btn-heart">
            <i class="bi bi-heart-fill"></i>
          </button>
          
          <c:if test="${user.id == sessionScope.user.id}">
           <button onclick="window.location.href='user?mode=EDIT&id=${user.id}';" class="btn-edit">
            <i class="bi bi-pencil-fill"></i>
          </button>
          </c:if>
          
         
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
              <img src="${pageContext.request.contextPath}/template/user/images/${photo.photo}" alt="Old Profile Photo">
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
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
          integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
          crossorigin="anonymous"></script>
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
