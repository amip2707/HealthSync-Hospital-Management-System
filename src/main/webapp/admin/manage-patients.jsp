<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, java.sql.*, com.hospital.model.*, com.hospital.dao.*"%>
<%@ page import="com.hospital.util.DBConnection"%>
<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
    PatientDAO dao = new PatientDAO();
    List<Patient> patientList = dao.getAllPatients();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Patients - HealthSync</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter', sans-serif; background:#F8F8FF; }
        .navbar {
            background:#0077b6; color:white;
            padding:15px 30px; display:flex;
            justify-content:space-between; align-items:center;
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
        .welcome {
            background:#D1D2F9; color:#0077b6;
            padding:12px 30px; font-size:14px; font-weight:600;
            border-bottom:2px solid #A3BCF9;
        }
        .container { padding:25px 30px; }
        .form-box {
            background:white; padding:25px;
            border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            margin-bottom:25px; border-top:3px solid #A3BCF9;
        }
        .form-title {
            font-size:16px; font-weight:700;
            color:#0077b6; margin-bottom:20px;
            border-left:4px solid #0077b6; padding-left:10px;
            display:flex; align-items:center; gap:8px;
        }
        .form-row { display:flex; flex-wrap:wrap; gap:15px; margin-bottom:15px; }
        .form-group { flex:1; min-width:150px; }
        label {
            display:block; font-weight:600;
            margin-bottom:6px; color:#0077b6;
            font-size:12px; text-transform:uppercase; letter-spacing:0.5px;
        }
        input, select {
            width:100%; padding:10px 12px;
            border:2px solid #C9CAD9; border-radius:10px;
            font-size:13px; transition:border 0.3s;
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
            background:white; padding:25px;
            border-radius:16px;
            box-shadow:0 4px 15px rgba(108,99,255,0.1);
            border-top:3px solid #A3BCF9;
        }
        .table-title {
            font-size:16px; font-weight:700;
            color:#0077b6; margin-bottom:20px;
            border-left:4px solid #0077b6; padding-left:10px;
            display:flex; align-items:center; gap:8px;
        }
        table { width:100%; border-collapse:collapse; }
        th {
            background:#0077b6; color:white;
            padding:12px 10px; text-align:left;
            font-size:12px; text-transform:uppercase; letter-spacing:0.5px;
        }
        th:first-child { border-radius:8px 0 0 0; }
        th:last-child { border-radius:0 8px 0 0; }
        td { padding:11px 10px; border-bottom:1px solid #C9CAD9; font-size:13px; }
        tr:hover { background:#D1D2F9; cursor:pointer; }
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
        function fillForm(pid, pdate, pname, pgender, pblood,
                          psugar, ppressure, pop, pphone,
                          paddress, tot, doc_name) {
            document.getElementById('pid').value = pid;
            document.getElementById('pdate').value = pdate;
            document.getElementById('pname').value = pname;
            document.getElementById('pgender').value = pgender;
            document.getElementById('pblood').value = pblood;
            document.getElementById('psugar').value = psugar;
            document.getElementById('ppressure').value = ppressure;
            document.getElementById('pop').value = pop;
            document.getElementById('pphone').value = pphone;
            document.getElementById('paddress').value = paddress;
            document.getElementById('tot').value = tot;
            document.getElementById('doc_name').value = doc_name;
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
    <i class="bi bi-people"></i> Manage Patients &nbsp;|&nbsp;
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
        <div class="form-title"><i class="bi bi-person-plus"></i> Patient Details</div>
        <form action="${pageContext.request.contextPath}/patient" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>ID</label>
                    <input type="text" id="pid" name="pid" placeholder="Patient ID" required/>
                </div>
                <div class="form-group">
                    <label>Date</label>
                    <input type="date" id="pdate" name="pdate"/>
                </div>
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" id="pname" name="pname" placeholder="Patient Name" required/>
                </div>
                <div class="form-group">
                    <label>Gender</label>
                    <select id="pgender" name="pgender">
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Blood Group</label>
                    <input type="text" id="pblood" name="pblood" placeholder="O+, A+..."/>
                </div>
                <div class="form-group">
                    <label>Sugar</label>
                    <input type="text" id="psugar" name="psugar" placeholder="Sugar level"/>
                </div>
                <div class="form-group">
                    <label>Pressure</label>
                    <input type="text" id="ppressure" name="ppressure" placeholder="Blood pressure"/>
                </div>
                <div class="form-group">
                    <label>OP</label>
                    <input type="text" id="pop" name="pop" placeholder="OP number"/>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" id="pphone" name="pphone" placeholder="Phone number"/>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" id="paddress" name="paddress" placeholder="Address"/>
                </div>
                <div class="form-group">
                    <label>Doc Fees</label>
                    <input type="text" id="tot" name="tot" placeholder="Doctor fees"/>
                </div>
               <div class="form-group">
    <label>Doctor Name</label>
    <select id="doc_name" name="doc_name">
        <option value="">-- Select Doctor --</option>
        <%
            try {
                Connection conDoc = DBConnection.getConnection();
                PreparedStatement ptsDoc = conDoc.prepareStatement(
                    "SELECT dname FROM doctdetails WHERE davailability='YES'");
                ResultSet rsDoc = ptsDoc.executeQuery();
                while(rsDoc.next()) {
        %>
        <option value="<%= rsDoc.getString("dname") %>">
            <%= rsDoc.getString("dname") %>
        </option>
        <% } } catch(Exception ex) { ex.printStackTrace(); } %>
    </select>
</div>
            </div>
            <div class="btn-row">
                <button type="submit" name="action" value="add" class="btn btn-add">
                    <i class="bi bi-plus-circle"></i> ADD
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
    <div class="table-box">
        <div class="table-title"><i class="bi bi-table"></i> All Patients</div>
        <table>
            <tr>
                <th>ID</th><th>Date</th><th>Name</th><th>Gender</th>
                <th>Blood</th><th>Sugar</th><th>Pressure</th>
                <th>Phone</th><th>Doc Fees</th><th>Doctor</th>
            </tr>
            <% if(patientList != null && !patientList.isEmpty()) {
                for(Patient p : patientList) { %>
            <tr onclick="fillForm('<%= p.getPid() %>','<%= p.getPdate() %>',
                '<%= p.getPname() %>','<%= p.getPgender() %>',
                '<%= p.getPblood() %>','<%= p.getPsugar() %>',
                '<%= p.getPpressure() %>','<%= p.getPop() %>',
                '<%= p.getPphone() %>','<%= p.getPaddress() %>',
                '<%= p.getTot() %>','<%= p.getDoc_name() %>')">
                <td><%= p.getPid() %></td>
                <td><%= p.getPdate() %></td>
                <td><b><%= p.getPname() %></b></td>
                <td><%= p.getPgender() %></td>
                <td><%= p.getPblood() %></td>
                <td><%= p.getPsugar() %></td>
                <td><%= p.getPpressure() %></td>
                <td><%= p.getPphone() %></td>
                <td><%= p.getTot() %></td>
                <td><%= p.getDoc_name() %></td>
            </tr>
            <% } } else { %>
            <tr>
                <td colspan="10" style="text-align:center; padding:30px; color:#888;">
                    <i class="bi bi-inbox" style="font-size:30px;"></i><br/>No patients found!
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>