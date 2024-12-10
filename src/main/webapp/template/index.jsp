<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Find You</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
          crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Heart Frame Styles */
        .heart-frame {
            display: flex;
            position: relative;
            width: 18rem;
            height: 18rem;
            background-color: #ff6b81;
            margin: 20px auto;
            clip-path: circle(50%);
            justify-content: center;
        }

        .heart-frame img {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform 0.4s ease, filter 0.4s ease;
            animation: imageFadeIn 1s ease-in-out;
            clip-path: circle(50%);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: auto;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .card {
            top: 60px;
            height: 19rem;
            width: 18rem;
            padding: 10px;
            border-radius: 10px;
            color: grey;
            font-weight: bold;
            background-color: #eeeeee;
            font-size: 1.2rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            transform: translateY(50px);
            animation: fadeInUp 0.5s ease-in-out forwards;
            overflow: visible;
            cursor: pointer;
        }

        .card:hover .heart-frame img {
            transform: scale(1.2) rotate(3deg);
            filter: brightness(1.1);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes imageFadeIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }


        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes imageFadeIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        footer {
            text-align: center;
            padding: 3px;
            background-color: #e4c1c7;
            color: white;
            position: relative;
            z-index: 1;
            margin-top: 80px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Nav Bar -->
        <c:import url="common/nav.jsp"/>

        <!-- Card Body -->
        <div class="container">
            <div class="row mt-4">
                <c:forEach var="user" items="${users}">
                    <c:if test="${sessionScope.user.id != user.id}">
                        <div class="col-md-3">
                            <div class="card" onclick="location.href='user?mode=VIEW&id=${user.id}'">
                                <div class="heart-frame">
                                    <img src="${pageContext.request.contextPath}/template/user/images/${user.photo}" alt="Heart Photo">
                                </div>
                                <div class="text-center">
                                    <p>${user.name}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <c:import url="common/footer.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" 
            crossorigin="anonymous"></script>
</body>
</html>