package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateEmployeeServlet")
public class UpdateEmployeeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null || 
           !session.getAttribute("userType").equals("Administrator")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String employeeId = request.getParameter("employeeId");
        String fullName = request.getParameter("fullName");
        String contactNumber = request.getParameter("contactNumber");
        String accountNumber = request.getParameter("accountNumber");
        String email = request.getParameter("email");
        String salaryGrade = request.getParameter("salaryGrade");

        // TODO: Add database logic here
        // For now, just redirect back with success message
        session.setAttribute("message", "Employee updated successfully!");
        response.sendRedirect("admin/dashboard.jsp");
    }
}