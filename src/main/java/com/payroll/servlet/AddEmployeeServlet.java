package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null || 
           !session.getAttribute("userType").equals("Administrator")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get form data
        String fullName = request.getParameter("fullName");
        String employeeId = request.getParameter("employeeId");
        String panNumber = request.getParameter("panNumber");
        String contactNumber = request.getParameter("contactNumber");
        String accountNumber = request.getParameter("accountNumber");
        String email = request.getParameter("email");
        String aadharNumber = request.getParameter("aadharNumber");
        String salaryGrade = request.getParameter("salaryGrade");
        
        // Validate data (server-side validation)
        if(!isValidData(fullName, employeeId, panNumber, contactNumber, 
                       accountNumber, email, aadharNumber, salaryGrade)) {
            request.setAttribute("error", "Invalid data submitted. Please check all fields.");
            request.getRequestDispatcher("admin/add-employee.jsp").forward(request, response);
            return;
        }
        
        // TODO: Add database logic here
        // For now, just redirect back with success message
        session.setAttribute("message", "Employee added successfully!");
        response.sendRedirect("admin/dashboard.jsp");
    }
    
    private boolean isValidData(String fullName, String employeeId, String panNumber,
                              String contactNumber, String accountNumber, String email,
                              String aadharNumber, String salaryGrade) {
        // Validate fullName
        if(fullName == null || fullName.length() > 50) return false;
        
        // Validate employeeId
        if(employeeId == null || !employeeId.matches("\\d{7}")) return false;
        
        // Validate PAN
        if(panNumber == null || !panNumber.matches("[A-Z]{5}[0-9]{4}[A-Z]")) return false;
        
        // Validate contact number
        if(contactNumber == null || !contactNumber.matches("[6-9]\\d{9}")) return false;
        
        // Validate account number
        if(accountNumber == null || !accountNumber.matches("\\d{9,18}")) return false;
        
        // Validate email
        if(email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) return false;
        
        // Validate aadhar
        if(aadharNumber == null || !aadharNumber.matches("\\d{12}")) return false;
        
        // Validate salary grade
        if(salaryGrade == null || !salaryGrade.matches("C[1-4]")) return false;
        
        return true;
    }
}
