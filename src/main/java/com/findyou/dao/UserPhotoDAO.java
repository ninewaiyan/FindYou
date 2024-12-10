package com.findyou.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import com.findyou.models.UserPhoto;

public class UserPhotoDAO {
    private DataSource dataSource;

    public UserPhotoDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // Create a new photo
    public void createUserPhoto(UserPhoto userPhoto) {
    	
        String sql = "INSERT INTO user_photos (user_id, photo) VALUES (?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, userPhoto.getUserId());
            pStmt.setString(2, userPhoto.getPhoto());
            pStmt.executeUpdate();
           
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        
    }

    // Delete a photo by setting delete_at timestamp
    public void deleteUserPhoto(Long id) {
        String sql = "UPDATE user_photos SET delete_at = ? WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pStmt.setLong(2, id);
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get photos by user ID
    public List<UserPhoto> getUserPhotosByUserId(Long userId) {
        List<UserPhoto> userPhotos = new ArrayList<>();
        String sql = "SELECT id, user_id, photo FROM user_photos WHERE user_id = ? AND delete_at IS NULL";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, userId);
            try (ResultSet rs = pStmt.executeQuery()) {
                while (rs.next()) {
                    UserPhoto userPhoto = new UserPhoto(
                        rs.getLong("id"),
                        rs.getLong("user_id"),
                        rs.getString("photo")
                        
                    );
                    userPhotos.add(userPhoto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userPhotos;
    }
}
