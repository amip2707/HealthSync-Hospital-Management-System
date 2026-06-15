<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - HealthSync</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:'Inter', sans-serif;
            background:linear-gradient(135deg, #D1D2F9, #A3BCF9);
            display:flex; justify-content:center;
            align-items:center; min-height:100vh;
        }
        .register-box {
            background:white; padding:45px; border-radius:20px;
            box-shadow:0 10px 40px rgba(108,99,255,0.2); width:450px;
        }
        .logo-section {
            text-align:center; margin-bottom:20px;
            display:flex; align-items:center;
            justify-content:center; gap:12px;
        }
        .logo-section img { width:60px; height:60px; object-fit:contain; }
        .logo-section span {
            color:#0077b6; font-size:28px;
            font-weight:800; letter-spacing:1px;
        }
        h2 {
            text-align:center; color:#2D2D2D;
            margin-bottom:25px; font-size:16px; font-weight:600;
        }
        .form-group { margin-bottom:18px; }
        label {
            display:block; font-weight:600; margin-bottom:6px;
            color:#0077b6; font-size:12px;
            text-transform:uppercase; letter-spacing:0.5px;
        }
        input, select {
            width:100%; padding:11px 14px; border:2px solid #C9CAD9;
            border-radius:10px; font-size:14px; transition:border 0.3s;
            background:#fafafa; font-family:'Inter', sans-serif;
        }
        input:focus, select:focus { outline:none; border-color:#0077b6; background:white; }
        button {
            width:100%; padding:13px; background:#0077b6; color:white;
            border:none; border-radius:25px; font-size:16px; font-weight:700;
            cursor:pointer; margin-top:10px; transition:all 0.3s;
            font-family:'Inter', sans-serif;
        }
        button:hover { background:#005f92; transform:translateY(-2px); }
        .error {
            color:#e74c3c; background:#fdf2f2; padding:10px 15px;
            border-radius:8px; border-left:4px solid #e74c3c;
            margin-bottom:15px; font-weight:600; font-size:13px;
        }
        .success {
            color:#27ae60; background:#eafaf1; padding:10px 15px;
            border-radius:8px; border-left:4px solid #27ae60;
            margin-bottom:15px; font-weight:600; font-size:13px;
        }
        .links { text-align:center; margin-top:18px; font-size:14px; }
        .links a { color:#0077b6; text-decoration:none; font-weight:600; }
        .links a:hover { text-decoration:underline; }
        .hint { font-size:11px; color:#888; margin-top:4px; }
    </style>
    <script>
        function validatePassword() {
            var pass = document.getElementById('password').value;
            var upper=0, lower=0, digit=0;
            for(var i=0; i<pass.length; i++) {
                if(pass[i]>='A' && pass[i]<='Z') upper++;
                else if(pass[i]>='a' && pass[i]<='z') lower++;
                else if(pass[i]>='0' && pass[i]<='9') digit++;
            }
            if(upper<1 || lower<3 || digit<1) {
                alert('Password must have at least 1 uppercase, 3 lowercase and 1 digit!');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="register-box">
        <div class="logo-section">
            <img src="images/logo.png" alt="Logo"/>
            <span>HealthSync</span>
        </div>
        <h2>Register New User</h2>

        <% if(request.getAttribute("error") != null) { %>
            <p class="error"><i class="bi bi-x-circle"></i> ${error}</p>
        <% } %>
        <% if(request.getAttribute("success") != null) { %>
            <p class="success"><i class="bi bi-check-circle"></i> ${success}</p>
        <% } %>

        <form action="${pageContext.request.contextPath}/register"
              method="post" onsubmit="return validatePassword()">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Enter full name" required/>
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required/>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Enter password" required/>
                <p class="hint">⚠️ Min 1 uppercase, 3 lowercase, 1 digit</p>
            </div>
            <div class="form-group">
                <label>User Type</label>
                <select name="usertype">
                    <option>DOCTOR</option>
                    <option>RECEPTIONIST</option>
                    <option>PATIENT</option>
                    <option>PHARMIST</option>
                    <option>CASHIER</option>
                </select>
            </div>
            <button type="submit">
                <i class="bi bi-person-plus"></i> REGISTER
            </button>
        </form>
        <div class="links">
            <a href="${pageContext.request.contextPath}/login.jsp">
                <i class="bi bi-arrow-left"></i> Already have account? Login
            </a>
        </div>
    </div>
</body>
</html>