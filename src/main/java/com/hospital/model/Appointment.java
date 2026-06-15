package com.hospital.model;

public class Appointment {

    private String pid;
    private String adate;
    private String pname;
    private String agender;
    private String adoctor;
    private String atime;
    private String atype;
    private String aproblem;
    private String aphone;

    // Constructor
    public Appointment() {}

    // Getters and Setters
    public String getPid() { return pid; }
    public void setPid(String pid) { this.pid = pid; }

    public String getAdate() { return adate; }
    public void setAdate(String adate) { this.adate = adate; }

    public String getPname() { return pname; }
    public void setPname(String pname) { this.pname = pname; }

    public String getAgender() { return agender; }
    public void setAgender(String agender) { this.agender = agender; }

    public String getAdoctor() { return adoctor; }
    public void setAdoctor(String adoctor) { this.adoctor = adoctor; }

    public String getAtime() { return atime; }
    public void setAtime(String atime) { this.atime = atime; }

    public String getAtype() { return atype; }
    public void setAtype(String atype) { this.atype = atype; }

    public String getAproblem() { return aproblem; }
    public void setAproblem(String aproblem) { this.aproblem = aproblem; }

    public String getAphone() { return aphone; }
    public void setAphone(String aphone) { this.aphone = aphone; }
}