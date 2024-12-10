package com.findyou.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import com.findyou.models.Noti;
import com.findyou.models.User;

public class NotiDAO {
    private DataSource dataSource;

    public NotiDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // Create a new notification
    public void createNoti(Noti noti) {
        String sql = "INSERT INTO notifications (sId, rId, type, message, seen,created_at) VALUES (?, ?, ?, ?, ?,?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, noti.getsId());
            pStmt.setLong(2, noti.getrId());
            pStmt.setString(3, noti.getType());
            pStmt.setString(4, noti.getMessage());
            pStmt.setBoolean(5, false);
            pStmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a notification by setting deleted_at timestamp
    public void deleteNoti(Long id) {
        String sql = "UPDATE notifications SET deleted_at = ? WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pStmt.setLong(2, id);
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    public void seenNoti(Long id) {
        String sql = "UPDATE notifications SET seen = ? WHERE rId = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setBoolean(1, true);
            pStmt.setLong(2, id);
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Noti> getNotisByReceiverId(Long rId) {
        List<Noti> notis = new ArrayList<>();
        String sql = "SELECT n.id, n.sId, n.rId, n.type, n.message, n.seen, n.created_at, n.deleted_at, " +
                     "u.id AS sender_id, u.name AS sender_name, u.email AS sender_email, u.photo AS sender_photo " +
                     "FROM notifications n " +
                     "JOIN users u ON n.sId = u.id " +
                     "WHERE n.rId = ? AND n.deleted_at IS NULL";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, rId);
            try (ResultSet rs = pStmt.executeQuery()) {
                while (rs.next()) {
                    User sender = new User(
                        rs.getLong("sender_id"),
                        rs.getString("sender_name"),
                        rs.getString("sender_email"),
                        null, // Password is not needed here
                        rs.getString("sender_photo"),
                        null, // Gender is not needed here
                        null, // Bio is not needed here
                        null, // Hobby is not needed here
                        null, // Description is not needed here
                        null, // Batch ID is not needed here
                        null, // Birthday is not needed here
                        null, // Phone is not needed here
                        null, // Facebook link is not needed here
                        null, // Telegram link is not needed here
                        null, // TikTok link is not needed here
                        null  // Instagram link is not needed here
                    );

                    Noti noti = new Noti(
                        rs.getLong("id"),
                        rs.getLong("sId"),
                        rs.getLong("rId"),
                        rs.getString("type"),
                        rs.getString("message"),
                        rs.getBoolean("seen"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("deleted_at"),
                        sender
                    );
                    notis.add(noti);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notis;
    }

    public int countUnseenNotis(Long rId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE rId = ? AND seen = FALSE AND deleted_at IS NULL";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, rId);
            try (ResultSet rs = pStmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
