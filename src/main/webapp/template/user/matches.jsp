<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Matched People</title>
<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous">
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    rel="stylesheet">
<style>
body {

    font-family: 'Arial', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.container {

    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    max-width: 1200px;
    width: 100%;
}

.card {
    background: rgba(255, 255, 255, 0.2);
    border: none;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
}

.card img {
    border-radius: 10px 10px 0 0;
    height: 200px;
    object-fit: cover;
}

.card-body {
    text-align: center;
}

.card-title {
    font-size: 1.2rem;
    margin-bottom: 10px;
}

.card-text {
    font-size: 1rem;
    margin-bottom: 10px;
}

.btn-unmatch {
    background-color: #ff4b5c;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 10px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.title{
margin-top:150px;
margin-bottom:30px;
}

.btn-unmatch:hover {
    background-color: #e43a4f;
}
</style>
</head>

<body>
	<c:import url="../common/nav.jsp"></c:import>
    <div class="container mt-5">
        <h2 class="text-center title">Matched People</h2>
        <div class="row">
            <c:forEach var="match" items="${users}">
                <div class="col-md-4">
                    <div class="card"
                        onclick="location.href='user?mode=PROFILE&id=${match.id}'">
                        <img
                            src="${pageContext.request.contextPath}/template/user/images/${match.photo}"
                            alt="Heart Photo">

                        <div class="card-body">
                            <h5 class="card-title">${match.name}</h5>
                            
                            <a href="user?mode=UNMATCH&id=${match.id}" class="btn btn-danger btn-unmatch">Unmatch</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>
