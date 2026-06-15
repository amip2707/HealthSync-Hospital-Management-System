package com.hospital.model;

public class Doctor {

    private String did;
    private String dname;
    private String dqualification;
    private String dspecialist;
    private String bphone;
    private String davailability;

    // Constructor
    public Doctor() {}

    public Doctor(String did, String dname, String dqualification,
                  String dspecialist, String bphone, 
                  String davailability) {
        this.did = did;
        this.dname = dname;
        this.dqualification = dqualification;
        this.dspecialist = dspecialist;
        this.bphone = bphone;
        this.davailability = davailability;
    }

    // Getters and Setters
    public String getDid() { return did; }
    public void setDid(String did) { this.did = did; }

    public String getDname() { return dname; }
    public void setDname(String dname) { this.dname = dname; }

    public String getDqualification() { return dqualification; }
    public void setDqualification(String dqualification) { 
        this.dqualification = dqualification; 
    }

    public String getDspecialist() { return dspecialist; }
    public void setDspecialist(String dspecialist) { 
        this.dspecialist = dspecialist; 
    }

    public String getBphone() { return bphone; }
    public void setBphone(String bphone) { this.bphone = bphone; }

    public String getDavailability() { return davailability; }
    public void setDavailability(String davailability) { 
        this.davailability = davailability; 
    }
}