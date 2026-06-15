package com.hospital.servlet;

import com.hospital.dao.UserDAO;
import com.hospital.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name     = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");

        User user = new User();
        user.setName(name);
        user.setUsername(username);
        user.setPassword(password);
        user.setUsertype(usertype);

        UserDAO dao = new UserDAO();
        boolean result = dao.register(user);

        if(result) {
            request.setAttribute("success",
                "Account registered successfully!");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error",
                "Registration failed! Try again.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp")
               .forward(request, response);
    }
}