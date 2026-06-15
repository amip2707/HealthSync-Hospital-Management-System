<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.hospital.model.*, com.hospital.dao.*"%>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
    DoctorDAO ddao = new DoctorDAO();
    List<Doctor> doctorList = ddao.getAllDoctors();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment - HealthSync</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter', sans-serif; background:#F8F8FF; }
        .navbar {
            background:#0077b6; color:white; padding:15px 30px;
            display:flex; justify-content:space-between; align-items:center;
            box-shadow:0 2px 10px rgba(0,119,182,0.3);
        }
        .navbar-left { display:flex; align-items:center; gap:12px; }
        .navbar-left img { width:40px; height:40px; object-fit:contain; }
        .navbar-left h1 { font-size:20px; font-weight:800; }
        .nav-links { display:flex; gap:10px; }
        .nav-btn {
            background:white; color:#0077b6; border:none;
            padding:8px 18px; border-radius:20px; font-weight:700;
            font-size:13px; cursor:pointer; text-decoration:none;
            transition:all 0.3s; font-family:'Inter', sans-serif;
        }
        .nav-btn.danger { background:#e74c3c; color:white; }
        .welcome {
            background:#D1D2F9; color:#0077b6;
            padding:12px 30px; font-size:14px; font-weight:600;
            border-bottom:2px solid #A3BCF9;
        }
        .container { padding:25px 30px; }
        .form-box {
            background:white; padding:25px; border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            margin-bottom:25px; border-top:3px solid #A3BCF9;
        }
        .form-title {
            font-size:16px; font-weight:700; color:#0077b6;
            margin-bottom:20px; border-left:4px solid #0077b6;
            padding-left:10px; display:flex; align-items:center; gap:8px;
        }
        .form-row { display:flex; flex-wrap:wrap; gap:15px; margin-bottom:15px; }
        .form-group { flex:1; min-width:150px; }
        label {
            display:block; font-weight:600; margin-bottom:6px;
            color:#0077b6; font-size:12px; text-transform:uppercase; letter-spacing:0.5px;
        }
        input, select {
            width:100%; padding:10px 12px; border:2px solid #C9CAD9;
            border-radius:10px; font-size:13px; transition:border 0.3s;
            background:#fafafa; font-family:'Inter', sans-serif;
        }
        input:focus, select:focus { outline:none; border-color:#0077b6; background:white; }
        input[readonly] { background:#f0f0f0; color:#888; cursor:not-allowed; }
        .btn-row { display:flex; gap:12px; flex-wrap:wrap; }
        .btn {
            padding:10px 22px; border:none; border-radius:20px;
            cursor:pointer; font-weight:700; font-size:13px;
            transition:all 0.3s; font-family:'Inter', sans-serif;
            display:flex; align-items:center; gap:6px;
        }
        .btn:hover { transform:translateY(-2px); }
        .btn-add { background:#0077b6; color:white; }
        .btn-back { background:#D1D2F9; color:#0077b6; text-decoration:none; }
        .table-box {
            background:white; padding:25px; border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1); border-top:3px solid #A3BCF9;
        }
        .table-title {
            font-size:16px; font-weight:700; color:#0077b6;
            margin-bottom:20px; border-left:4px solid #0077b6;
            padding-left:10px; display:flex; align-items:center; gap:8px;
        }
        table { width:100%; border-collapse:collapse; }
        th {
            background:#0077b6; color:white; padding:12px 10px;
            text-align:left; font-size:12px; text-transform:uppercase; letter-spacing:0.5px;
        }
        th:first-child { border-radius:8px 0 0 0; }
        th:last-child { border-radius:0 8px 0 0; }
        td { padding:11px 10px; border-bottom:1px solid #C9CAD9; font-size:13px; }
        tr:hover { background:#D1D2F9; }
        .avail-yes { color:#27ae60; font-weight:700; }
        .avail-no { color:#e74c3c; font-weight:700; }
        .success {
            color:#27ae60; background:#eafaf1; padding:10px 15px;
            border-radius:8px; border-left:4px solid #27ae60;
            margin-bottom:15px; font-weight:600; font-size:13px;
        }
        .error {
            color:#e74c3c; background:#fdf2f2; padding:10px 15px;
            border-radius:8px; border-left:4px solid #e74c3c;
            margin-bottom:15px; font-weight:600; font-size:13px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <div class="navbar-left">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"/>
        <h1>HealthSync</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/patient/dashboard.jsp" class="nav-btn">
            <i class="bi bi-speedometer2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-btn danger">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</div>
<div class="welcome">
    <i class="bi bi-calendar-plus"></i> Book Appointment &nbsp;|&nbsp;
    Welcome, <strong>${sessionScope.username}</strong>
</div>
<div class="container">
    <% if(request.getAttribute("success") != null) { %>
        <p class="success"><i class="bi bi-check-circle"></i> <%= request.getAttribute("success") %></p>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <p class="error"><i class="bi bi-x-circle"></i> <%= request.getAttribute("error") %></p>
    <% } %>

    <div class="form-box">
        <div class="form-title">
            <i class="bi bi-calendar-plus"></i> Book Appointment
        </div>
        <form action="${pageContext.request.contextPath}/appointment" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>Patient ID</label>
                    <input type="text" name="pid" placeholder="Patient ID" required/>
                </div>
                <div class="form-group">
                    <label>Date</label>
                    <input type="date" name="adate" required/>
                </div>
                <div class="form-group">
                    <label>Patient Name</label>
                    <input type="text" name="pname"
                           value="${sessionScope.username}" readonly/>
                </div>
                <div class="form-group">
                    <label>Gender</label>
                    <select name="agender">
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Doctor Name</label>
                    <select name="adoctor" onchange="updateType(this)">
                        <% for(Doctor d : doctorList) { %>
                        <option value="<%= d.getDname() %>"
                                data-type="<%= d.getDspecialist() %>">
                            <%= d.getDname() %> (<%= d.getDspecialist() %>)
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label>Time</label>
                    <input type="time" name="atime"/>
                </div>
                <div class="form-group">
                    <label>Problem</label>
                    <input type="text" name="aproblem"
                           placeholder="Describe your problem"/>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="aphone"
                           placeholder="Phone number"/>
                </div>
            </div>
            <!-- Hidden field for type -->
            <input type="hidden" name="atype" id="atype"/>
            <div class="btn-row">
                <button type="submit" name="action" value="add" class="btn btn-add">
                    <i class="bi bi-calendar-check"></i> BOOK APPOINTMENT
                </button>
                <a href="${pageContext.request.contextPath}/patient/dashboard.jsp"
                   class="btn btn-back">
                    <i class="bi bi-arrow-left"></i> BACK
                </a>
            </div>
        </form>
    </div>

    <!-- AVAILABLE DOCTORS TABLE -->
    <div class="table-box">
        <div class="table-title">
            <i class="bi bi-person-badge"></i> Available Doctors
        </div>
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Qualification</th>
                <th>Specialist</th><th>Phone</th><th>Availability</th>
            </tr>
            <% for(Doctor d : doctorList) { %>
            <tr>
                <td><%= d.getDid() %></td>
                <td><b><%= d.getDname() %></b></td>
                <td><%= d.getDqualification() %></td>
                <td><%= d.getDspecialist() %></td>
                <td><%= d.getBphone() %></td>
                <td class="<%= d.getDavailability().equals("YES") ? "avail-yes" : "avail-no" %>">
                    <i class="bi bi-<%= d.getDavailability().equals("YES") ? "check-circle" : "x-circle" %>"></i>
                    <%= d.getDavailability() %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

<script>
    function updateType(select) {
        var type = select.options[select.selectedIndex]
                         .getAttribute('data-type');
        document.getElementById('atype').value = type;
    }
    window.onload = function() {
        var select = document.querySelector('select[name="adoctor"]');
        if(select) updateType(select);
    }
</script>
</body>
</html>