<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - HealthSync</title>

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

        .box {
            background:white; padding:45px; border-radius:20px;
            box-shadow:0 10px 40px rgba(108,99,255,0.2); width:420px;
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

        input {
            width:100%; padding:11px 14px; border:2px solid #C9CAD9;
            border-radius:10px; font-size:14px;
            background:#fafafa; font-family:'Inter', sans-serif;
        }

        .btn {
            width:100%; padding:13px; border:none;
            border-radius:25px; font-size:15px;
            font-weight:700; cursor:pointer;
            margin-top:10px;
        }

        .btn-otp { background:#0077b6; color:white; }
        .btn-verify { background:#27ae60; color:white; }
        .btn-reset { background:#6C63FF; color:white; }

        #otpSection { display:none; margin-top:20px; }
        #passwordSection { display:none; margin-top:20px; }

        .links { text-align:center; margin-top:18px; font-size:14px; }

        .links a { color:#0077b6; text-decoration:none; font-weight:600; }

        .step-badge {
            background:#D1D2F9; color:#0077b6;
            padding:4px 12px; border-radius:20px;
            font-size:12px; font-weight:700;
            display:inline-block; margin-bottom:15px;
        }
    </style>

    <script>
        function sendOTP() {
            var email = document.getElementById('emailid').value;

            if(email === '') {
                alert('Please enter email!');
                return;
            }

            fetch('${pageContext.request.contextPath}/forgotpassword', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=sendOTP&email=' + encodeURIComponent(email)
            })
            .then(res => res.text())
            .then(data => {
                if(data.trim() === "OTP_SENT"){
                    alert("OTP sent to your email");
                    document.getElementById('otpSection').style.display = 'block';
                } else {
                    alert("Error sending OTP");
                }
            });
        }

        function verifyOTP() {
            var otp = document.getElementById('otp').value;

            if(otp === '') {
                alert('Enter OTP!');
                return;
            }

            fetch('${pageContext.request.contextPath}/forgotpassword', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=verifyOTP&otp=' + encodeURIComponent(otp)
            })
            .then(res => res.text())
            .then(data => {
                if(data.trim() === "SUCCESS"){
                    alert("OTP Verified");

                    document.getElementById('otpSection').style.display = 'none';
                    document.getElementById('passwordSection').style.display = 'block';

                    document.getElementById('hiddenUsername').value =
                        document.getElementById('emailid').value;

                } else {
                    alert("Invalid OTP");
                }
            });
        }
    </script>
</head>

<body>

<div class="box">

    <div class="logo-section">
        <img src="images/logo.png"/>
        <span>HealthSync</span>
    </div>

    <h2>Forgot Password</h2>

    <!-- STEP 1 -->
    <span class="step-badge">Step 1 — Enter Email</span>

    <div class="form-group">
        <label>Email / Username</label>
        <input type="text" id="emailid" placeholder="Enter your email"/>
    </div>

    <button class="btn btn-otp" onclick="sendOTP()">SEND OTP</button>

    <!-- STEP 2 -->
    <div id="otpSection">
        <span class="step-badge">Step 2 — Verify OTP</span>

        <div class="form-group">
            <label>Enter OTP</label>
            <input type="text" id="otp"/>
        </div>

        <button class="btn btn-verify" onclick="verifyOTP()">VERIFY OTP</button>
    </div>

    <!-- STEP 3 -->
    <div id="passwordSection">
        <span class="step-badge">Step 3 — Reset Password</span>

        <form action="${pageContext.request.contextPath}/forgotpassword" method="post">

            <input type="hidden" name="action" value="resetPassword">
            <input type="hidden" id="hiddenUsername" name="username"/>

            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newpassword"/>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmpassword"/>
            </div>

            <button type="submit" class="btn btn-reset">RESET PASSWORD</button>
        </form>
    </div>

    <div class="links">
        <a href="${pageContext.request.contextPath}/login.jsp">Back to Login</a>
    </div>

</div>

</body>
</html>