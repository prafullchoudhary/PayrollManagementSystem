<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("username") == null || !session.getAttribute("userType").equals("Administrator")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee - Payroll Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
        }
        .sidebar-sticky {
            position: sticky;
            top: 0;
            height: calc(100vh - 48px);
            padding-top: .5rem;
            overflow-x: hidden;
            overflow-y: auto;
        }
        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                <div class="sidebar-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="add-employee.jsp">
                                <i class="bi bi-person-plus"></i> Add Employee
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="update-employee.jsp">
                                <i class="bi bi-pencil"></i> Update Employee
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="delete-employee.jsp">
                                <i class="bi bi-person-x"></i> Delete Employee
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../LogoutServlet">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1>Add New Employee</h1>
                </div>

                <div class="form-container">
                    <form action="../AddEmployeeServlet" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" maxlength="50" required>
                            <div class="invalid-feedback">
                                Name is required and cannot exceed 50 characters
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="employeeId" class="form-label">Employee ID</label>
                            <input type="text" class="form-control" id="employeeId" name="employeeId" 
                                   pattern="[0-9]{7}" required>
                            <div class="invalid-feedback">
                                Employee ID must be exactly 7 digits
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="panNumber" class="form-label">PAN Number</label>
                            <input type="text" class="form-control" id="panNumber" name="panNumber" 
                                   pattern="[A-Z]{5}[0-9]{4}[A-Z]" required>
                            <div class="invalid-feedback">
                                PAN must be in format: ABCDE1234F
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="contactNumber" class="form-label">Contact Number</label>
                            <input type="text" class="form-control" id="contactNumber" name="contactNumber" 
                                   pattern="[6-9][0-9]{9}" required>
                            <div class="invalid-feedback">
                                Contact number must be 10 digits and start with 6-9
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="accountNumber" class="form-label">Account Number</label>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                   pattern="[0-9]{9,18}" required>
                            <div class="invalid-feedback">
                                Account number must be between 9 and 18 digits
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <div class="invalid-feedback">
                                Please enter a valid email address
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="aadharNumber" class="form-label">Aadhar Number</label>
                            <input type="text" class="form-control" id="aadharNumber" name="aadharNumber" 
                                   pattern="[0-9]{12}" required>
                            <div class="invalid-feedback">
                                Aadhar number must be exactly 12 digits
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="salaryGrade" class="form-label">Salary Grade</label>
                            <select class="form-select" id="salaryGrade" name="salaryGrade" required>
                                <option value="">Select grade</option>
                                <option value="C1">C1</option>
                                <option value="C2">C2</option>
                                <option value="C3">C3</option>
                                <option value="C4">C4</option>
                            </select>
                            <div class="invalid-feedback">
                                Please select a salary grade
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Add Employee</button>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        } else {
                            // Show confirmation dialog
                            if (!confirm('Do you want to add this employee?')) {
                                event.preventDefault();
                            }
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html>
