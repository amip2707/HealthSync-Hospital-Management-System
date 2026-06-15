package com.hospital.dao;

import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // BOOK ROOM - based on roombook.java
    public boolean bookRoom(String i, String j, String id,
                            String name, String age,
                            String gender, String phone,
                            String roomno, String fees) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO roo VALUES(?,?,?,?,?,?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, i);
            pts.setString(2, j);
            pts.setString(3, id);
            pts.setString(4, name);
            pts.setString(5, age);
            pts.setString(6, gender);
            pts.setString(7, phone);
            pts.setString(8, roomno);
            pts.setString(9, fees);

            int r = pts.executeUpdate();
            if(r > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // DELETE/VACATE ROOM - based on roombook.java DELETE
    public boolean vacateRoom(String i, String j) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM roo WHERE i=? AND j=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, i);
            pts.setString(2, j);

            int r = pts.executeUpdate();
            if(r > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // GET ALL BOOKED ROOMS
    public List<String[]> getAllRooms() {
        List<String[]> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM roo";
            PreparedStatement pts = con.prepareStatement(sql);
            ResultSet rs = pts.executeQuery();

            while(rs.next()) {
                String[] room = {
                    rs.getString("i"),
                    rs.getString("j"),
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("age"),
                    rs.getString("gender"),
                    rs.getString("phone_no"),
                    rs.getString("roomno"),
                    rs.getString("fees")
                };
                list.add(room);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // CHECK IF ROOM IS BOOKED
    public boolean isRoomBooked(String i, String j) {
        boolean booked = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM roo WHERE i=? AND j=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, i);
            pts.setString(2, j);
            ResultSet rs = pts.executeQuery();
            if(rs.next()) booked = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return booked;
    }
}