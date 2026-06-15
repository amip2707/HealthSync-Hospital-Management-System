package com.hospital.dao;

import com.hospital.model.Appointment;
import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    // ADD APPOINTMENT - based on your appointment.java
    public boolean addAppointment(Appointment a) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO patientappointments " +
                        "VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, a.getPid());
            pts.setString(2, a.getAdate());
            pts.setString(3, a.getPname());
            pts.setString(4, a.getAgender());
            pts.setString(5, a.getAdoctor());
            pts.setString(6, a.getAtime());
            pts.setString(7, a.getAtype());
            pts.setString(8, a.getAproblem());
            pts.setString(9, a.getAphone());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // GET ALL APPOINTMENTS
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM patientappointments";
            PreparedStatement pts = con.prepareStatement(sql);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Appointment a = new Appointment();
                a.setPid(rs.getString("pid"));
                a.setAdate(rs.getString("adate"));
                a.setPname(rs.getString("pname"));
                a.setAgender(rs.getString("agender"));
                a.setAdoctor(rs.getString("adoctor"));
                a.setAtime(rs.getString("atime"));
                a.setAtype(rs.getString("atype"));
                a.setAproblem(rs.getString("aproblem"));
                a.setAphone(rs.getString("aphone"));
                list.add(a);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET APPOINTMENTS BY DOCTOR
    public List<Appointment> getAppointmentsByDoctor(
                                        String docName) {
        List<Appointment> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM patientappointments " +
                        "WHERE adoctor=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, docName);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Appointment a = new Appointment();
                a.setPid(rs.getString("pid"));
                a.setAdate(rs.getString("adate"));
                a.setPname(rs.getString("pname"));
                a.setAgender(rs.getString("agender"));
                a.setAdoctor(rs.getString("adoctor"));
                a.setAtime(rs.getString("atime"));
                a.setAtype(rs.getString("atype"));
                a.setAproblem(rs.getString("aproblem"));
                a.setAphone(rs.getString("aphone"));
                list.add(a);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}