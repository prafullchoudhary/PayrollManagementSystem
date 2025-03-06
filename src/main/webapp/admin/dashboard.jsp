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
    <title>Admin Dashboard - Payroll Management System</title>
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
                            <a class="nav-link active" href="dashboard.jsp">
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
                    <h1>Employee Dashboard</h1>
                </div>

                <!-- Search Bar -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search by Employee ID or Name..."
                                   id="searchInput" onkeyup="searchEmployees()">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Employee Table -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Contact</th>
                                <th>Salary Grade</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="employeeTableBody">
                            <!-- Sample data -->
                            <tr>
                                <td>1234567</td>
                                <td>John Doe</td>
                                <td>john@example.com</td>
                                <td>9876543210</td>
                                <td>C1</td>
                                <td>
                                    <button class="btn btn-sm btn-primary me-2" onclick="location.href='update-employee.jsp?id=1'">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="confirmDelete(1)">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-end">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function searchEmployees() {
            // Implementation for search functionality
            var input = document.getElementById("searchInput");
            var filter = input.value.toUpperCase();
            var tbody = document.getElementById("employeeTableBody");
            var tr = tbody.getElementsByTagName("tr");

            for (var i = 0; i < tr.length; i++) {
                var tdId = tr[i].getElementsByTagName("td")[0];
                var tdName = tr[i].getElementsByTagName("td")[1];
                if (tdId || tdName) {
                    var txtValueId = tdId.textContent || tdId.innerText;
                    var txtValueName = tdName.textContent || tdName.innerText;
                    if (txtValueId.toUpperCase().indexOf(filter) > -1 || 
                        txtValueName.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function confirmDelete(id) {
            if (confirm("Are you sure you want to delete this employee?")) {
                // Implementation for delete functionality
                console.log("Deleting employee with ID: " + id);
            }
        }
    </script>
</body>
</html>
