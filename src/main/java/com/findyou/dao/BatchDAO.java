package com.findyou.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.findyou.models.Batch;



public class BatchDAO {
	
	private final DataSource dataSource;
    private Connection connection;
    private PreparedStatement pStmt;
	private Statement stmt;
    private ResultSet rs;

    public BatchDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // Close resources
    private void close(Connection connection, PreparedStatement pStmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pStmt != null) pStmt.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Batch> getAllBatch() {
        List<Batch> batches = new ArrayList<>();
        String sql = "SELECT * FROM batches WHERE deleted_at is NULL";
        try {
            connection = dataSource.getConnection();
            pStmt = connection.prepareStatement(sql);
            rs = pStmt.executeQuery();
            while (rs.next()) {
               batches.add(new Batch(
                    rs.getLong("id"),
                    rs.getString("batch")
                    
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(connection, pStmt, rs);
        }
        return batches;
    }

}
