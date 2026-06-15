<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cashier Dashboard - HealthSync</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter', sans-serif; background:#F8F8FF; }

        .navbar {
            background:#0077B6;
            color:white;
            padding:15px 30px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            box-shadow:0 2px 10px rgba(0,119,182,0.3);
        }

        .navbar-left {
            display:flex;
            align-items:center;
            gap:12px;
        }

        .navbar-left img {
            width:40px;
            height:40px;
            object-fit:contain;
        }

        .navbar-left h1 {
            font-size:20px;
            font-weight:800;
        }

        .logout-btn {
            background:white;
            color:#0077B6;
            border:none;
            padding:8px 20px;
            border-radius:20px;
            font-weight:700;
            font-size:14px;
            cursor:pointer;
            text-decoration:none;
            transition:all 0.3s;
        }

        .logout-btn:hover {
            background:#f0f8ff;
            transform:translateY(-2px);
        }

        .welcome {
            background:#D1D2F9;
            color:#0077B6;
            padding:12px 30px;
            font-size:14px;
            font-weight:600;
            border-bottom:2px solid #A3BCF9;
        }

        .section-title {
            padding:30px 30px 10px;
            font-size:18px;
            font-weight:700;
            color:#2D2D2D;
            border-left:4px solid #0077B6;
            margin-left:30px;
        }

        .cards {
            display:flex;
            flex-wrap:wrap;
            gap:20px;
            padding:20px 30px 40px;
        }

        .card {
            background:white;
            border-radius:16px;
            padding:28px 20px;
            width:200px;
            text-align:center;
            box-shadow:0 4px 15px rgba(0,119,182,0.1);
            cursor:pointer;
            transition:all 0.3s;
            text-decoration:none;
            color:#2D2D2D;
            border-top:4px solid #0077B6;
        }

        .card:hover {
            transform:translateY(-8px);
            box-shadow:0 8px 25px rgba(0,119,182,0.2);
        }

        .card .icon {
            font-size:38px;
            margin-bottom:12px;
            color:#0077B6;
        }

        .card h3 {
            font-size:14px;
            font-weight:700;
        }

        .card p {
            font-size:12px;
            color:#777;
            margin-top:4px;
        }

        .card.red {
            border-top-color:#e74c3c;
        }

        .card.red .icon {
            color:#e74c3c;
        }

        .card.green {
            border-top-color:#27ae60;
        }

        .card.green .icon {
            color:#27ae60;
        }
    </style>
</head>

<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"/>
            <h1>HealthSync</h1>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>

    <!-- Welcome Section -->
    <div class="welcome">
        <i class="bi bi-person-circle"></i>
        Welcome, <strong>${sessionScope.username}</strong>
        &nbsp;|&nbsp;
        <i class="bi bi-shield-check"></i>
        Role: <strong>${sessionScope.usertype}</strong>
    </div>

    <!-- Title -->
    <p class="section-title">Cashier Panel</p>

    <!-- Cards -->
    <div class="cards">

        <!-- Manage Bills -->
        <a href="${pageContext.request.contextPath}/cashier/bill.jsp" class="card red">
            <div class="icon">
                <i class="bi bi-receipt-cutoff"></i>
            </div>
            <h3>Manage Bills</h3>
            <p>Generate Bill</p>
        </a>

        <!-- View Bills -->
        <a href="${pageContext.request.contextPath}/cashier/viewbill.jsp" class="card green">
            <div class="icon">
                <i class="bi bi-cash-stack"></i>
            </div>
            <h3>View Bills</h3>
            <p>All Transactions</p>
        </a>

    </div>

</body>
</html>