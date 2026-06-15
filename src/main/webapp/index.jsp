<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>HealthSync - Hospital Management</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body{
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background:#0077b6;
        }

        .wrapper{
            display:flex;
            align-items:center;
            gap:90px;
        }

        /* LEFT SIDE */
        .left{
            text-align:center;
            color:white;
        }

        .medical-video{
            width:260px;
            margin-bottom:25px;
            filter: drop-shadow(0 10px 20px rgba(0,0,0,0.2));
        }

        .left h1{
            font-size:36px;
            margin-bottom:10px;
        }

        .left p{
            font-size:18px;
            opacity:0.9;
        }

        /* RIGHT CARD */
        .card{
            width:420px;
            background:white;
            border-radius:18px;
            padding:45px;
            box-shadow:0 10px 35px rgba(0,0,0,0.15);
            text-align:center;
        }

        .logo{
            font-size:32px;
            font-weight:bold;
            color:#5a67ff;
            margin-bottom:20px;
        }

        .desc{
            font-size:16px;
            margin-bottom:25px;
            color:#444;
        }

        .btn{
            display:inline-block;
            padding:14px 40px;
            border-radius:30px;
            background:#5a67ff;
            color:white;
            text-decoration:none;
            font-size:16px;
            transition:0.3s;
        }

        .btn:hover{
            background:#3f4bd8;
            transform:translateY(-2px);
        }

        footer{
            margin-top:25px;
            font-size:13px;
            color:#777;
        }
    </style>
</head>

<body>

<div class="wrapper">

    <!-- LEFT SIDE WITH ANIMATION -->
    <div class="left">
        <video autoplay loop muted playsinline class="medical-video">
            <source src="${pageContext.request.contextPath}/images/loginmedical.webm" type="video/webm">
        </video>

        <h1>Welcome to HealthSync</h1>
        <p>Your trusted Hospital Management System</p>
    </div>

    <!-- RIGHT SIDE CARD -->
    <div class="card">
        <div class="logo">HealthSync</div>

        <div class="desc">
            Manage Patients, Doctors, Appointments and Billing efficiently.
        </div>

        <a class="btn" href="${pageContext.request.contextPath}/login.jsp">
            Go to Login
        </a>

        <footer>
            © 2026 HealthSync
        </footer>
    </div>

</div>

</body>
</html>