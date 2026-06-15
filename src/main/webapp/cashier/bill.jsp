<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, java.sql.*, com.hospital.model.*, com.hospital.dao.*"%>
<%@ page import="com.hospital.util.DBConnection"%>

<%
    if(session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()+"/login.jsp");
        return;
    }
%>


<jsp:useBean id="billDao" class="com.hospital.dao.BillDAO" scope="page"/>
<jsp:useBean id="bill" class="com.hospital.model.Bill" scope="page"/>
<jsp:setProperty name="bill" property="*"/>

<%
    List<Bill> billList = billDao.getAllBills();
%>

<!DOCTYPE html>
<html>
<head>
<title>Billing - HealthSync</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    background: #F8F8FF;
}

/* ===== NAVBAR ===== */

.navbar {
    background: #0077b6;
    color: #fff;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0, 119, 182, .3);
}

.navbar-left {
    display: flex;
    align-items: center;
    gap: 12px;
}

.navbar-left img {
    width: 40px;
    height: 40px;
}

.navbar-left h1 {
    font-size: 20px;
    font-weight: 800;
}

.nav-links {
    display: flex;
    gap: 10px;
}

.nav-btn {
    background: #fff;
    color: #0077b6;
    border: none;
    padding: 8px 18px;
    border-radius: 20px;
    font-weight: 700;
    font-size: 13px;
    text-decoration: none;
    transition: .3s;
}

.nav-btn.danger {
    background: #e74c3c;
    color: #fff;
}



.welcome {
    background: #D1D2F9;
    color: #0077b6;
    padding: 12px 30px;
    font-size: 14px;
    font-weight: 600;
    border-bottom: 2px solid #A3BCF9;
}



.container {
    padding: 25px 30px;
}

/* ===== BOXES ===== */

.form-box,
.table-box {
    background: #fff;
    padding: 25px;
    border-radius: 16px;
    box-shadow: 0 4px 15px rgba(108, 99, 255, .1);
    margin-bottom: 25px;
    border-top: 3px solid #A3BCF9;
}

.form-title,
.table-title {
    font-size: 16px;
    font-weight: 700;
    color: #0077b6;
    margin-bottom: 20px;
    border-left: 4px solid #0077b6;
    padding-left: 10px;
}



.form-row {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 15px;
}

.form-group {
    flex: 1;
    min-width: 150px;
}

label {
    display: block;
    font-weight: 600;
    margin-bottom: 6px;
    color: #0077b6;
    font-size: 12px;
    text-transform: uppercase;
}

input,
select {
    width: 100%;
    padding: 10px 12px;
    border: 2px solid #C9CAD9;
    border-radius: 10px;
    font-size: 13px;
    background: #fafafa;
    font-family: 'Inter', sans-serif;
}

input:focus,
select:focus {
    outline: none;
    border-color: #0077b6;
    background: #fff;
}

.btn-add {
    background: #0077b6;
    color: #fff;
    border: none;
    padding: 10px 22px;
    border-radius: 20px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    transition: .3s;
}

.btn-add:hover {
    transform: translateY(-2px);
}



table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
}

th {
    background: #0077b6;
    color: #fff;
    padding: 12px 10px;
    text-align: left;
    font-size: 12px;
    text-transform: uppercase;
}

td {
    padding: 11px 10px;
    border-bottom: 1px solid #C9CAD9;
}

tr:hover {
    background: #D1D2F9;
    cursor: pointer;
}

td:last-child {
    font-weight: 800;
    color: #0077b6;
    background: #D1D2F9;
}
</style>

</head>

<body>

<div class="navbar">
    <div class="navbar-left">
        <img src="${pageContext.request.contextPath}/images/logo.png"/>
        <h1>HealthSync</h1>
    </div>
</div>

<div class="welcome">
    Billing | Welcome, <strong>${sessionScope.username}</strong>
</div>

<div class="container">

    <!-- FORM -->
    <div class="form-box">
        <div class="form-title">Generate Bill</div>

        <form action="${pageContext.request.contextPath}/bill" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>Patient Name</label>
                    <select name="name" required>
                        <option value="">-- Select Patient --</option>
                        <%
                            Connection conP = DBConnection.getConnection();
                            PreparedStatement ptsP = conP.prepareStatement(
                                "SELECT pname FROM patientdetails ORDER BY pname");
                            ResultSet rsP = ptsP.executeQuery();
                            while(rsP.next()) {
                        %>
                        <option value="<%= rsP.getString("pname") %>">
                            <%= rsP.getString("pname") %>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Doctor Fees</label>
                    <input type="text" name="doc_fees"/>
                </div>

                <div class="form-group">
                    <label>Room Fees</label>
                    <input type="text" name="room_fees"/>
                </div>

                <div class="form-group">
                    <label>Extra Fees</label>
                    <input type="text" name="extra_fees"/>
                </div>
            </div>

            <button type="submit" class="btn-add">GENERATE BILL</button>
        </form>
    </div>

    <!-- TABLE -->
    <div class="table-box">
        <div class="table-title">All Bills</div>
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Doc Fees</th>
                <th>Room Fees</th><th>Extra Fees</th><th>Total</th>
            </tr>

            <% for(Bill b : billList) { %>
            <tr>
                <td><%= b.getId() %></td>
                <td><%= b.getName() %></td>
                <td><%= b.getDocFees() %></td>
                <td><%= b.getRoomFees() %></td>
                <td><%= b.getExtraFees() %></td>
                <td>₹ <%= b.getTotalFees() %></td>
            </tr>
            <% } %>

        </table>
    </div>

</div>
</body>
</html>