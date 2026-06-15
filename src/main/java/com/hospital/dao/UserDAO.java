package com.hospital.dao;

import com.hospital.model.User;
import com.hospital.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // LOGIN
    public User login(String username, String password,
                      String usertype) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();

            System.out.println("USERNAME: " + username);
            System.out.println("PASSWORD: " + password);
            System.out.println("USERTYPE: " + usertype);

            String sql = "SELECT * FROM access WHERE " +
                        "username=? AND password=? " +
                        "AND usertype=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, username);
            pts.setString(2, password);
            pts.setString(3, usertype);

            ResultSet rs = pts.executeQuery();

            if(rs.next()) {
                System.out.println("Found: TRUE");
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setUsertype(rs.getString("usertype"));
            } else {
                System.out.println("Found: FALSE");
            }

        } catch(Exception e) {
            e.printStackTrace();
            System.out.println("ERROR: " + e.getMessage());
        }
        return user;
    }

    // REGISTER
    public boolean register(User user) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO access " +
                        "(name,username,password,usertype) " +
                        "VALUES(?,?,?,?)";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, user.getName());
            pts.setString(2, user.getUsername());
            pts.setString(3, user.getPassword());
            pts.setString(4, user.getUsertype());

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // FORGOT PASSWORD
    public boolean updatePassword(String username,
                                  String newPassword) {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE access SET password=? " +
                        "WHERE username=?";
            PreparedStatement pts = con.prepareStatement(sql);
            pts.setString(1, newPassword);
            pts.setString(2, username);

            int i = pts.executeUpdate();
            if(i > 0) result = true;

        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}