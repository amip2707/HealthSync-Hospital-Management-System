<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.hospital.dao.*"%>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
    RoomDAO dao = new RoomDAO();
    List<String[]> roomList = dao.getAllRooms();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Room Booking - HealthSync</title>
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
        .room-section {
            background:white; padding:25px; border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            margin-bottom:25px; border-top:3px solid #A3BCF9;
        }
        .section-title {
            font-size:16px; font-weight:700; color:#0077b6;
            margin-bottom:15px; border-left:4px solid #0077b6;
            padding-left:10px; display:flex; align-items:center; gap:8px;
        }
        .legend { display:flex; gap:20px; margin-bottom:15px; font-size:13px; font-weight:600; }
        .legend-item { display:flex; align-items:center; gap:6px; }
        .legend-box { width:18px; height:18px; border-radius:4px; }
        .green-box { background:#27ae60; }
        .red-box { background:#e74c3c; }
        .room-grid { display:flex; flex-wrap:wrap; gap:8px; }
        .room-btn {
            width:55px; height:55px; border:none; border-radius:10px;
            cursor:pointer; font-weight:700; font-size:11px;
            color:white; transition:all 0.3s;
        }
        .room-btn:hover { transform:scale(1.1); }
        .room-available { background:#27ae60; }
        .room-booked { background:#e74c3c; }
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
        .btn-row { display:flex; gap:12px; flex-wrap:wrap; }
        .btn {
            padding:10px 22px; border:none; border-radius:20px;
            cursor:pointer; font-weight:700; font-size:13px;
            transition:all 0.3s; font-family:'Inter', sans-serif;
            display:flex; align-items:center; gap:6px;
        }
        .btn:hover { transform:translateY(-2px); }
        .btn-add { background:#27ae60; color:white; }
        .btn-delete { background:#e74c3c; color:white; }
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
        tr:hover { background:#D1D2F9; cursor:pointer; }
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
    <script>
        function fillRoom(i, j) {
            document.getElementById('i').value = i;
            document.getElementById('j').value = j;
            document.getElementById('roomno').value = 'R' + i + j;
        }
        function fillForm(i, j, id, name, age, gender, phone, roomno, fees) {
            document.getElementById('i').value = i;
            document.getElementById('j').value = j;
            document.getElementById('pid').value = id;
            document.getElementById('pname').value = name;
            document.getElementById('age').value = age;
            document.getElementById('gender').value = gender;
            document.getElementById('phone').value = phone;
            document.getElementById('roomno').value = roomno;
            document.getElementById('fees').value = fees;
        }
    </script>
</head>
<body>
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
<div class="welcome">
    <i class="bi bi-hospital"></i> Room Booking &nbsp;|&nbsp;
    Welcome, <strong>${sessionScope.username}</strong>
</div>
<div class="container">

    <% if(request.getAttribute("success") != null) { %>
        <p class="success"><i class="bi bi-check-circle"></i> <%= request.getAttribute("success") %></p>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <p class="error"><i class="bi bi-x-circle"></i> <%= request.getAttribute("error") %></p>
    <% } %>

    <!-- ROOM GRID -->
    <div class="room-section">
        <div class="section-title"><i class="bi bi-grid-3x3"></i> Room Availability</div>
        <div class="legend">
            <div class="legend-item"><div class="legend-box green-box"></div> Available</div>
            <div class="legend-item"><div class="legend-box red-box"></div> Booked</div>
        </div>
        <div class="room-grid">
            <% for(int ri=0; ri<5; ri++) {
                for(int rj=0; rj<9; rj++) {
                    boolean booked = dao.isRoomBooked(String.valueOf(ri), String.valueOf(rj)); %>
            <button class="room-btn <%= booked ? "room-booked" : "room-available" %>"
                    onclick="fillRoom('<%= ri %>','<%= rj %>')">
                R<%= ri %><%= rj %>
            </button>
            <% } } %>
        </div>
    </div>

    <!-- FORM -->
    <div class="form-box">
        <div class="form-title"><i class="bi bi-hospital"></i> Book Room</div>
        <form action="${pageContext.request.contextPath}/room" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>Row (i)</label>
                    <input type="text" id="i" name="i" placeholder="Row" required/>
                </div>
                <div class="form-group">
                    <label>Col (j)</label>
                    <input type="text" id="j" name="j" placeholder="Column" required/>
                </div>
                <div class="form-group">
                    <label>Patient ID</label>
                    <input type="text" id="pid" name="pid" placeholder="Patient ID" required/>
                </div>
                <div class="form-group">
                    <label>Patient Name</label>
                    <input type="text" id="pname" name="pname" placeholder="Patient Name"/>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Age</label>
                    <input type="text" id="age" name="age" placeholder="Age"/>
                </div>
                <div class="form-group">
                    <label>Gender</label>
                    <select id="gender" name="gender">
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" id="phone" name="phone" placeholder="Phone"/>
                </div>
                <div class="form-group">
                    <label>Room No</label>
                    <input type="text" id="roomno" name="roomno" placeholder="Room Number"/>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Extra Fees</label>
                    <input type="text" id="fees" name="fees" placeholder="Extra Fees"/>
                </div>
            </div>
            <div class="btn-row">
                <button type="submit" name="action" value="book" class="btn btn-add">
                    <i class="bi bi-hospital"></i> BOOK ROOM
                </button>
                <button type="submit" name="action" value="vacate" class="btn btn-delete">
                    <i class="bi bi-door-open"></i> VACATE ROOM
                </button>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-back">
                    <i class="bi bi-arrow-left"></i> BACK
                </a>
            </div>
        </form>
    </div>

    <!-- TABLE -->
    <div class="table-box">
        <div class="table-title"><i class="bi bi-table"></i> All Booked Rooms</div>
        <table>
            <tr>
                <th>Row</th><th>Col</th><th>Patient ID</th><th>Name</th>
                <th>Age</th><th>Gender</th><th>Phone</th><th>Room No</th><th>Fees</th>
            </tr>
            <% if(roomList != null && !roomList.isEmpty()) {
                for(String[] r : roomList) { %>
            <tr onclick="fillForm('<%= r[0] %>','<%= r[1] %>','<%= r[2] %>',
                '<%= r[3] %>','<%= r[4] %>','<%= r[5] %>',
                '<%= r[6] %>','<%= r[7] %>','<%= r[8] %>')">
                <td><%= r[0] %></td><td><%= r[1] %></td>
                <td><%= r[2] %></td><td><b><%= r[3] %></b></td>
                <td><%= r[4] %></td><td><%= r[5] %></td>
                <td><%= r[6] %></td><td><%= r[7] %></td>
                <td><%= r[8] %></td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="9" style="text-align:center; padding:30px; color:#888;">
                    <i class="bi bi-inbox" style="font-size:30px;"></i><br/>No rooms booked!
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>