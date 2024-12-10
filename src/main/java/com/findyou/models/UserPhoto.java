package com.findyou.models;

import java.sql.Timestamp;

public class UserPhoto {
    private Long id;
    private Long userId;
    private String photo;
    private Timestamp deleteAt;
    
    public UserPhoto() {}
    
    
    // Constructor
    public UserPhoto(Long id, Long userId, String photo) {
        this.id = id;
        this.userId = userId;
        this.photo = photo;

    }
    
    public UserPhoto(Long userId, String photo) {
        
        this.userId = userId;
        this.photo = photo;

    }
    

    // Constructor
    public UserPhoto(Long id, Long userId, String photo, Timestamp deleteAt) {
        this.id = id;
        this.userId = userId;
        this.photo = photo;
        this.deleteAt = deleteAt;
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Timestamp getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(Timestamp deleteAt) {
        this.deleteAt = deleteAt;
    }
}
