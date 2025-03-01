package com.findyou.controllers;

import java.io.IOException;

import javax.sql.DataSource;

import com.findyou.dao.UserDAO;
import com.findyou.models.User;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource(name = "jdbc/findyou_site")
	private DataSource dataSource;

	private UserDAO userDAO;

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		userDAO = new UserDAO(dataSource);
	}

	public LoginController() {

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String mode = req.getParameter("mode");

		if (mode == null) {
			mode = "FORM";
		}

		switch (mode) {

		case "FORM":
			showLoginForm(req, resp);
			break;
		case "LOGIN":
			login(req, resp);
			break;

		case "LOGOUT":
			logout(req, resp);
			break;

		default:
			showLoginForm(req, resp);
			break;
		}
	}

	protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		session.removeAttribute("user");
		// session.invalidate();
		resp.sendRedirect("login");
	}

	protected void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String password = req.getParameter("password");

		boolean loginOk = userDAO.isAuthenticated(email, password);

		if (loginOk) {

			User user = userDAO.getUserByEmail(email);
			System.out.println(email);
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			resp.sendRedirect("home");

		} else {


			req.setAttribute("email", email);
			req.setAttribute("password", password);
			req.setAttribute("message", "Incorrect Username or Password");
			req.setAttribute("ok", loginOk);
			System.out.println("login Error");
			showLoginForm(req, resp);
		}

	}

	protected void showLoginForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = req.getRequestDispatcher("template/user/login.jsp");
		dispatcher.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

}
