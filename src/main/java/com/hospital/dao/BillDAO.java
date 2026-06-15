package com.hospital.dao;

import com.hospital.model.Bill;
import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    // ADD BILL - based on billamount.java
    public boolean addBill(Bill b) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO medical_bills " +
                        "(name,doc_fees,room_fees,extra_fees)" +
                        " VALUES(?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, b.getName());
            pts.setString(2, b.getDoc_fees());
            pts.setString(3, b.getRoom_fees());
            pts.setString(4, b.getExtra_fees());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // GET BILL BY PATIENT
    public Bill getBillByPatient(String name) {
        Bill b = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM medical_bills " +
                        "WHERE name=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, name);
            ResultSet rs = pts.executeQuery();

            if(rs.next()) {
                b = new Bill();
                b.setId(rs.getInt("id"));
                b.setName(rs.getString("name"));
                b.setDocFees(rs.getString("doc_fees"));
                b.setExtraFees(rs.getString("room_fees"));
                b.setExtraFees(rs.getString("extra_fees"));
                b.setTotalFees(rs.getString("total_fees"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return b;
    }

    // GET ALL BILLS
    public List<Bill> getAllBills() {
        List<Bill> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM medical_bills";
            PreparedStatement pts = con.prepareStatement(sql);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("id"));
                b.setName(rs.getString("name"));
                b.setDocFees(rs.getString("doc_fees"));
                b.setRoomFees(rs.getString("room_fees"));
                b.setExtraFees(rs.getString("extra_fees"));
                b.setTotalFees(rs.getString("total_fees"));
                list.add(b);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}