package com.hospital.servlet;

import com.hospital.dao.UserDAO;
import com.hospital.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");

        UserDAO dao = new UserDAO();
        User user = dao.login(username, password, usertype);

        if(user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("usertype", user.getUsertype());
            session.setAttribute("docname", user.getName());

            // Redirect based on usertype
            if(usertype.equals("DOCTOR")) {
                response.sendRedirect(
                    request.getContextPath()+
                    "/doctor/dashboard.jsp");
            } else if(usertype.equals("RECEPTIONIST")) {
                response.sendRedirect(
                    request.getContextPath()+
                    "/admin/dashboard.jsp");
            } else if(usertype.equals("PHARMIST")) {
                response.sendRedirect(
                    request.getContextPath()+
                    "/pharmacy/dashboard.jsp");
            } else if(usertype.equals("CASHIER")) {
                response.sendRedirect(
                    request.getContextPath()+
                    "/cashier/dashboard.jsp");
            } else {
                response.sendRedirect(
                    request.getContextPath()+
                    "/patient/dashboard.jsp");
            }
        } else {
            request.setAttribute("error",
                                 "Invalid credentials!");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp")
               .forward(request, response);
    }
}