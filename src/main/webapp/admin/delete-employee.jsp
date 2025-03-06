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
    <title>Delete Employee - Payroll Management System</title>
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
                            <a class="nav-link" href="add-employee.jsp">
                                <i class="bi bi-person-plus"></i> Add Employee
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="update-employee.jsp">
                                <i class="bi bi-pencil"></i> Update Employee
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="delete-employee.jsp">
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
                    <h1>Delete Employee</h1>
                </div>

                <div class="form-container">
                    <!-- Search Employee Form -->
                    <form action="../SearchEmployeeServlet" method="get" class="mb-4">
                        <div class="input-group">
                            <input type="text" class="form-control" name="employeeId" 
                                   placeholder="Enter Employee ID" required>
                            <button class="btn btn-primary" type="submit">
                                <i class="bi bi-search"></i> Search
                            </button>
                        </div>
                    </form>

                    <!-- Employee Details Card -->
                    <div class="card mb-4" id="employeeDetails" style="display: none;">
                        <div class="card-header">
                            Employee Details
                        </div>
                        <div class="card-body">
                            <h5 class="card-title" id="empName"></h5>
                            <p class="card-text">
                                <strong>Employee ID:</strong> <span id="empId"></span><br>
                                <strong>Email:</strong> <span id="empEmail"></span><br>
                                <strong>Contact:</strong> <span id="empContact"></span><br>
                                <strong>Salary Grade:</strong> <span id="empGrade"></span>
                            </p>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                                Delete Employee
                            </button>
                        </div>
                    </div>

                    <!-- Delete Confirmation Modal -->
                    <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Confirm Deletion</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <p>Do you really want to delete this employee?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                    <form action="../DeleteEmployeeServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="employeeId" id="deleteEmployeeId">
                                        <button type="submit" class="btn btn-danger">Yes</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Success Modal -->
                    <div class="modal fade" id="successModal" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Success</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <p>Employee has been successfully deleted.</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal"
                                            onclick="window.location.href='dashboard.jsp'">OK</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Show success modal if deletion was successful
        <% if(request.getParameter("deleted") != null) { %>
            var successModal = new bootstrap.Modal(document.getElementById('successModal'));
            successModal.show();
        <% } %>

        // Function to display employee details
        function displayEmployeeDetails(employee) {
            document.getElementById('employeeDetails').style.display = 'block';
            document.getElementById('empName').textContent = employee.fullName;
            document.getElementById('empId').textContent = employee.employeeId;
            document.getElementById('empEmail').textContent = employee.email;
            document.getElementById('empContact').textContent = employee.contactNumber;
            document.getElementById('empGrade').textContent = employee.salaryGrade;
            document.getElementById('deleteEmployeeId').value = employee.employeeId;
        }
    </script>
</body>
</html>
