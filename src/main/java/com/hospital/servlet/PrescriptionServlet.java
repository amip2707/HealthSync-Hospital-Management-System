package com.hospital.servlet;

import com.hospital.dao.PrescriptionDAO;
import com.hospital.model.Prescription;
import com.hospital.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/prescription")
public class PrescriptionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        PrescriptionDAO dao = new PrescriptionDAO();

        if ("add".equals(action)) {

            // ✅ ADD PRESCRIPTION
            Prescription p = new Prescription();
            p.setId(request.getParameter("id"));
            p.setName(request.getParameter("name"));
            p.setDocname(request.getParameter("docname"));
            p.setDescription(request.getParameter("description"));

            boolean result = dao.addPrescription(p);

            // ✅ INSERT INTO PATIENT RECORDS
            try {
                Connection con = DBConnection.getConnection();

                String sql = "INSERT INTO patientrecords(pdate, pname, pgender, pblood, psugar, ppressure, doc_name) VALUES (?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, LocalDate.now().toString());   // date
                ps.setString(2, request.getParameter("name")); // patient name
                ps.setString(3, "N/A");
                ps.setString(4, "N/A");
                ps.setString(5, "N/A");
                ps.setString(6, "N/A");
                ps.setString(7, request.getParameter("docname"));

                ps.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
            }

            if (result) {
                request.setAttribute("success",
                    "Prescription + Record added successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to add prescription!");
            }

        } else if ("order".equals(action)) {

            Prescription p = new Prescription();
            p.setId(request.getParameter("id"));
            p.setName(request.getParameter("name"));
            p.setDocname(request.getParameter("docname"));
            p.setDescription(request.getParameter("description"));
            p.setQuantity(request.getParameter("quantity"));
            p.setAmount(request.getParameter("amount"));

            boolean result = dao.addPrescriptionOrder(p);

            if (result) {
                request.setAttribute("success",
                    "Order placed successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to place order!");
            }

        } else if ("view".equals(action)) {

            String name = request.getParameter("name");
            List<Prescription> list =
                dao.getPrescriptionByPatient(name);

            request.setAttribute("prescriptionList", list);
            request.getRequestDispatcher("doctor/prescription.jsp")
                   .forward(request, response);
            return;
        }

        request.getRequestDispatcher("doctor/prescription.jsp")
               .forward(request, response);
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("doctor/prescription.jsp")
               .forward(request, response);
    }
}