package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";
    private static final int MAX_LOGIN_ATTEMPTS = 3;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        HttpSession session = request.getSession();
        Integer loginAttempts = (Integer) session.getAttribute("loginAttempts");
        
        if (loginAttempts == null) {
            loginAttempts = 0;
        }
        
        if (loginAttempts >= MAX_LOGIN_ATTEMPTS) {
            request.setAttribute("error", "Maximum login attempts exceeded. Please try again after 24 hours.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        if (userType.equals("Administrator") && username.equals(ADMIN_USERNAME) && password.equals(ADMIN_PASSWORD)) {
            session.setAttribute("username", username);
            session.setAttribute("userType", userType);
            session.setAttribute("loginAttempts", 0);
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            loginAttempts++;
            session.setAttribute("loginAttempts", loginAttempts);
            request.setAttribute("error", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
