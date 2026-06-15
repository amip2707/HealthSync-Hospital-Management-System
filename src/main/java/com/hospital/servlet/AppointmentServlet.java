package com.hospital.servlet;

import com.hospital.dao.AppointmentDAO;
import com.hospital.model.Appointment;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AppointmentDAO dao = new AppointmentDAO();
        HttpSession session = request.getSession();
        String usertype = (String)session.getAttribute("usertype");

        if(action.equals("add")) {
            Appointment a = new Appointment();
            a.setPid(request.getParameter("pid"));
            a.setAdate(request.getParameter("adate"));
            a.setPname(request.getParameter("pname"));
            a.setAgender(request.getParameter("agender"));
            a.setAdoctor(request.getParameter("adoctor"));
            a.setAtime(request.getParameter("atime"));
            a.setAtype(request.getParameter("atype"));
            a.setAproblem(request.getParameter("aproblem"));
            a.setAphone(request.getParameter("aphone"));

            boolean result = dao.addAppointment(a);

            if(result) {
                request.setAttribute("success",
                    "Appointment booked successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to book appointment!");
            }

            // Redirect based on role
            if("PATIENT".equals(usertype)) {
                // Patient → stay on book-appointment page
                request.getRequestDispatcher(
                    "/patient/book-appointment.jsp")
                       .forward(request, response);
                return;

            } else if("RECEPTIONIST".equals(usertype)) {
                // Admin → go to manage-appointments
                List<Appointment> list = dao.getAllAppointments();
                request.setAttribute("appointmentList", list);
                request.getRequestDispatcher(
                    "/admin/manage-appointments.jsp")
                       .forward(request, response);
                return;

            } else if("DOCTOR".equals(usertype)) {
                // Doctor → go to doctor appointments
                String docname = (String)session
                                .getAttribute("docname");
                List<Appointment> list = dao
                                .getAppointmentsByDoctor(docname);
                request.setAttribute("appointmentList", list);
                request.getRequestDispatcher(
                    "/doctor/appointments.jsp")
                       .forward(request, response);
                return;
            }
        }

        // Default based on role
        if("PATIENT".equals(usertype)) {
            request.getRequestDispatcher(
                "/patient/book-appointment.jsp")
                   .forward(request, response);

        } else if("RECEPTIONIST".equals(usertype)) {
            List<Appointment> list = dao.getAllAppointments();
            request.setAttribute("appointmentList", list);
            request.getRequestDispatcher(
                "/admin/manage-appointments.jsp")
                   .forward(request, response);

        } else {
            String docname = (String)session
                            .getAttribute("docname");
            List<Appointment> list = dao
                            .getAppointmentsByDoctor(docname);
            request.setAttribute("appointmentList", list);
            request.getRequestDispatcher(
                "/doctor/appointments.jsp")
                   .forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String usertype = (String)session.getAttribute("usertype");
        AppointmentDAO dao = new AppointmentDAO();

        if("PATIENT".equals(usertype)) {
            request.getRequestDispatcher(
                "/patient/book-appointment.jsp")
                   .forward(request, response);

        } else if("RECEPTIONIST".equals(usertype)) {
            List<Appointment> list = dao.getAllAppointments();
            request.setAttribute("appointmentList", list);
            request.getRequestDispatcher(
                "/admin/manage-appointments.jsp")
                   .forward(request, response);

        } else {
            String docname = (String)session
                            .getAttribute("docname");
            List<Appointment> list = dao
                            .getAppointmentsByDoctor(docname);
            request.setAttribute("appointmentList", list);
            request.getRequestDispatcher(
                "/doctor/appointments.jsp")
                   .forward(request, response);
        }
    }
}