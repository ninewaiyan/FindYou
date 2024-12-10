package com.findyou.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

import com.findyou.models.Matches;
import com.findyou.models.User;

public class MatchesDAO {
    private DataSource dataSource;

    public MatchesDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // Create a new match
    public void createMatch(Matches match) {
        String sql = "INSERT INTO matches (sId, rId, createdAt) VALUES (?, ?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, match.getsId());
            pStmt.setLong(2, match.getrId());
            pStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis())); // Set current time
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a match by setting deletedAt timestamp
    public void deleteMatch(Long id) {
        String sql = "UPDATE matches SET deletedAt = ? WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pStmt.setLong(2, id);
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get matches by receiver ID
    public List<Matches> getMatchesByuserId(Long rId) {
        List<Matches> matches = new ArrayList<>();
        String sql = "SELECT id, sId, rId, createdAt, deletedAt FROM matches WHERE rId = ? OR sId = ? AND deletedAt IS NULL";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setLong(1, rId);
            try (ResultSet rs = pStmt.executeQuery()) {
                while (rs.next()) {
                    Matches match = new Matches(
                        rs.getLong("id"),
                        rs.getLong("sId"),
                        rs.getLong("rId"),
                        rs.getTimestamp("createdAt"),
                        rs.getTimestamp("deletedAt")
                    );
                    matches.add(match);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matches;
    }
    
    public List<Matches> getAllMatches() {
        List<Matches> matches = new ArrayList<>();
        String sql = "SELECT * FROM matches Where  deletedAt Is Null";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql);
             ResultSet rs = pStmt.executeQuery()) {
            while (rs.next()) {
                Matches match = new Matches(
                    rs.getLong("id"),
                    rs.getLong("sId"),
                    rs.getLong("rId"),
                    rs.getTimestamp("createdAt"),
                    rs.getTimestamp("deletedAt")
                );
                matches.add(match);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matches;
    }
    
    public void unmatch(Long sId, Long rId) {
        System.out.println("in unmatchDAO");
        String sql = "UPDATE matches SET deletedAt = ? WHERE ((sId = ? AND rId = ?) OR (sId = ? AND rId = ?)) AND deletedAt IS NULL";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pStmt = connection.prepareStatement(sql)) {
            pStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pStmt.setLong(2, sId);
            pStmt.setLong(3, rId);
            pStmt.setLong(4, rId);
            pStmt.setLong(5, sId);
            pStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



}
