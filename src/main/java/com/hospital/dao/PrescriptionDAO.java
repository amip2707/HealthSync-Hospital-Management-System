package com.hospital.dao;

import com.hospital.model.Prescription;
import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDAO {

    // ADD PRESCRIPTION
    public boolean addPrescription(Prescription p) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO prescription " +
                        "VALUES(?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, p.getId());
            pts.setString(2, p.getName());
            pts.setString(3, p.getDocname());
            pts.setString(4, p.getDescription());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ADD PRESCRIPTION ORDER
    public boolean addPrescriptionOrder(Prescription p) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO prescriptionview " +
                        "(id,name,docname,description," +
                        "quantity,amount,tot_amount) " +
                        "VALUES(?,?,?,?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, p.getId());
            pts.setString(2, p.getName());
            pts.setString(3, p.getDocname());
            pts.setString(4, p.getDescription());
            pts.setString(5, p.getQuantity());
            pts.setString(6, p.getAmount());

            // AUTO CALCULATE total amount
            try {
                double qty = Double.parseDouble(p.getQuantity());
                double amt = Double.parseDouble(p.getAmount());
                pts.setString(7, String.valueOf(qty * amt));
            } catch(Exception ex) {
                pts.setString(7, "0");
            }

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // GET PRESCRIPTION BY PATIENT
    public List<Prescription> getPrescriptionByPatient(
                                        String name) {
        List<Prescription> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM prescriptionview " +
                        "WHERE name=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, name);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Prescription p = new Prescription();
                p.setId(rs.getString("id"));
                p.setName(rs.getString("name"));
                p.setDocname(rs.getString("docname"));
                p.setDescription(rs.getString("description"));
                p.setQuantity(rs.getString("quantity"));
                p.setAmount(rs.getString("amount"));
                p.setTot_amount(rs.getString("tot_amount"));
                list.add(p);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}