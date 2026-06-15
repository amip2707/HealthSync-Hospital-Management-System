package com.hospital.dao;

import com.hospital.model.Patient;
import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    // ADD PATIENT
    public boolean addPatient(Patient p) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO patientdetails VALUES" +
                        "(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, p.getPid());
            pts.setString(2, p.getPdate());
            pts.setString(3, p.getPname());
            pts.setString(4, p.getPgender());
            pts.setString(5, p.getPblood());
            pts.setString(6, p.getPsugar());
            pts.setString(7, p.getPpressure());
            pts.setString(8, p.getPop());
            pts.setString(9, p.getPphone());
            pts.setString(10, p.getPaddress());
            pts.setString(11, p.getTot());
            pts.setString(12, p.getDoc_name());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // GET ALL PATIENTS
    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM patientdetails";
            PreparedStatement pts = con.prepareStatement(sql);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Patient p = new Patient();
                p.setPid(rs.getString("pid"));
                p.setPdate(rs.getString("pdate"));
                p.setPname(rs.getString("pname"));
                p.setPgender(rs.getString("pgender"));
                p.setPblood(rs.getString("pblood"));
                p.setPsugar(rs.getString("psugar"));
                p.setPpressure(rs.getString("ppressure"));
                p.setPop(rs.getString("pop"));
                p.setPphone(rs.getString("pphone"));
                p.setPaddress(rs.getString("paddress"));
                p.setTot(rs.getString("tot"));
                p.setDoc_name(rs.getString("doc_name"));
                list.add(p);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // GET PATIENTS BY DOCTOR
    public List<Patient> getPatientsByDoctor(String docName) {
        List<Patient> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM patientdetails " +
                        "WHERE doc_name=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, docName);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                Patient p = new Patient();
                p.setPid(rs.getString("pid"));
                p.setPdate(rs.getString("pdate"));
                p.setPname(rs.getString("pname"));
                p.setPgender(rs.getString("pgender"));
                p.setPblood(rs.getString("pblood"));
                p.setPsugar(rs.getString("psugar"));
                p.setPpressure(rs.getString("ppressure"));
                p.setPop(rs.getString("pop"));
                p.setPphone(rs.getString("pphone"));
                p.setPaddress(rs.getString("paddress"));
                p.setTot(rs.getString("tot"));
                p.setDoc_name(rs.getString("doc_name"));
                list.add(p);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // DELETE PATIENT
    public boolean deletePatient(String pid) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM patientdetails " +
                        "WHERE pid=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, pid);
            int i = pts.executeUpdate();
            if(i > 0) result = true;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}