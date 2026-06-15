package com.hospital.dao;

import com.hospital.model.Doctor;
import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    // ADD DOCTOR - based on your docdetails.java btnAdd
    public boolean addDoctor(Doctor d) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO doctdetails VALUES" +
                        "(?,?,?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, d.getDid());
            pts.setString(2, d.getDname());
            pts.setString(3, d.getDqualification());
            pts.setString(4, d.getDspecialist());
            pts.setString(5, d.getBphone());
            pts.setString(6, d.getDavailability());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // GET ALL DOCTORS - based on your docdetails.java btnShow
    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM doctdetails";
            PreparedStatement pts = con.prepareStatement(sql);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Doctor d = new Doctor();
                d.setDid(rs.getString("did"));
                d.setDname(rs.getString("dname"));
                d.setDqualification(rs.getString("dqualification"));
                d.setDspecialist(rs.getString("dspecialist"));
                d.setBphone(rs.getString("bphone"));
                d.setDavailability(rs.getString("davailability"));
                list.add(d);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // UPDATE DOCTOR - based on your docdetails.java btnUpdate
    public boolean updateDoctor(Doctor d) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE doctdetails SET dname=?," +
                        "dqualification=?,dspecialist=?," +
                        "bphone=?,davailability=? " +
                        "WHERE did=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, d.getDname());
            pts.setString(2, d.getDqualification());
            pts.setString(3, d.getDspecialist());
            pts.setString(4, d.getBphone());
            pts.setString(5, d.getDavailability());
            pts.setString(6, d.getDid());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // DELETE DOCTOR - based on your docdetails.java btnDelete
    public boolean deleteDoctor(String did) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM doctdetails WHERE did=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, did);

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // CHECK AVAILABILITY - based on your docdetails.java VERIFY
    public boolean checkAvailability(String dname) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM doctdetails WHERE " +
                        "dname=? AND davailability='YES'";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, dname);
            ResultSet rs = pts.executeQuery();
            if(rs.next()) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}