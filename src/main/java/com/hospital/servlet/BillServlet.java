package com.hospital.servlet;

import com.hospital.dao.BillDAO;
import com.hospital.model.Bill;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        BillDAO dao = new BillDAO();

        if(action.equals("add")) {
            // ADD BILL - based on billamount.java
            Bill b = new Bill();
            b.setName(request.getParameter("name"));
            b.setDocFees(request.getParameter("doc_fees"));
            b.setRoomFees(request.getParameter("room_fees"));
            b.setRoomFees(request.getParameter("extra_fees"));

            boolean result = dao.addBill(b);
            if(result) {
                request.setAttribute("success",
                    "Bill generated successfully!");
            } else {
                request.setAttribute("error",
                    "Failed to generate bill!");
            }

        } else if(action.equals("view")) {
            
            String name = request.getParameter("name");
            Bill b = dao.getBillByPatient(name);
            request.setAttribute("bill", b);
            request.getRequestDispatcher(
                "cashier/bill.jsp")
                   .forward(request, response);
            return;
        }

        // Reload all bills
        List<Bill> list = dao.getAllBills();
        request.setAttribute("billList", list);
        request.getRequestDispatcher(
            "cashier/bill.jsp")
               .forward(request, response);
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        BillDAO dao = new BillDAO();
        List<Bill> list = dao.getAllBills();
        request.setAttribute("billList", list);
        request.getRequestDispatcher(
            "cashier/bill.jsp")
               .forward(request, response);
    }
}