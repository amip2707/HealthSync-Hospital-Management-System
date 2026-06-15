package com.hospital.servlet;

import com.hospital.dao.RoomDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/room")
public class RoomServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        RoomDAO dao = new RoomDAO();

        if(action.equals("book")) {
            String i = request.getParameter("i");
            String j = request.getParameter("j");
            String pid = request.getParameter("pid");
            String pname = request.getParameter("pname");
            String age = request.getParameter("age");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String roomno = request.getParameter("roomno");
            String fees = request.getParameter("fees");

            boolean result = dao.bookRoom(i, j, pid, pname,
                                         age, gender, phone,
                                         roomno, fees);
            if(result) {
                request.setAttribute("success",
                    "Room booked successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to book room!");
            }

        } else if(action.equals("vacate")) {
            String i = request.getParameter("i");
            String j = request.getParameter("j");

            boolean result = dao.vacateRoom(i, j);
            if(result) {
                request.setAttribute("success",
                    "Room vacated successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to vacate room!");
            }
        }

        List<String[]> roomList = dao.getAllRooms();
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("admin/room-booking.jsp")
               .forward(request, response);
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        List<String[]> roomList = dao.getAllRooms();
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("admin/room-booking.jsp")
               .forward(request, response);
    }
}