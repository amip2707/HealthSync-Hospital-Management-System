package com.hospital.model;

public class Bill {

    private int id;
    private String name;
    private String docFees;
    private String roomFees;
    private String extraFees;
    private String totalFees;

    public Bill() {}

    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDocFees() { return docFees; }
    public void setDocFees(String docFees) { this.docFees = docFees; }

    public String getRoomFees() { return roomFees; }
    public void setRoomFees(String roomFees) { this.roomFees = roomFees; }

    public String getExtraFees() { return extraFees; }
    public void setExtraFees(String extraFees) { this.extraFees = extraFees; }

    public String getTotalFees() { return totalFees; }
    public void setTotalFees(String totalFees) { this.totalFees = totalFees; }
    
    public String getDoc_fees() { return docFees; }
    public void setDoc_fees(String v) { this.docFees = v; }

    public String getRoom_fees() { return roomFees; }
    public void setRoom_fees(String v) { this.roomFees = v; }

    public String getExtra_fees() { return extraFees; }
    public void setExtra_fees(String v) { this.extraFees = v; }

    public String getTotal_fees() { return totalFees; }
    public void setTotal_fees(String v) { this.totalFees = v; }
}