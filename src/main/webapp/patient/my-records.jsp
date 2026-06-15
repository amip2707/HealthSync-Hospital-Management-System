<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, java.sql.*"%>
<%@ page import="com.hospital.util.DBConnection"%>
<%@ page import="com.hospital.model.User"%>

<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }

    User u = (User) session.getAttribute("user");
    String username = u.getUsername();
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Records - HealthSync</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
         { margin:0; padding:0; box-sizing:border-box; }
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
        .nav-links a {
            background:white; color:#0077b6;
            padding:8px 18px; border-radius:20px;
            text-decoration:none; font-weight:700;
            font-size:13px; transition:all 0.3s;
        }
        .nav-links a:hover { background:#f0f0ff; transform:translateY(-2px); }
        .nav-links a.danger { background:#e74c3c; color:white; }
        .nav-links a.danger:hover { background:#c0392b; }
        .welcome {
            background:#D1D2F9; color:#0077b6;
            padding:12px 30px; font-size:14px; font-weight:600;
            border-bottom:2px solid #A3BCF9;
        }
        .container { padding:25px 30px; }
        .btn-back {
            display:inline-flex; align-items:center; gap:6px;
            background:#D1D2F9; color:#0077b6; text-decoration:none;
            padding:10px 22px; border-radius:20px; font-weight:700;
            font-size:13px; margin-bottom:20px; transition:all 0.3s;
        }
        .btn-back:hover { background:#A3BCF9; transform:translateY(-2px); }
        .table-box {
            background:white; padding:25px; border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            border-top:3px solid #A3BCF9;
        }
        .table-title {
            font-size:16px; font-weight:700; color:#0077b6;
            margin-bottom:20px; border-left:4px solid #0077b6;
            padding-left:10px; display:flex; align-items:center; gap:8px;
        }
        table { width:100%; border-collapse:collapse; }
        th {
            background:#0077b6; color:white; padding:12px 10px;
            text-align:left; font-size:12px;
            text-transform:uppercase; letter-spacing:0.5px;
        }
        th:first-child { border-radius:8px 0 0 0; }
        th:last-child { border-radius:0 8px 0 0; }
        td { padding:11px 10px; border-bottom:1px solid #C9CAD9; font-size:13px; }
        tr:hover { background:#D1D2F9; }
    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-left">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"/>
        <h1>HealthSync</h1>
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/patient/dashboard.jsp">
            <i class="bi bi-speedometer2"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="danger">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</div>

<div class="welcome">
    <i class="bi bi-clipboard2-pulse"></i> My Records &nbsp;|&nbsp;
    Welcome, <strong><%= username %></strong>
</div>

<div class="container">
    <a href="${pageContext.request.contextPath}/patient/dashboard.jsp" class="btn-back">
        <i class="bi bi-arrow-left"></i> BACK
    </a>

    <div class="table-box">
        <div class="table-title">
            <i class="bi bi-clipboard2-pulse"></i> My Medical Records
        </div>
        <table>
            <tr>
                <th>ID</th><th>Date</th><th>Name</th>
                <th>Gender</th><th>Blood</th>
                <th>Sugar</th><th>Pressure</th><th>Doctor</th>
            </tr>

            <%
                try {
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM patientdetails WHERE username=?"
                    );
                    ps.setString(1, username);
                    ResultSet rs = ps.executeQuery();
                    boolean found = false;
                    while(rs.next()) {
                        found = true;
            %>
            <tr>
                <td><%= rs.getString("pid") %></td>
                <td><%= rs.getString("pdate") %></td>
                <td><b><%= rs.getString("pname") %></b></td>
                <td><%= rs.getString("pgender") %></td>
                <td><%= rs.getString("pblood") %></td>
                <td><%= rs.getString("psugar") %></td>
                <td><%= rs.getString("ppressure") %></td>
                <td><%= rs.getString("doc_name") %></td>
            </tr>
            <%
                    }
                    if(!found) {
            %>
            <tr>
                <td colspan="8" style="text-align:center; padding:30px; color:#888;">
                    <i class="bi bi-inbox" style="font-size:30px;"></i><br/>
                    No records found!
                </td>
            </tr>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</div>
</body>
</html>