<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
    String role = (String)session.getAttribute("usertype");
    if(!role.equals("RECEPTIONIST")) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - HealthSync</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter', sans-serif; background:#F8F8FF; }

        /* NAVBAR */
        .navbar {
            background:#0077B6; color:white;
            padding:15px 30px;
            display:flex; justify-content:space-between;
            align-items:center;
            box-shadow:0 2px 10px rgba(108,99,255,0.3);
        }
        .navbar-left {
            display:flex; align-items:center; gap:12px;
        }
        .navbar-left img {
            width:40px; height:40px; object-fit:contain;
        }
        .navbar-left h1 {
            font-size:20px; font-weight:800;
            letter-spacing:1px;
        }
        .logout-btn {
            background:white; color:#0077B6;
            border:none; padding:8px 20px;
            border-radius:20px; font-weight:700;
            font-size:14px; cursor:pointer;
            text-decoration:none;
            transition:all 0.3s;
            font-family:'Inter', sans-serif;
        }
        .logout-btn:hover {
            background:#f0f0ff;
            transform:translateY(-2px);
        }

        /* WELCOME BAR */
        .welcome {
            background:#D1D2F9; color:#0077B6;
            padding:12px 30px; font-size:14px;
            font-weight:600;
            border-bottom:2px solid #A3BCF9;
        }

        /* CARDS SECTION */
        .section-title {
            padding:30px 30px 10px;
            font-size:18px; font-weight:700;
            color:#2D2D2D;
            border-left:4px solid #6C63FF;
            margin-left:30px;
        }
        .cards {
            display:flex; flex-wrap:wrap;
            gap:20px; padding:20px 30px 30px;
        }
        .card {
            background:white; border-radius:16px;
            padding:28px 20px; width:175px;
            text-align:center;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            cursor:pointer; transition:all 0.3s;
            text-decoration:none; color:#2D2D2D;
            border-top:4px solid #6C63FF;
        }
        .card:hover {
            transform:translateY(-8px);
            box-shadow:0 8px 25px rgba(108,99,255,0.2);
        }
        .card .icon {
            font-size:38px; margin-bottom:12px;
            color:#6C63FF;
        }
        .card h3 {
            font-size:13px; font-weight:700;
            color:#2D2D2D;
        }
        .card p {
            font-size:11px; color:#888;
            margin-top:4px;
        }

        /* CARD COLORS */
        .card.blue   { border-top-color:#A3BCF9; }
        .card.blue .icon { color:#A3BCF9; }
        .card.green  { border-top-color:#27ae60; }
        .card.green .icon { color:#27ae60; }
        .card.orange { border-top-color:#e67e22; }
        .card.orange .icon { color:#e67e22; }
        .card.red    { border-top-color:#e74c3c; }
        .card.red .icon { color:#e74c3c; }
        .card.purple { border-top-color:#6C63FF; }
        .card.purple .icon { color:#6C63FF; }
        .card.teal   { border-top-color:#16a085; }
        .card.teal .icon { color:#16a085; }
        .card.brown  { border-top-color:#795548; }
        .card.brown .icon { color:#795548; }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <div class="navbar">
        <div class="navbar-left">
            <img src="${pageContext.request.contextPath}/images/logo.png"
                 alt="Logo"/>
            <h1>HealthSync</h1>
        </div>
        <a href="${pageContext.request.contextPath}/logout"
           class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>

    <!-- WELCOME BAR -->
    <div class="welcome">
        <i class="bi bi-person-circle"></i>
        Welcome, <strong>${sessionScope.username}</strong>
        &nbsp;|&nbsp;
        <i class="bi bi-shield-check"></i>
        Role: <strong>${sessionScope.usertype}</strong>
    </div>

    <!-- CARDS -->
    <p class="section-title">Quick Access</p>
    <div class="cards">

        <a href="${pageContext.request.contextPath}/doctor"
           class="card blue">
            <div class="icon"><i class="bi bi-person-badge"></i></div>
            <h3>Manage Doctors</h3>
            <p>Add, Edit, Delete</p>
        </a>

        <a href="${pageContext.request.contextPath}/patient"
           class="card green">
            <div class="icon"><i class="bi bi-people"></i></div>
            <h3>Manage Patients</h3>
            <p>View & Manage</p>
        </a>

        <a href="${pageContext.request.contextPath}/appointment"
           class="card orange">
            <div class="icon"><i class="bi bi-calendar-check"></i></div>
            <h3>Appointments</h3>
            <p>Book & View</p>
        </a>

        <a href="${pageContext.request.contextPath}/cashier/bill.jsp"
           class="card red">
            <div class="icon"><i class="bi bi-receipt"></i></div>
            <h3>Billing</h3>
            <p>Generate Bills</p>
        </a>

        <a href="${pageContext.request.contextPath}/admin/patient-records.jsp"
           class="card purple">
            <div class="icon"><i class="bi bi-clipboard2-pulse"></i></div>
            <h3>Patient Records</h3>
            <p>View Records</p>
        </a>

        <a href="${pageContext.request.contextPath}/admin/discharge.jsp"
           class="card teal">
            <div class="icon"><i class="bi bi-door-open"></i></div>
            <h3>Discharge Summary</h3>
            <p>Discharged Patients</p>
        </a>

        <a href="${pageContext.request.contextPath}/room"
           class="card brown">
            <div class="icon"><i class="bi bi-hospital"></i></div>
            <h3>Room Booking</h3>
            <p>Manage Rooms</p>
        </a>

    </div>

</body>
</html>