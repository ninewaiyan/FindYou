package com.findyou.controllers;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import com.findyou.dao.NotiDAO;
import com.findyou.dao.UserDAO;
import com.findyou.models.Batch;
import com.findyou.models.Noti;
import com.findyou.models.User;
import com.mysql.cj.Session;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/home")
public class HomePageController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource(name = "jdbc/findyou_site")
	private DataSource dataSource;

	private UserDAO userDAO;
	private NotiDAO notiDAO;

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		userDAO = new UserDAO(dataSource);
		notiDAO = new NotiDAO(dataSource);
	}

	public HomePageController() {

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String mode = req.getParameter("mode");

		if (mode == null) {
			mode = "HOME";
		}

		switch (mode) {

		case "HOME":
			homePage(req, resp);
			break;

		default:
			homePage(req, resp);
			break;
		}
	}

	protected void homePage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // Retrieve the current session user
	    User currentUser = (User) req.getSession().getAttribute("user");
	    if (currentUser == null) {
	        // Handle the case where the user is not logged in
	        resp.sendRedirect("login.jsp");
	        return;
	    }

	    Long currentUserId = currentUser.getId();

	    // Retrieve users and notifications
	    List<User> users = userDAO.getAllUser();
	    List<Noti> notis = notiDAO.getNotisByReceiverId(currentUserId);
	    Collections.reverse(notis);
	    int unseenCount = notiDAO.countUnseenNotis(currentUserId);

	    // Set attributes for the request
	    req.setAttribute("users", users);
	    req.setAttribute("notis", notis);
	    req.setAttribute("unseenCount", unseenCount);

	    // Forward to the index.jsp page
	    RequestDispatcher dispatcher = req.getRequestDispatcher("template/index.jsp");
	    dispatcher.forward(req, resp);
	}

	
	



	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

}