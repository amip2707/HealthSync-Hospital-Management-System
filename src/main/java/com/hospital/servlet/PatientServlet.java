package com.hospital.servlet;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Patient;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/patient")
public class PatientServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        PatientDAO dao = new PatientDAO();

        if(action.equals("add")) {
            Patient p = new Patient();
            p.setPid(request.getParameter("pid"));
            p.setPdate(request.getParameter("pdate"));
            p.setPname(request.getParameter("pname"));
            p.setPgender(request.getParameter("pgender"));
            p.setPblood(request.getParameter("pblood"));
            p.setPsugar(request.getParameter("psugar"));
            p.setPpressure(request.getParameter("ppressure"));
            p.setPop(request.getParameter("pop"));
            p.setPphone(request.getParameter("pphone"));
            p.setPaddress(request.getParameter("paddress"));
            p.setTot(request.getParameter("tot"));
            p.setDoc_name(request.getParameter("doc_name"));

            boolean result = dao.addPatient(p);
            if(result) {
                request.setAttribute("success",
                    "Patient added successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to add patient!");
            }

        } else if(action.equals("delete")) {
            String pid = request.getParameter("pid");
            boolean result = dao.deletePatient(pid);
            if(result) {
                request.setAttribute("success",
                    "Patient deleted successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to delete patient!");
            }
        }

        // Reload patient list
        List<Patient> list = dao.getAllPatients();
        request.setAttribute("patientList", list);
        request.getRequestDispatcher("admin/manage-patients.jsp")
               .forward(request, response);
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        PatientDAO dao = new PatientDAO();
        List<Patient> list = dao.getAllPatients();
        request.setAttribute("patientList", list);
        request.getRequestDispatcher("admin/manage-patients.jsp")
               .forward(request, response);
    }
}