package com.findyou.models;

import java.sql.Timestamp;

public class Matches {
    private Long id;
    private Long sId;
    private Long rId;
    private Timestamp createdAt;
    private Timestamp deletedAt;

    // Constructor
    public Matches(Long id, Long sId, Long rId, Timestamp createdAt, Timestamp deletedAt) {
        this.id = id;
        this.sId = sId;
        this.rId = rId;
        this.createdAt = createdAt;
        this.deletedAt = deletedAt;
    }
    
    public Matches( Long sId, Long rId) {
        
        this.sId = sId;
        this.rId = rId;
       
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
}
