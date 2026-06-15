<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.hospital.model.*, com.hospital.dao.*"%>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
    DoctorDAO dao = new DoctorDAO();
    List<Doctor> doctorList = dao.getAllDoctors();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Doctors - HealthSync</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter', sans-serif; background:#F8F8FF; }

        /* NAVBAR */
        .navbar {
            background:#0077b6; color:white;
            padding:15px 30px;
            display:flex; justify-content:space-between;
            align-items:center;
            box-shadow:0 2px 10px rgba(0,119,182,0.3);
        }
        .navbar-left { display:flex; align-items:center; gap:12px; }
        .navbar-left img { width:40px; height:40px; object-fit:contain; }
        .navbar-left h1 { font-size:20px; font-weight:800; }
        .nav-links { display:flex; gap:10px; align-items:center; }
        .nav-btn {
            background:white; color:#0077b6;
            border:none; padding:8px 18px;
            border-radius:20px; font-weight:700;
            font-size:13px; cursor:pointer;
            text-decoration:none; transition:all 0.3s;
            font-family:'Inter', sans-serif;
        }
        .nav-btn:hover { background:#f0f0ff; transform:translateY(-2px); }
        .nav-btn.danger { background:#e74c3c; color:white; }
        .nav-btn.danger:hover { background:#c0392b; }

        /* WELCOME */
        .welcome {
            background:#D1D2F9; color:#0077b6;
            padding:12px 30px; font-size:14px; font-weight:600;
            border-bottom:2px solid #A3BCF9;
        }

        /* CONTAINER */
        .container { padding:25px 30px; }

        /* FORM BOX */
        .form-box {
            background:white; padding:25px;
            border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            margin-bottom:25px;
            border-top:3px solid #A3BCF9;
        }
        .form-title {
            font-size:16px; font-weight:700;
            color:#0077b6; margin-bottom:20px;
            display:flex; align-items:center; gap:8px;
            border-left:4px solid #0077b6;
            padding-left:10px;
        }
        .form-row {
            display:flex; flex-wrap:wrap;
            gap:15px; margin-bottom:15px;
        }
        .form-group { flex:1; min-width:150px; }
        label {
            display:block; font-weight:600;
            margin-bottom:6px; color:#0077b6;
            font-size:12px; text-transform:uppercase;
            letter-spacing:0.5px;
        }
        input, select {
            width:100%; padding:10px 12px;
            border:2px solid #C9CAD9;
            border-radius:10px; font-size:13px;
            transition:border 0.3s; background:#fafafa;
            font-family:'Inter', sans-serif;
        }
        input:focus, select:focus {
            outline:none; border-color:#0077b6;
            background:white;
        }

        /* BUTTONS */
        .btn-row { display:flex; gap:12px; flex-wrap:wrap; }
        .btn {
            padding:10px 22px; border:none;
            border-radius:20px; cursor:pointer;
            font-weight:700; font-size:13px;
            transition:all 0.3s; font-family:'Inter', sans-serif;
            display:flex; align-items:center; gap:6px;
        }
        .btn:hover { transform:translateY(-2px); }
        .btn-add    { background:#27ae60; color:white; }
        .btn-update { background:#e67e22; color:white; }
        .btn-delete { background:#e74c3c; color:white; }
        .btn-back   { background:#D1D2F9; color:#0077b6; text-decoration:none; }

        /* TABLE */
        .table-box {
            background:white; padding:25px;
            border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            border-top:3px solid #A3BCF9;
        }
        .table-title {
            font-size:16px; font-weight:700;
            color:#0077b6; margin-bottom:20px;
            display:flex; align-items:center; gap:8px;
            border-left:4px solid #0077b6;
            padding-left:10px;
        }
        table { width:100%; border-collapse:collapse; }
        th {
            background:#0077b6; color:white;
            padding:12px 10px; text-align:left;
            font-size:12px; text-transform:uppercase;
            letter-spacing:0.5px; font-weight:600;
        }
        th:first-child { border-radius:8px 0 0 0; }
        th:last-child  { border-radius:0 8px 0 0; }
        td {
            padding:11px 10px;
            border-bottom:1px solid #C9CAD9;
            font-size:13px;
        }
        tr:hover { background:#D1D2F9; cursor:pointer; }
        .avail-yes { color:#27ae60; font-weight:700; }
        .avail-no  { color:#e74c3c; font-weight:700; }

        /* MESSAGES */
        .success {
            color:#27ae60; background:#eafaf1;
            padding:10px 15px; border-radius:8px;
            border-left:4px solid #27ae60;
            margin-bottom:15px; font-weight:600; font-size:13px;
        }
        .error {
            color:#e74c3c; background:#fdf2f2;
            padding:10px 15px; border-radius:8px;
            border-left:4px solid #e74c3c;
            margin-bottom:15px; font-weight:600; font-size:13px;
        }
    </style>
    <script>
        function fillForm(did, dname, dqualification,
                          dspecialist, bphone, davailability) {
            document.getElementById('did').value = did;
            document.getElementById('dname').value = dname;
            document.getElementById('dqualification').value = dqualification;
            document.getElementById('dspecialist').value = dspecialist;
            document.getElementById('bphone').value = bphone;
            document.getElementById('davailability').value = davailability;
        }
    </script>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="navbar-left">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"/>
        <h1>HealthSync</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-btn">
            <i class="bi bi-speedometer2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-btn danger">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</div>

<!-- WELCOME -->
<div class="welcome">
    <i class="bi bi-person-badge"></i>
    Manage Doctors &nbsp;|&nbsp;
    <i class="bi bi-person-circle"></i>
    Welcome, <strong>${sessionScope.username}</strong>
</div>

<div class="container">

    <% if(request.getAttribute("success") != null) { %>
        <p class="success"><i class="bi bi-check-circle"></i> <%= request.getAttribute("success") %></p>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <p class="error"><i class="bi bi-x-circle"></i> <%= request.getAttribute("error") %></p>
    <% } %>

    <!-- FORM -->
    <div class="form-box">
        <div class="form-title">
            <i class="bi bi-person-badge"></i> Doctor Details
        </div>
        <form action="${pageContext.request.contextPath}/doctor" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>ID</label>
                    <input type="text" id="did" name="did" placeholder="Doctor ID" required/>
                </div>
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" id="dname" name="dname" placeholder="Doctor Name" required/>
                </div>
                <div class="form-group">
                    <label>Qualification</label>
                    <input type="text" id="dqualification" name="dqualification" placeholder="MBBS, MD..."/>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Specialist</label>
                    <input type="text" id="dspecialist" name="dspecialist" placeholder="Cardiologist..."/>
                </div>
                <div class="form-group">
                    <label>Phone No</label>
                    <input type="text" id="bphone" name="bphone" placeholder="Phone Number"/>
                </div>
                <div class="form-group">
                    <label>Availability</label>
                    <select id="davailability" name="davailability">
                        <option value="YES">YES</option>
                        <option value="NO">NO</option>
                    </select>
                </div>
            </div>
            <div class="btn-row">
                <button type="submit" name="action" value="add" class="btn btn-add">
                    <i class="bi bi-plus-circle"></i> ADD
                </button>
                <button type="submit" name="action" value="update" class="btn btn-update">
                    <i class="bi bi-pencil-square"></i> UPDATE
                </button>
                <button type="submit" name="action" value="delete" class="btn btn-delete">
                    <i class="bi bi-trash"></i> DELETE
                </button>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-back">
                    <i class="bi bi-arrow-left"></i> BACK
                </a>
            </div>
        </form>
    </div>

    <!-- TABLE -->
    <div class="table-box">
        <div class="table-title">
            <i class="bi bi-table"></i> All Doctors
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Qualification</th>
                <th>Specialist</th>
                <th>Phone</th>
                <th>Availability</th>
            </tr>
            <% if(doctorList != null && !doctorList.isEmpty()) {
                for(Doctor d : doctorList) { %>
            <tr onclick="fillForm('<%= d.getDid() %>',
                '<%= d.getDname() %>',
                '<%= d.getDqualification() %>',
                '<%= d.getDspecialist() %>',
                '<%= d.getBphone() %>',
                '<%= d.getDavailability() %>')">
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
            <% } } else { %>
            <tr>
                <td colspan="6" style="text-align:center; padding:30px; color:#888;">
                    <i class="bi bi-inbox" style="font-size:30px;"></i><br/>
                    No doctors found!
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>