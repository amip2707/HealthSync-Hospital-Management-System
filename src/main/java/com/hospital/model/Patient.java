package com.hospital.model;

public class Patient {

    private String pid;
    private String pdate;
    private String pname;
    private String pgender;
    private String pblood;
    private String psugar;
    private String ppressure;
    private String pop;
    private String pphone;
    private String paddress;
    private String tot;
    private String doc_name;

    // Constructor
    public Patient() {}

    // Getters and Setters
    public String getPid() { return pid; }
    public void setPid(String pid) { this.pid = pid; }

    public String getPdate() { return pdate; }
    public void setPdate(String pdate) { this.pdate = pdate; }

    public String getPname() { return pname; }
    public void setPname(String pname) { this.pname = pname; }

    public String getPgender() { return pgender; }
    public void setPgender(String pgender) { this.pgender = pgender; }

    public String getPblood() { return pblood; }
    public void setPblood(String pblood) { this.pblood = pblood; }

    public String getPsugar() { return psugar; }
    public void setPsugar(String psugar) { this.psugar = psugar; }

    public String getPpressure() { return ppressure; }
    public void setPpressure(String ppressure) { this.ppressure = ppressure; }

    public String getPop() { return pop; }
    public void setPop(String pop) { this.pop = pop; }

    public String getPphone() { return pphone; }
    public void setPphone(String pphone) { this.pphone = pphone; }

    public String getPaddress() { return paddress; }
    public void setPaddress(String paddress) { this.paddress = paddress; }

    public String getTot() { return tot; }
    public void setTot(String tot) { this.tot = tot; }

    public String getDoc_name() { return doc_name; }
    public void setDoc_name(String doc_name) { this.doc_name = doc_name; }
}