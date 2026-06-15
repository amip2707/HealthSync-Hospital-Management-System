package com.hospital.servlet;

import com.hospital.dao.UserDAO;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        // ================= SEND OTP =================
        if ("sendOTP".equals(action)) {

            String email = request.getParameter("email");

            String otp = String.valueOf(100000 + new java.util.Random().nextInt(900000));
            session.setAttribute("otp", otp);

            final String fromEmail = "amip2702@gmail.com";
            final String password = "yuebfqutesybseyx";

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session mailSession = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(fromEmail));
                message.setRecipients(Message.RecipientType.TO,
                        InternetAddress.parse(email));
                message.setSubject("OTP Verification");
                message.setText("Your OTP is: " + otp);

                Transport.send(message);

                response.getWriter().print("OTP_SENT");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ================= VERIFY OTP =================
        else if ("verifyOTP".equals(action)) {

            String entered = request.getParameter("otp");
            String real = (String) session.getAttribute("otp");

            if (real != null && real.equals(entered)) {
                session.setAttribute("otpVerified", true);
                response.getWriter().print("SUCCESS");
            } else {
                response.getWriter().print("FAIL");
            }
        }

        // ================= RESET PASSWORD =================
        else if ("resetPassword".equals(action)) {

            Boolean verified = (Boolean) session.getAttribute("otpVerified");

            if (verified == null || !verified) {
                request.setAttribute("error", "Verify OTP first!");
                request.getRequestDispatcher("email.jsp").forward(request, response);
                return;
            }

            String username = request.getParameter("username");
            String newpassword = request.getParameter("newpassword");
            String confirmpassword = request.getParameter("confirmpassword");

            if (newpassword.equals(confirmpassword)) {

                UserDAO dao = new UserDAO();
                boolean result = dao.updatePassword(username, newpassword);

                if (result) {
                    session.removeAttribute("otpVerified");
                    request.setAttribute("success", "Password updated!");
                } else {
                    request.setAttribute("error", "Update failed!");
                }

            } else {
                request.setAttribute("error", "Passwords do not match!");
            }

            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}