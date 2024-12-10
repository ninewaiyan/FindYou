package com.findyou.controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.sql.DataSource;

import com.findyou.dao.BatchDAO;
import com.findyou.dao.MatchesDAO;
import com.findyou.dao.NotiDAO;
import com.findyou.dao.UserDAO;
import com.findyou.dao.UserPhotoDAO;
import com.findyou.models.Batch;
import com.findyou.models.Matches;
import com.findyou.models.Noti;
import com.findyou.models.User;
import com.findyou.models.UserPhoto;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(location = "C:\\JavaEE_Workspace\\findyou\\src\\main\\webapp\\template\\user\\images", fileSizeThreshold = 1024
		* 1024, // 1 MB
		maxFileSize = 1024 * 1024 * 10000, // 10000MB
		maxRequestSize = 1024 * 1024 * 10000 // 10000 MB
)
@WebServlet("/user")
public class UserController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Set<String> ALLOWED_MIME_TYPES = new HashSet<>();

	static {
		ALLOWED_MIME_TYPES.add("image/jpeg");
		ALLOWED_MIME_TYPES.add("image/png");
		ALLOWED_MIME_TYPES.add("image/jpg");
	}

	@Resource(name = "jdbc/findyou_site")
	private DataSource dataSource;

	private UserDAO userDAO;
	private BatchDAO batchDAO;
	private UserPhotoDAO userPhotoDAO;
	private NotiDAO notiDAO;
	private MatchesDAO matchesDAO;

	@Override
	public void init() throws ServletException {
		userDAO = new UserDAO(dataSource);
		batchDAO = new BatchDAO(dataSource);
		userPhotoDAO = new UserPhotoDAO(dataSource);
		notiDAO = new NotiDAO(dataSource);
		matchesDAO = new MatchesDAO(dataSource);
	}

	public UserController() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mode = req.getParameter("mode");
		String user_id = req.getParameter("id");
		Long id = (long) -1;

		if (user_id != null) {
			id = Long.parseLong(user_id);
		}

		if (mode == null) {
			mode = "FORM";
		}

		switch (mode) {
		case "FORM":
			showRegisterForm(req, resp);
			break;
		case "REGISTER":
			register(req, resp);
			break;
		case "PROFILE":
			profile(id, req, resp);
			break;
		case "EDIT":
			edit(req, resp);
			break;
		case "UPDATE":
			update(req, resp);
			break;
		case "VIEW":
			view(req, resp);
			break;
		case "FLIP":
			flip(req, resp);
			break;
		case "MATCH":
			match(req,resp);
		case "ACCEPT":
			accept(req, resp);
			break;
		case "UNMATCH":
			unmatch(req, resp);
			break;

		default:
			showRegisterForm(req, resp);
			break;
		}
	}

	protected void showRegisterForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		List<Batch> batches = batchDAO.getAllBatch();
		req.setAttribute("batches", batches);
		RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/register.jsp");
		dispatcher.forward(req, resp);
	}

	protected void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String gender = req.getParameter("gender");
		Long batch_id = Long.parseLong(req.getParameter("batch_id"));
		String fileName = null;
		String message = "";

		boolean ok = false;

		User existedEmail = userDAO.getUserByEmail(email);

		if (existedEmail != null) {
			req.setAttribute("name", name);
			req.setAttribute("email", email);
			req.setAttribute("ok", ok);
			req.setAttribute("message", "Email already exists!");
			showRegisterForm(req, resp);
			return;
		} else {
			try {
				Part imagePart = req.getPart("photo");
				if (imagePart != null && imagePart.getSize() > 0) {
					fileName = getFileName(imagePart);
					String imageMimeType = imagePart.getContentType();

					if (!ALLOWED_MIME_TYPES.contains(imageMimeType)) {
						req.setAttribute("name", name);
						req.setAttribute("email", email);
						req.setAttribute("ok", ok);
						req.setAttribute("message", "Unsupported file type or no file uploaded!");
						showRegisterForm(req, resp);
						return;
					} else {
						if (fileName != null) {
							String uniqueImageName = generateUniqueFileName(fileName);
							imagePart.write(uniqueImageName);

							User newUser = new User(name, email, password, uniqueImageName, gender, batch_id);
							ok = userDAO.createUser(newUser);
						}
					}
				}

				if (ok) {

					message = "User registered successfully!";
					req.setAttribute("ok", ok);
					req.setAttribute("message", message);
					showRegisterForm(req, resp);
				} else {
					message = "Registration failed";
					req.setAttribute("ok", ok);
					req.setAttribute("name", name);
					req.setAttribute("email", email);
					req.setAttribute("message", message);
					showRegisterForm(req, resp);
				}

			} catch (Exception ex) {
				message = "Error uploading file or processing request: ";
				req.setAttribute("message", message);
				req.setAttribute("name", name);
				req.setAttribute("email", email);
				showRegisterForm(req, resp);
			}
		}
	}

	protected void view(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User currentUser = (User) req.getSession().getAttribute("user");
		if (currentUser == null) {
			// Handle the case where the user is not logged in
			resp.sendRedirect("login.jsp");
			return;
		}

		Long id = Long.parseLong(req.getParameter("id"));
		Noti newNoti = new Noti(currentUser.getId(), id, "view", "This person view your account.");
		notiDAO.createNoti(newNoti);

		notiDAO.seenNoti(currentUser.getId());
		List<UserPhoto> userPhotos = userPhotoDAO.getUserPhotosByUserId(id);

		System.out.println(userPhotos);

		User user = userDAO.getUserById(id);
		Long currentUserId = currentUser.getId();

		List<User> users = userDAO.getAllUser();
		List<Noti> notis = notiDAO.getNotisByReceiverId(currentUserId);
		Collections.reverse(notis);
		int unseenCount = notiDAO.countUnseenNotis(currentUserId);

		// Set attributes for the request
		req.setAttribute("users", users);
		req.setAttribute("notis", notis);
		req.setAttribute("unseenCount", unseenCount);

		req.setAttribute("user", user);
		req.setAttribute("userPhotos", userPhotos);

		RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/flip.jsp");
		dispatcher.forward(req, resp);

	}

	protected void flip(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User currentUser = (User) req.getSession().getAttribute("user");
		if (currentUser == null) {
			// Handle the case where the user is not logged in
			resp.sendRedirect("login.jsp");
			return;
		}

		Long currentUserId = currentUser.getId();

		Long id = Long.parseLong(req.getParameter("id"));

		Noti newNoti = new Noti(currentUser.getId(), id, "flip", "This person flip you.");
		notiDAO.createNoti(newNoti);

		notiDAO.seenNoti(currentUser.getId());
		List<UserPhoto> userPhotos = userPhotoDAO.getUserPhotosByUserId(id);

		User user = userDAO.getUserById(id);
		System.out.println("In Flip");

		List<User> users = userDAO.getAllUser();
		List<Noti> notis = notiDAO.getNotisByReceiverId(currentUserId);
		Collections.reverse(notis);
		int unseenCount = notiDAO.countUnseenNotis(currentUserId);

		// Set attributes for the request
		req.setAttribute("users", users);
		req.setAttribute("notis", notis);
		req.setAttribute("unseenCount", unseenCount);

		req.setAttribute("user", user);
		req.setAttribute("userPhotos", userPhotos);
		RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/flip.jsp");
		dispatcher.forward(req, resp);

	}

	protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long id = Long.parseLong(req.getParameter("id"));
		Long batch_id = Long.parseLong(req.getParameter("batch_id"));
		String name = req.getParameter("name");
		String bio = req.getParameter("bio");
		String phone = req.getParameter("phone");
		String hobby = req.getParameter("hobby");
		String fbLink = req.getParameter("fbLink");
		String igLink = req.getParameter("igLink");
		String ttLink = req.getParameter("ttLink");
		String tgLink = req.getParameter("tgLink");
		String description = req.getParameter("description");
		String old_photo = req.getParameter("old_photo");
		String fileName;
		String message;
		boolean ok = false;

		String birthdayString = req.getParameter("birthday");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date birthday = null;
		try {
			birthday = formatter.parse(birthdayString);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		User updateUser = new User(id, name, old_photo, bio, hobby, description, batch_id, birthday, phone, fbLink,
				tgLink, ttLink, igLink);

		try {
			Part imagePart = req.getPart("photo");
			if (imagePart != null && imagePart.getSize() > 0) {
				fileName = getFileName(imagePart);
				String imageMimeType = imagePart.getContentType();

				System.out.println(imageMimeType);

				if (!ALLOWED_MIME_TYPES.contains(imageMimeType)) {
					req.setAttribute("user", updateUser);
					req.setAttribute("ok", ok);
					req.setAttribute("message", "Unsupported file type or no file uploaded!");
					edit(req, resp);
					return;
				} else {
					if (fileName != null) {
						String uniqueImageName = generateUniqueFileName(fileName);
						imagePart.write(uniqueImageName);

						updateUser.setPhoto(uniqueImageName);
						ok = userDAO.updateUser(updateUser);

						if (ok) {
							System.out.println("Old photo record");
							UserPhoto userPhoto = new UserPhoto(id, old_photo);
							userPhotoDAO.createUserPhoto(userPhoto);
						}
					}

				}
			} else {

				ok = userDAO.updateUser(updateUser);
			}

			if (ok) {

				message = "Update Successfully!";
				req.setAttribute("ok", ok);
				req.setAttribute("message", message);
				profile(id, req, resp);
			} else {
				message = "Update failed";
				req.setAttribute("ok", ok);
				req.setAttribute("user", updateUser);
				edit(req, resp);
			}

		} catch (Exception ex) {
			message = "Error uploading file or processing request: " + ex;
			if (ok) {
				message = "Successfully Updated";
			}
			req.setAttribute("message", message);
			req.setAttribute("ok", ok);
			req.setAttribute("name", updateUser);
			edit(req, resp);

		}

	}

	protected void accept(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User currentUser = (User) req.getSession().getAttribute("user");
		if (currentUser == null) {
			// Handle the case where the user is not logged in
			resp.sendRedirect("login.jsp");
			return;
		}

		Long currentUserId = currentUser.getId();

		Long id = Long.parseLong(req.getParameter("id"));

		Noti newNoti = new Noti(currentUser.getId(), id, "accept", "This person accept you.");
		notiDAO.createNoti(newNoti);
		
		Matches newMatches = new Matches(currentUserId, id);
		matchesDAO.createMatch(newMatches);
		
		
		notiDAO.seenNoti(currentUser.getId());
		List<UserPhoto> userPhotos = userPhotoDAO.getUserPhotosByUserId(id);
		
		User user = userDAO.getUserById(id);
		System.out.println("accept");

		List<User> users = userDAO.getAllUser();
		List<Noti> notis = notiDAO.getNotisByReceiverId(currentUserId);
		Collections.reverse(notis);
		int unseenCount = notiDAO.countUnseenNotis(currentUserId);

		// Set attributes for the request
		req.setAttribute("users", users);
		req.setAttribute("notis", notis);
		req.setAttribute("unseenCount", unseenCount);

		req.setAttribute("user", user);
		req.setAttribute("userPhotos", userPhotos);
		profile(id, req, resp);


	}

	private String getFileName(Part part) {
		String contentDisposition = part.getHeader("content-disposition");
		if (contentDisposition.contains("filename=")) {
			return contentDisposition
					.substring(contentDisposition.indexOf("filename=") + 10, contentDisposition.length() - 1)
					.replace("\"", "");
		}
		return null;
	}

	protected void profile(long user_id, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Long id = user_id;
		System.out.println("ID: " + id); // Debug statement to print the ID
		User user = userDAO.getUserById(id);
		if (user != null) {
			System.out.println("User Name: " + user.getName());
			System.out.println("Batch Name: " + user.getBatch()); // Debug statement to print the User's batch name
		} else {
			System.out.println("User is null"); // Debug statement to indicate that the User is null
		}

		req.setAttribute("user", user);
		RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/profile.jsp");
		dispatcher.forward(req, resp);
	}
	
	protected void match(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // Retrieve the current session user
	    User currentUser = (User) req.getSession().getAttribute("user");
	    if (currentUser == null) {
	        // Handle the case where the user is not logged in
	        resp.sendRedirect("login.jsp");
	        return;
	    }

	    // Retrieve all users from the database
	    List<User> allUsers = userDAO.getAllUser();

	    // Retrieve all matches from the database
	    List<Matches> allMatches = matchesDAO.getAllMatches();

	    // Filter out the current user and users with deletedAt not null
	    List<User> potentialMatches = new ArrayList<>();
	    for (User user : allUsers) {
	        if (!user.getId().equals(currentUser.getId()) ) {
	            boolean isMatched = false;
	            for (Matches match : allMatches) {
	                if (match.getsId().equals(currentUser.getId()) && match.getrId().equals(user.getId()) && match.getDeletedAt() == null) {
	                    isMatched = true;
	                    break;
	                }
	            }
	            if (!isMatched) {
	                potentialMatches.add(user);
	            }
	        }
	    }
	    System.out.println("in Match");
	    System.out.println(potentialMatches);
	    // Set the potential matches as a request attribute
	    req.setAttribute("users", potentialMatches);

	    // Forward to the matches.jsp page
	    RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/matches.jsp");
	    dispatcher.forward(req, resp);
	}

	protected void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long id = Long.parseLong(req.getParameter("id"));
		System.out.println("ID: " + id); // Debug statement to print the ID
		User user = userDAO.getUserById(id);
		if (user != null) {
			System.out.println("User Name: " + user.getName());
			System.out.println("Batch Name: " + user.getBatch()); // Debug statement to print the User's batch name
		} else {
			System.out.println("User is null"); // Debug statement to indicate that the User is null
		}

		List<Batch> batches = batchDAO.getAllBatch();
		req.setAttribute("batches", batches);
		req.setAttribute("user", user);
		RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/edit.jsp");
		dispatcher.forward(req, resp);
	}
	
	protected void unmatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // Retrieve the current session user
	    User currentUser = (User) req.getSession().getAttribute("user");
	    if (currentUser == null) {
	        // Handle the case where the user is not logged in
	        resp.sendRedirect("login.jsp");
	        return;
	    }

	    // Retrieve the sId and rId from the request
	    Long sId = currentUser.getId();
	    Long Id = Long.parseLong(req.getParameter("id"));

	    // Update the match to set the deletedAt timestamp for both directions
	    matchesDAO.unmatch(sId, Id);
	    matchesDAO.unmatch(Id, sId);

	    // Redirect to the matches page
	    
	    System.out.println("In unMatch");
	    
	    match(req, resp);
	}


	private String generateUniqueFileName(String fileName) {
		String fileExtension = "";

		int dotIndex = fileName.lastIndexOf('.');
		if (dotIndex != -1) {
			fileExtension = fileName.substring(dotIndex);
			fileName = fileName.substring(0, dotIndex);
		}

		return fileName + "_" + UUID.randomUUID().toString() + fileExtension;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
