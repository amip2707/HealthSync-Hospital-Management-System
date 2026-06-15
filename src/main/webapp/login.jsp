<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>HealthSync - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <script src="https://unpkg.com/@lottiefiles/dotlottie-wc@0.9.10/dist/dotlottie-wc.js" type="module"></script>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:'Inter', sans-serif;
            background: linear-gradient(135deg, #D1D2F9, #A3BCF9);
            display:flex; justify-content:center;
            align-items:center; min-height:100vh;
        }
        .wrapper {
            display:flex; align-items:center;
            justify-content:center; gap:40px;
            padding:20px;
        }
        .animation-side {
            display:flex; flex-direction:column;
            align-items:center; justify-content:center;
        }
        .animation-side h2 {
            color:white; font-size:24px;
            font-weight:800; margin-top:10px;
            text-align:center; letter-spacing:1px;
        }
        .animation-side p {
            color:white; font-size:14px;
            text-align:center; margin-top:8px;
            opacity:0.9;
        }
        .login-box {
            background:white; padding:45px;
            border-radius:20px;
            box-shadow:0 10px 40px rgba(108,99,255,0.2);
            width:420px;
        }
        .form-group { margin-bottom:18px; }
        label {
            display:block; font-weight:600;
            margin-bottom:6px; color:#6C63FF;
            font-size:12px; text-transform:uppercase;
            letter-spacing:0.5px;
        }
        input, select {
            width:100%; padding:11px 14px;
            border:2px solid #C9CAD9;
            border-radius:10px; font-size:14px;
            transition:border 0.3s; background:#fafafa;
            font-family:'Inter', sans-serif;
        }
        input:focus, select:focus {
            outline:none; border-color:#6C63FF;
            background:white;
        }
        .login-btn {
            width:100%; padding:13px;
            background:#6C63FF; color:white;
            border:none; border-radius:25px;
            font-size:16px; font-weight:700;
            cursor:pointer; margin-top:10px;
            transition:all 0.3s; letter-spacing:1px;
            font-family:'Inter', sans-serif;
        }
        .login-btn:hover {
            background:#5a52d5;
            transform:translateY(-2px);
            box-shadow:0 5px 15px rgba(108,99,255,0.3);
        }
        .error {
            color:#e74c3c; background:#fdf2f2;
            padding:10px 15px; border-radius:8px;
            border-left:4px solid #e74c3c;
            margin-bottom:15px; font-weight:600;
            font-size:13px;
        }
        .success {
            color:#27ae60; background:#eafaf1;
            padding:10px 15px; border-radius:8px;
            border-left:4px solid #27ae60;
            margin-bottom:15px; font-weight:600;
            font-size:13px;
        }
        .links {
            text-align:center; margin-top:18px;
            font-size:14px;
        }
        .links a {
            color:#6C63FF; text-decoration:none;
            margin:0 8px; font-weight:600;
        }
        .links a:hover { text-decoration:underline; }
        .divider {
            text-align:center; color:#C9CAD9;
            margin:15px 0; font-size:12px;
        }
        .password-wrapper { position:relative; }
        .password-wrapper input { padding-right:45px; }
        .toggle-btn {
            position:absolute; right:14px; top:50%;
            transform:translateY(-50%);
            cursor:pointer; font-size:18px;
            color:#6C63FF; background:none;
            border:none; width:auto;
            padding:0; margin:0;
        }
        .toggle-btn:hover {
            background:none;
            transform:translateY(-50%);
            box-shadow:none;
            color:#5a52d5;
        }
    </style>
</head>
<body>
    <div class="wrapper">

        <!-- LEFT SIDE - ANIMATION -->
        <div class="animation-side">
            <dotlottie-wc 
                src="https://lottie.host/1426a652-8ad1-4654-9070-025c934f70f5/o4pESeSDrW.lottie"
                style="width:320px; height:320px;"
                autoplay loop>
            </dotlottie-wc>
            <h2>Welcome to HealthSync</h2>
            <p>Your trusted Hospital Management System</p>
        </div>

        <!-- RIGHT SIDE - LOGIN BOX -->
        <div class="login-box">

            <!-- LOGO + NAME -->
            <div style="text-align:center; margin-bottom:25px;">
                <div style="display:inline-flex; align-items:center;
                            justify-content:center;">
                    <img src="${pageContext.request.contextPath}/images/logo.png"
                         alt="HealthSync Logo"
                         style="width:80px; height:80px;
                                object-fit:contain; margin-right:12px;"/>
                    <span style="color:#6C63FF; font-size:32px;
                                 font-weight:800; letter-spacing:1px;
                                 font-family:'Inter', sans-serif;">
                        HealthSync
                    </span>
                </div>
            </div>

            <% if(request.getAttribute("error") != null) { %>
                <p class="error">❌ ${error}</p>
            <% } %>
            <% if(request.getAttribute("success") != null) { %>
                <p class="success">✅ ${success}</p>
            <% } %>

            <form action="${pageContext.request.contextPath}/login"
                  method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username"
                           placeholder="Enter username" required/>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <div class="password-wrapper">
                        <input type="password" id="password"
                               name="password"
                               placeholder="Enter password" required/>
                        <button type="button" class="toggle-btn"
                                onclick="togglePassword()">
                            <i class="bi bi-eye" id="eyeIcon"></i>
                        </button>
                    </div>
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
                <button type="submit" class="login-btn">LOGIN</button>
            </form>

            <div class="divider">─────────────────</div>
            <div class="links">
                <a href="${pageContext.request.contextPath}/register.jsp">
                    New User? Register
                </a>
                <a href="${pageContext.request.contextPath}/email.jsp">
                    Forgot Password?
                </a>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            var input = document.getElementById('password');
            var icon = document.getElementById('eyeIcon');
            if(input.type === 'password') {
                input.type = 'text';
                icon.className = 'bi bi-eye-slash';
            } else {
                input.type = 'password';
                icon.className = 'bi bi-eye';
            }
        }
    </script>
</body>
</html>