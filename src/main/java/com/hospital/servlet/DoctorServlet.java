package com.hospital.servlet;

import com.hospital.dao.DoctorDAO;
import com.hospital.model.Doctor;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        DoctorDAO dao = new DoctorDAO();

        if(action.equals("add")) {
            Doctor d = new Doctor();
            d.setDid(request.getParameter("did"));
            d.setDname(request.getParameter("dname"));
            d.setDqualification(
                request.getParameter("dqualification"));
            d.setDspecialist(
                request.getParameter("dspecialist"));
            d.setBphone(request.getParameter("bphone"));
            d.setDavailability(
                request.getParameter("davailability"));

            boolean result = dao.addDoctor(d);
            if(result) {
                request.setAttribute("success",
                    "Doctor added successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to add doctor!");
            }

        } else if(action.equals("update")) {
            Doctor d = new Doctor();
            d.setDid(request.getParameter("did"));
            d.setDname(request.getParameter("dname"));
            d.setDqualification(
                request.getParameter("dqualification"));
            d.setDspecialist(
                request.getParameter("dspecialist"));
            d.setBphone(request.getParameter("bphone"));
            d.setDavailability(
                request.getParameter("davailability"));

            boolean result = dao.updateDoctor(d);
            if(result) {
                request.setAttribute("success",
                    "Doctor updated successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to update doctor!");
            }

        } else if(action.equals("delete")) {
            String did = request.getParameter("did");
            boolean result = dao.deleteDoctor(did);
            if(result) {
                request.setAttribute("success",
                    "Doctor deleted successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to delete doctor!");
            }
        }

        // Reload doctor list
        List<Doctor> list = dao.getAllDoctors();
        request.setAttribute("doctorList", list);
        request.getRequestDispatcher("admin/manage-doctors.jsp")
               .forward(request, response);
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        DoctorDAO dao = new DoctorDAO();
        List<Doctor> list = dao.getAllDoctors();
        request.setAttribute("doctorList", list);
        request.getRequestDispatcher("admin/manage-doctors.jsp")
               .forward(request, response);
    }
}