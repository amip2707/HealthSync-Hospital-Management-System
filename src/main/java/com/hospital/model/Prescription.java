package com.hospital.model;

public class Prescription {

    private String id;
    private String name;
    private String docname;
    private String description;
    private String quantity;
    private String amount;
    private String tot_amount;

    // Constructor
    public Prescription() {}

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDocname() { return docname; }
    public void setDocname(String docname) { 
        this.docname = docname; 
    }

    public String getDescription() { return description; }
    public void setDescription(String description) { 
        this.description = description; 
    }

    public String getQuantity() { return quantity; }
    public void setQuantity(String quantity) { 
        this.quantity = quantity; 
    }

    public String getAmount() { return amount; }
    public void setAmount(String amount) { 
        this.amount = amount; 
    }

    public String getTot_amount() { return tot_amount; }
    public void setTot_amount(String tot_amount) { 
        this.tot_amount = tot_amount; 
    }
}