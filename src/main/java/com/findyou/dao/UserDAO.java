package com.findyou.dao;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.findyou.crypto.PasswordEncoder;
import com.findyou.crypto.PasswordValidator;
import com.findyou.models.Batch;
import com.findyou.models.User;

public class UserDAO {

	private final DataSource dataSource;
	private Connection connection;
	private PreparedStatement pStmt;
	private Statement stmt;
	private ResultSet rs;

	public UserDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	// Close resources
	private void close(Connection connection, PreparedStatement pStmt, ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
			if (pStmt != null)
				pStmt.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean createUser(User user) {
		boolean ok = false;
		String sql = "INSERT INTO users(name,email,password,photo,gender,batch_id) VALUES (?,?,?,?,?,?)";
		try {

			connection = dataSource.getConnection();
			pStmt = connection.prepareStatement(sql);
			pStmt.setString(1, user.getName());
			pStmt.setString(2, user.getEmail());
			try {
				pStmt.setString(3, PasswordEncoder.encode(user.getPassword()));
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvalidKeySpecException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pStmt.setString(4, user.getPhoto());
			pStmt.setString(5, user.getGender());
			pStmt.setLong(6, user.getBatch_id());

			int rowEffected = pStmt.executeUpdate();
			if (rowEffected > 0) {
				ok = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(connection, pStmt, null);
		}
		return ok;
	}

	public List<User> getAllUser() {
		List<User> users = new ArrayList<>();
		String sql = "SELECT * FROM users WHERE deleted_at IS NULL";
		try {
			connection = dataSource.getConnection();
			pStmt = connection.prepareStatement(sql);
			rs = pStmt.executeQuery();
			while (rs.next()) {
				users.add(new User(rs.getLong("id"), rs.getString("name"), rs.getString("email"),
						rs.getString("password"), rs.getString("photo"), rs.getString("gender"), rs.getString("bio"),
						rs.getString("hobby"), rs.getString("description"), rs.getLong("batch_id"),
						rs.getDate("birthday"), rs.getString("phone"), rs.getString("fbLink"), rs.getString("tgLink"), // Correcte
																														// //
																														// to
																														// //
																														// String
						rs.getString("ttLink"), // Corrected to String
						rs.getString("igLink")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(connection, pStmt, rs);
		}
		return users;
	}

	public User getUserByEmail(String email) {
		String sql = "SELECT * FROM users WHERE email = ?";
		try {
			connection = dataSource.getConnection();
			pStmt = connection.prepareStatement(sql);
			pStmt.setString(1, email);
			rs = pStmt.executeQuery();
			if (rs.next()) {
				return new User(rs.getLong("id"), rs.getString("name"), rs.getString("email"), rs.getString("password"),
						rs.getString("photo"), rs.getString("gender"), rs.getString("bio"), rs.getString("hobby"),
						rs.getString("description"), rs.getLong("batch_id"), rs.getDate("birthday"),
						rs.getString("phone"), rs.getString("fbLink"), rs.getString("tgLink"), // Corrected to String
						rs.getString("ttLink"), // Corrected to String
						rs.getString("igLink"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(connection, pStmt, rs);
		}
		return null;
	}

	public User getUserById(long userId) {
	    User user = null;
	    String sql = "SELECT u.id, u.name, u.email, u.password, u.photo, u.gender, u.bio, u.hobby, u.description, u.birthday, u.phone, u.fbLink, u.tgLink, u.ttLink, u.igLink,b.id as batch_id, b.batch as batch " +
	                 "FROM users u " +
	                 "JOIN batches b ON u.batch_id = b.id " +
	                 "WHERE u.id = ?";

	    try (Connection connection = dataSource.getConnection();
	         PreparedStatement pStmt = connection.prepareStatement(sql)) {
	        pStmt.setLong(1, userId);
	        try (ResultSet rs = pStmt.executeQuery()) {
	            if (rs.next()) {
	                user = new User();
	                user.setId(rs.getLong("id"));
	                user.setName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPassword(rs.getString("password"));
	                user.setPhoto(rs.getString("photo"));
	                user.setGender(rs.getString("gender"));
	                user.setBio(rs.getString("bio"));
	                user.setHobby(rs.getString("hobby"));
	                user.setDescription(rs.getString("description"));
	                user.setBirthday(rs.getDate("birthday"));
	                user.setPhone(rs.getString("phone"));
	                user.setFbLink(rs.getString("fbLink"));
	                user.setTgLink(rs.getString("tgLink"));
	                user.setTtLink(rs.getString("ttLink"));
	                user.setIgLink(rs.getString("igLink"));
	                user.setBatch_name(rs.getString("batch"));
	                user.setBatch_id(rs.getLong("batch_id"));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
			close(connection, pStmt, rs);
		}

	    return user;
	}
	
	
	public boolean updateUser(User user) {
		boolean ok = false;
	    String sql = "UPDATE Users SET name = ?, photo = ?, bio = ?, hobby = ?, description = ?, batch_id = ?, birthday = ?, phone = ?, fbLink = ?, tgLink = ?, ttLink = ?, igLink = ? WHERE id = ?";
	    try (Connection connection = dataSource.getConnection();
	         PreparedStatement pStmt = connection.prepareStatement(sql)) {
	        pStmt.setString(1, user.getName());
	        pStmt.setString(2, user.getPhoto());
	        pStmt.setString(3, user.getBio());
	        pStmt.setString(4, user.getHobby());
	        pStmt.setString(5, user.getDescription());
	        pStmt.setLong(6, user.getBatch_id());
	        
	        // Convert java.util.Date to java.sql.Date
	        java.sql.Date sqlBirthday = new java.sql.Date(user.getBirthday().getTime());
	        pStmt.setDate(7, sqlBirthday);
	        
	        pStmt.setString(8, user.getPhone());
	        pStmt.setString(9, user.getFbLink());
	        pStmt.setString(10, user.getTgLink());
	        pStmt.setString(11, user.getTtLink());
	        pStmt.setString(12, user.getIgLink());
	        pStmt.setLong(13, user.getId());
	        int count =  pStmt.executeUpdate();
	        
	        if(count != 0) {
	        	ok = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
			close(connection, pStmt, rs);
		}
	
	    
	    return ok;
	}



	

	public boolean isAuthenticated(String email, String password) {
		boolean ok = false;
		User user = getUserByEmail(email);

		try {
			if (user != null && PasswordValidator.validatePassword(password, user.getPassword()))
				ok = true;
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ok;

	}

}
