package com.findyou.models;

import java.sql.Timestamp;

public class Noti {
    private Long id;
    private Long sId;
    private Long rId;
    private String type;
    private String message;
    private boolean seen;
    private Timestamp createdAt;
    private Timestamp deletedAt;
    private User sender; // Add sender user object

    // Constructor
    public Noti(Long id, Long sId, Long rId, String type, String message, boolean seen, Timestamp createdAt, Timestamp deletedAt, User sender) {
        this.id = id;
        this.sId = sId;
        this.rId = rId;
        this.type = type;
        this.message = message;
        this.seen = seen;
        this.createdAt = createdAt;
        this.deletedAt = deletedAt;
        this.sender = sender;
    }
    
    public Noti( Long sId, Long rId, String type, String message) {
    	this.sId = sId;
        this.rId = rId;
        this.type = type;
        this.message = message;
       
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getsId() {
        return sId;
    }

    public void setsId(Long sId) {
        this.sId = sId;
    }

    public Long getrId() {
        return rId;
    }

    public void setrId(Long rId) {
        this.rId = rId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isSeen() {
        return seen;
    }

    public void setSeen(boolean seen) {
        this.seen = seen;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(Timestamp deletedAt) {
        this.deletedAt = deletedAt;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }
}
