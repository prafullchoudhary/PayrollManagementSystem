package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteEmployeeServlet")
public class DeleteEmployeeServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null || 
           !session.getAttribute("userType").equals("Administrator")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String employeeId = request.getParameter("employeeId");
        
        // TODO: Add database logic here
        // For now, just redirect back with success message
        session.setAttribute("message", "Employee deleted successfully!");
        response.sendRedirect("admin/dashboard.jsp?deleted=true");
    }
}
